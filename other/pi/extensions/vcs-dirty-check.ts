import { execSync } from "node:child_process";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

function run(cmd: string, cwd: string): string {
	try {
		return execSync(cmd, { cwd, encoding: "utf-8", timeout: 5000 }).trim();
	} catch {
		return "";
	}
}

function detectVCS(cwd: string): "jj" | "git" | null {
	const result = run("vdetect", cwd);
	if (result.startsWith("jj ")) return "jj";
	if (result.startsWith("git ")) return "git";
	return null;
}

function hasJJChanges(cwd: string): boolean {
	const diff = run("jj diff --stat", cwd);
	return diff.length > 0;
}

function hasGitChanges(cwd: string): boolean {
	const staged = run("git diff --cached --quiet; echo $?", cwd);
	const unstaged = run("git diff --quiet HEAD; echo $?", cwd);
	const untracked = run("git ls-files --others --exclude-standard", cwd);
	return staged === "1" || unstaged === "1" || untracked.length > 0;
}

async function checkVCS(pi: ExtensionAPI, ctx: ExtensionContext): Promise<void> {
	if (!ctx.hasUI) return;

	const cwd = ctx.cwd;
	const vcs = detectVCS(cwd);
	if (!vcs) return;

	if (vcs === "jj") {
		if (!hasJJChanges(cwd)) return;
		const desc = await ctx.ui.confirm(
			"Undescribed jj changes",
			"The working copy has changes. Describe and create a new change?",
		);
		if (!desc) return;
		const message = await ctx.ui.input("Change description:");
		if (!message) return;
		run(`vcommit "${message.replace(/"/g, '\\"')}"`, cwd);
		ctx.ui.notify("Change described and new change created.", "info");
	} else {
		if (!hasGitChanges(cwd)) return;
		const commit = await ctx.ui.confirm(
			"Uncommitted git changes",
			"The working tree has changes. Commit before proceeding?",
		);
		if (!commit) return;
		const message = await ctx.ui.input("Commit message:");
		if (!message) return;
		run(`vcommit "${message.replace(/"/g, '\\"')}"`, cwd);
		ctx.ui.notify("Changes committed.", "info");
	}
}

export default function vcsDirtyCheck(pi: ExtensionAPI): void {
	pi.on("session_start", async (event, ctx) => {
		if (event.reason === "reload") return;
		await checkVCS(pi, ctx);
	});
}
