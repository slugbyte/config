/**
 * Adapted from:
 * https://github.com/hjanuschka/shitty-extensions/blob/main/extensions/usage-bar.ts
 *
 * Local changes:
 * - Uses the local `ai-usage --json` CLI as the data source.
 * - Renders as an above-editor widget instead of modifying the status line.
 */

import type { ExtensionAPI, ExtensionContext, Theme } from "@mariozechner/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@mariozechner/pi-tui";

type Provider = "anthropic" | "openai";
type ErrorType = "none" | "rate_limit" | "auth" | "endpoint" | "network" | "unknown" | "missing_credentials";

interface ProviderUsage {
	session_pct: number;
	weekly_pct: number;
	session_resets_at: string;
	weekly_resets_at: string;
	updated_at_ms: number;
}

interface ProviderReport {
	provider: Provider;
	label: string;
	usage: ProviderUsage | null;
	stale: boolean;
	error_type: ErrorType;
	error_message: string;
	consecutive_failures: number;
	summary: string;
}

interface UsageSnapshot {
	selected_provider: Provider;
	generated_at_ms: number;
	providers: Record<Provider, ProviderReport>;
}

const REFRESH_INTERVAL_MS = 60_000;
const COMMAND_TIMEOUT_MS = 15_000;
const WIDGET_KEY = "usage-bar";

function formatCountdown(reset_at: string): string {
	if (!reset_at) return "?";
	const diff_ms = new Date(reset_at).getTime() - Date.now();
	if (!Number.isFinite(diff_ms) || diff_ms <= 0) return "now";

	const diff_minutes = Math.floor(diff_ms / 60_000);
	if (diff_minutes < 60) return `${diff_minutes}m`;

	const hours = Math.floor(diff_minutes / 60);
	const minutes = diff_minutes % 60;
	if (hours < 24) return minutes > 0 ? `${hours}h${minutes.toString().padStart(2, "0")}m` : `${hours}h`;

	const days = Math.floor(hours / 24);
	return `${days}d${hours % 24}h`;
}

function usageColor(theme: Theme, percent: number, text: string): string {
	if (percent >= 90) return theme.fg("error", text);
	if (percent >= 75) return theme.fg("warning", text);
	return theme.fg("success", text);
}

function providerName(provider: Provider): string {
	return provider === "anthropic" ? "Claude" : "OpenAI";
}

function providerPeriodLabel(provider: Provider, compact: boolean): string {
	if (provider === "anthropic") return compact ? "w" : "week";
	return compact ? "d" : "day";
}

function errorText(report: ProviderReport): string {
	if (report.error_type === "missing_credentials") return "auth";
	if (report.error_type === "rate_limit") return "429";
	if (report.error_message.trim().length > 0) return report.error_message.trim();
	return report.error_type;
}

function renderProvider(report: ProviderReport, selected_provider: Provider, theme: Theme, compact: boolean): string {
	const selected = report.provider === selected_provider;
	const bullet = selected ? theme.fg("accent", "●") : theme.fg("dim", "○");
	const name = selected ? theme.fg("text", providerName(report.provider)) : theme.fg("muted", providerName(report.provider));

	if (!report.usage) {
		return `${bullet} ${name} ${theme.fg("warning", errorText(report))}`;
	}

	const period_label = providerPeriodLabel(report.provider, compact);
	const stale = report.stale ? theme.fg("warning", "~") : "";
	const period = usageColor(theme, report.usage.weekly_pct, `${report.usage.weekly_pct}%${compact ? period_label : ` ${period_label}`}`);
	const session = usageColor(theme, report.usage.session_pct, `${report.usage.session_pct}%${compact ? "n" : " now"}`);
	const reset = theme.fg("dim", formatCountdown(report.usage.session_resets_at));
	const spacer = theme.fg("dim", " ");

	return `${bullet} ${name}${stale ? `${spacer}${stale}` : ""}${spacer}${period}${spacer}${session}${spacer}${reset}`;
}

function buildWidgetLines(snapshot: UsageSnapshot | undefined, latest_error: string | undefined, width: number, theme: Theme): string[] {
	const title = theme.fg("dim", "AI usage");

	if (!snapshot) {
		if (latest_error) {
			return [truncateToWidth(`${title} ${theme.fg("warning", latest_error)}`, width)];
		}
		return [truncateToWidth(`${title} ${theme.fg("muted", "refreshing...")}`, width)];
	}

	const providers: Provider[] = ["anthropic", "openai"];
	const full_parts = providers.map((provider) => renderProvider(snapshot.providers[provider], snapshot.selected_provider, theme, false));
	const compact_parts = providers.map((provider) => renderProvider(snapshot.providers[provider], snapshot.selected_provider, theme, true));
	const divider = theme.fg("dim", " | ");
	const full_line = `${title} ${full_parts.join(divider)}`;
	if (visibleWidth(full_line) <= width) {
		return [truncateToWidth(full_line, width)];
	}

	const compact_line = `${title} ${compact_parts.join(divider)}`;
	if (visibleWidth(compact_line) <= width) {
		return [truncateToWidth(compact_line, width)];
	}

	return [
		truncateToWidth(title, width),
		...compact_parts.map((part) => truncateToWidth(part, width)),
	];
}

function summarizeError(stdout: string, stderr: string): string {
	const text = `${stderr}\n${stdout}`.trim();
	if (text.length === 0) return "refresh failed";
	const line = text.split("\n").find((value) => value.trim().length > 0) ?? text;
	return line.length > 80 ? `${line.slice(0, 79)}…` : line;
}

function extractJsonError(stdout: string): string | undefined {
	try {
		const parsed = JSON.parse(stdout) as { error?: unknown };
		if (typeof parsed.error === "string" && parsed.error.trim().length > 0) {
			return parsed.error.trim();
		}
	} catch {}
	return undefined;
}

export default function usageBar(pi: ExtensionAPI) {
	let refresh_timer: ReturnType<typeof setInterval> | undefined;
	let snapshot: UsageSnapshot | undefined;
	let latest_error: string | undefined;
	let refresh_in_flight = false;
	let widget_ctx: ExtensionContext | undefined;
	let visible = false;

	function installWidget(ctx: ExtensionContext): void {
		widget_ctx = ctx;
		if (!visible) {
			ctx.ui.setWidget(WIDGET_KEY, undefined);
			return;
		}
		ctx.ui.setWidget(
			WIDGET_KEY,
			(_tui, theme) => ({
				render(width: number): string[] {
					return buildWidgetLines(snapshot, latest_error, width, theme);
				},
				invalidate() {},
			}),
			{ placement: "aboveEditor" },
		);
	}

	async function refresh(ctx: ExtensionContext): Promise<void> {
		if (!visible || refresh_in_flight) return;
		refresh_in_flight = true;

		try {
			const result = await pi.exec("ai-usage", ["--json"], { timeout: COMMAND_TIMEOUT_MS });
			if (result.code !== 0) {
				latest_error = extractJsonError(result.stdout) ?? summarizeError(result.stdout, result.stderr);
				installWidget(ctx);
				return;
			}

			const parsed = JSON.parse(result.stdout) as UsageSnapshot & { error?: unknown };
			if (typeof parsed.error === "string" && parsed.error.trim().length > 0) {
				latest_error = parsed.error.trim();
				installWidget(ctx);
				return;
			}

			snapshot = parsed;
			latest_error = undefined;
			installWidget(ctx);
		} catch (error) {
			latest_error = error instanceof Error ? error.message : "refresh failed";
			installWidget(ctx);
		} finally {
			refresh_in_flight = false;
		}
	}

	function clearRefreshTimer(): void {
		if (!refresh_timer) return;
		clearInterval(refresh_timer);
		refresh_timer = undefined;
	}

	function startRefreshTimer(): void {
		if (refresh_timer || !widget_ctx || !visible) return;
		refresh_timer = setInterval(() => {
			if (!widget_ctx || !visible) return;
			void refresh(widget_ctx);
		}, REFRESH_INTERVAL_MS);
	}

	async function setVisible(ctx: ExtensionContext, nextVisible: boolean): Promise<void> {
		visible = nextVisible;
		if (!visible) {
			clearRefreshTimer();
			installWidget(ctx);
			return;
		}

		snapshot = undefined;
		latest_error = undefined;
		installWidget(ctx);
		await refresh(ctx);
		startRefreshTimer();
	}

	pi.on("session_start", async (_event, ctx) => {
		clearRefreshTimer();
		widget_ctx = undefined;
		snapshot = undefined;
		latest_error = undefined;
		visible = false;
		if (!ctx.hasUI) return;
		installWidget(ctx);
	});

	pi.on("session_shutdown", async () => {
		clearRefreshTimer();
		widget_ctx = undefined;
		visible = false;
	});

	pi.registerCommand("usage-widget", {
		description: "Toggle the AI usage widget",
		handler: async (args, ctx) => {
			if (!ctx.hasUI) return;
			const action = args.trim().toLowerCase();
			if (action === "on") {
				await setVisible(ctx, true);
			} else if (action === "off") {
				await setVisible(ctx, false);
			} else if (action === "" || action === "toggle") {
				await setVisible(ctx, !visible);
			} else {
				ctx.ui.notify("Usage: /usage-widget [on|off|toggle]", "error");
				return;
			}

			ctx.ui.notify(visible ? "AI usage widget enabled" : "AI usage widget disabled", "info");
		},
	});
}
