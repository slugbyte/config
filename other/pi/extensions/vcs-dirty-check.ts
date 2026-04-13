import { access } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

type RepoInfo = {
	kind: "jj" | "git";
	root: string;
};

async function pathExists(path: string): Promise<boolean> {
	try {
		await access(path);
		return true;
	} catch {
		return false;
	}
}

async function detectRepo(start: string): Promise<RepoInfo | null> {
	let dir = resolve(start);

	while (true) {
		if (await pathExists(join(dir, ".jj"))) {
			return { kind: "jj", root: dir };
		}

		if (await pathExists(join(dir, ".git"))) {
			return { kind: "git", root: dir };
		}

		const parent = dirname(dir);
		if (parent === dir) return null;
		dir = parent;
	}
}

async function hasJJChanges(pi: ExtensionAPI, root: string): Promise<boolean> {
	const result = await pi.exec("jj", ["diff", "--summary"], {
		cwd: root,
		timeout: 5000,
	});

	if (result.code !== 0) return false;
	return result.stdout.trim().length > 0;
}

async function hasGitChanges(pi: ExtensionAPI, root: string): Promise<boolean> {
	const result = await pi.exec("git", ["status", "--porcelain"], {
		cwd: root,
		timeout: 5000,
	});

	if (result.code !== 0) return false;
	return result.stdout.trim().length > 0;
}

function buildCommitPrompt(repo: RepoInfo): string {
	const commitAction =
		repo.kind === "jj"
			? "describe the current change and create a new one with `vcommit`"
			: "create a commit with `vcommit`";

	return [
		`The ${repo.kind} repo at ${repo.root} has uncommitted changes.`,
		"Please inspect the current repo state and commit the pending work on my behalf.",
		"Use `vstate` first.",
		`Then ${commitAction}.`,
		"Write the commit or change description yourself from the diff and recent conversation context.",
		"Do not ask me for a commit message unless the changes are ambiguous or risky.",
	].join("\n");
}

function requestAgentCommit(pi: ExtensionAPI, ctx: ExtensionContext, repo: RepoInfo): void {
	const prompt = buildCommitPrompt(repo);

	if (ctx.isIdle()) {
		pi.sendUserMessage(prompt);
	} else {
		pi.sendUserMessage(prompt, { deliverAs: "followUp" });
	}
}

async function checkVCS(pi: ExtensionAPI, ctx: ExtensionContext): Promise<void> {
	if (!ctx.hasUI) return;

	const repo = await detectRepo(ctx.cwd);
	if (!repo) return;

	const isDirty = repo.kind === "jj" ? await hasJJChanges(pi, repo.root) : await hasGitChanges(pi, repo.root);
	if (!isDirty) return;

	const title = repo.kind === "jj" ? "Dirty jj working copy" : "Dirty git working tree";
	const message =
		repo.kind === "jj"
			? "The working copy has changes. Ask pi to inspect them and run `vcommit` for you?"
			: "The repo has uncommitted changes. Ask pi to inspect them and run `vcommit` for you?";

	const shouldCommit = await ctx.ui.confirm(title, message);
	if (!shouldCommit) return;

	ctx.ui.notify(`Asking pi to commit ${repo.kind} changes...`, "info");
	requestAgentCommit(pi, ctx, repo);
}

export default function vcsDirtyCheck(pi: ExtensionAPI): void {
	pi.on("session_start", async (event, ctx) => {
		if (event.reason === "reload") return;
		await checkVCS(pi, ctx);
	});
}
