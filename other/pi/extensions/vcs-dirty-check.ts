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

function buildDirtyRepoMessage(repo: RepoInfo): string {
	const repoLabel = repo.kind === "jj" ? "jj working copy" : "git working tree";
	return `Session started in a dirty ${repoLabel} at ${repo.root}. Ask me to commit when you want.`;
}

async function checkVCS(pi: ExtensionAPI, ctx: ExtensionContext): Promise<void> {
	if (!ctx.hasUI) return;

	const repo = await detectRepo(ctx.cwd);
	if (!repo) return;

	const isDirty = repo.kind === "jj" ? await hasJJChanges(pi, repo.root) : await hasGitChanges(pi, repo.root);
	if (!isDirty) return;

	ctx.ui.notify(buildDirtyRepoMessage(repo), "warning");
}

export default function vcsDirtyCheck(pi: ExtensionAPI): void {
	pi.on("session_start", async (event, ctx) => {
		if (event.reason === "reload") return;
		await checkVCS(pi, ctx);
	});
}
