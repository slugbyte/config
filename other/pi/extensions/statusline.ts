import { basename } from "node:path";
import type { AssistantMessage } from "@mariozechner/pi-ai";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@mariozechner/pi-tui";

function formatCount(value: number): string {
	if (value < 1_000) return `${value}`;
	if (value < 10_000) return `${(value / 1_000).toFixed(1)}k`;
	if (value < 1_000_000) return `${Math.round(value / 1_000)}k`;
	return `${(value / 1_000_000).toFixed(1)}M`;
}

function formatCost(value: number): string {
	if (value <= 0) return "$0.00";
	if (value < 0.01) return `$${value.toFixed(4)}`;
	if (value < 1) return `$${value.toFixed(3)}`;
	return `$${value.toFixed(2)}`;
}

function formatDuration(duration_ms: number): string {
	const total_seconds = Math.max(0, Math.floor(duration_ms / 1000));
	const minutes = Math.floor(total_seconds / 60);
	const seconds = total_seconds % 60;
	return `${minutes}:${seconds.toString().padStart(2, "0")}`;
}

function getUsageTotals(ctx: ExtensionContext): { turnCount: number; inputTokens: number; outputTokens: number; cost: number } {
	let turnCount = 0;
	let inputTokens = 0;
	let outputTokens = 0;
	let cost = 0;

	for (const entry of ctx.sessionManager.getBranch()) {
		if (entry.type !== "message") continue;
		if (entry.message.role !== "assistant") continue;

		const message = entry.message as AssistantMessage;
		turnCount += 1;
		inputTokens += message.usage.input;
		outputTokens += message.usage.output;
		cost += message.usage.cost.total;
	}

	return { turnCount, inputTokens, outputTokens, cost };
}

export default function statusline(pi: ExtensionAPI) {
	let activeTurnStartedAt: number | undefined;
	let lastTurnDurationMs = 0;
	const sessionStartedAt = Date.now();

	function installFooter(ctx: ExtensionContext): void {
		ctx.ui.setFooter((tui, theme) => {
			const interval = setInterval(() => tui.requestRender(), 1000);

			return {
				dispose() {
					clearInterval(interval);
				},
				invalidate() {},
				render(width: number): string[] {
					const cwdPath = process.cwd();
					const cwd = basename(cwdPath) || cwdPath;
					const model = ctx.model?.id ?? "no-model";
					const thinkingLevel = pi.getThinkingLevel();
					const sessionName = pi.getSessionName() ?? "unnamed";
					const contextUsage = ctx.getContextUsage();
					const usageTotals = getUsageTotals(ctx);
					const now = Date.now();
					const turnElapsedMs = activeTurnStartedAt ? now - activeTurnStartedAt : lastTurnDurationMs;
					const totalElapsedMs = now - sessionStartedAt;
					const turnCount = usageTotals.turnCount + (activeTurnStartedAt ? 1 : 0);

					const separator = theme.fg("dim", " ");
					const parenOpen = theme.fg("dim", "(");
					const parenClose = theme.fg("dim", ")");

					const contextPercent = contextUsage?.percent;
					let contextColor: "success" | "warning" | "error" | "muted" = "muted";
					if (contextPercent != null) {
						if (contextPercent >= 90) contextColor = "error";
						else if (contextPercent >= 75) contextColor = "warning";
						else contextColor = "success";
					}

					const contextPercentText = contextUsage?.percent != null ? `${Math.floor(contextUsage.percent)}%` : "?%";
					const contextTokensText = contextUsage?.tokens != null ? formatCount(contextUsage.tokens) : "?";
					const contextPart =
						parenOpen +
						theme.fg("dim", "ctx ") +
						theme.fg(contextColor, contextPercentText) +
						theme.fg("dim", `/${contextTokensText}`) +
						parenClose;
					const totalsPart =
						parenOpen +
						theme.fg("dim", "tok ") +
						theme.fg("muted", formatCount(usageTotals.inputTokens)) +
						theme.fg("dim", ":") +
						theme.fg("muted", formatCount(usageTotals.outputTokens)) +
						theme.fg("dim", "/") +
						theme.fg("muted", formatCost(usageTotals.cost)) +
						parenClose;
					const sessionPart = parenOpen + theme.fg("muted", sessionName) + parenClose;

					const left = [
						theme.fg("dim", cwd),
						theme.fg("text", model) + theme.fg("dim", "/") + theme.fg("muted", thinkingLevel),
						contextPart,
						totalsPart,
						sessionPart,
					].join(separator);

					const right = [
						theme.fg("accent", "turn ") + theme.fg(activeTurnStartedAt ? "warning" : "muted", `${turnCount}/${formatDuration(turnElapsedMs)}`),
						theme.fg("accent", "total ") + theme.fg("muted", formatDuration(totalElapsedMs)),
					].join(separator);

					const minimumPad = 1;
					const availableLeftWidth = Math.max(0, width - visibleWidth(right) - minimumPad);
					const finalLeft = truncateToWidth(left, availableLeftWidth);
					const padWidth = Math.max(minimumPad, width - visibleWidth(finalLeft) - visibleWidth(right));
					const pad = " ".repeat(padWidth);

					return [truncateToWidth(finalLeft + pad + right, width)];
				},
			};
		});
	}

	pi.on("session_start", async (_event, ctx) => {
		installFooter(ctx);
	});

	pi.on("turn_start", async (_event, ctx) => {
		activeTurnStartedAt = Date.now();
		installFooter(ctx);
	});

	pi.on("turn_end", async (_event, ctx) => {
		if (activeTurnStartedAt) {
			lastTurnDurationMs = Date.now() - activeTurnStartedAt;
			activeTurnStartedAt = undefined;
		}
		installFooter(ctx);
	});
}
