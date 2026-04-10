import { basename } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

const MAX_NAME_PROMPTS = 16;

function getPlaceholder(ctx: ExtensionContext): string {
	const cwd = basename(ctx.cwd) || ctx.cwd;
	return `${cwd}-work`;
}

async function ensureSessionName(pi: ExtensionAPI, ctx: ExtensionContext): Promise<void> {
	const currentName = pi.getSessionName()?.trim();
	if (currentName) {
		return;
	}
	if (!ctx.hasUI) {
		return;
	}

	const placeholder = getPlaceholder(ctx);

	for (let attempt = 0; attempt < MAX_NAME_PROMPTS; attempt += 1) {
		const value = await ctx.ui.input("Name this session:", placeholder);
		const nextName = value?.trim() ?? "";
		if (nextName.length > 0) {
			pi.setSessionName(nextName);
			ctx.ui.notify(`Session named: ${nextName}`, "info");
			return;
		}
		ctx.ui.notify("A session name is required.", "warning");
	}

	const fallbackName = `${basename(ctx.cwd) || "session"}-${new Date().toISOString().slice(0, 16).replace("T", "-")}`;
	pi.setSessionName(fallbackName);
	ctx.ui.notify(`Session name required. Applied fallback: ${fallbackName}`, "warning");
}

export default function requireSessionName(pi: ExtensionAPI): void {
	pi.on("session_start", async (event, ctx) => {
		if (event.reason === "reload") {
			return;
		}
		await ensureSessionName(pi, ctx);
	});
}
