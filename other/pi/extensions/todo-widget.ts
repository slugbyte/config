/**
 * Local todo widget extension.
 *
 * Displays a compact summary plus incomplete todos below the editor.
 * Control with `/tasks all|<number>|next|prev|off`.
 */

import type { ExtensionAPI, ExtensionContext, Theme } from "@mariozechner/pi-coding-agent";
import { truncateToWidth } from "@mariozechner/pi-tui";

type Todo = {
	id: number;
	text: string;
	done: boolean;
};

type TodoDetails = {
	action: "list" | "add" | "toggle" | "clear";
	todos: Todo[];
	nextId: number;
	error?: string;
};

const WIDGET_KEY = "todo-widget";
const DEFAULT_MAX_VISIBLE_INCOMPLETE = 6;

function reconstructTodos(ctx: ExtensionContext): Todo[] {
	let todos: Todo[] = [];

	for (const entry of ctx.sessionManager.getBranch()) {
		if (entry.type !== "message") continue;
		const message = entry.message;
		if (message.role !== "toolResult" || message.toolName !== "todo") continue;

		const details = message.details as TodoDetails | undefined;
		if (!details?.todos) continue;
		todos = details.todos;
	}

	return todos;
}

function buildWidgetLines(
	todos: Todo[],
	width: number,
	theme: Theme,
	showAll: boolean,
	maxVisibleIncomplete: number,
	pageIndex: number,
): string[] {
	const totalCount = todos.length;
	const completedCount = todos.filter((todo) => todo.done).length;
	const incompleteTodos = todos.filter((todo) => !todo.done);
	const lines: string[] = [];

	lines.push(truncateToWidth(theme.fg("accent", `Todos ${completedCount}/${totalCount} complete`), width));

	if (totalCount === 0) {
		lines.push(truncateToWidth(theme.fg("dim", "No todos yet."), width));
		return lines;
	}

	if (incompleteTodos.length === 0) {
		lines.push(truncateToWidth(theme.fg("success", "✓ No incomplete todos."), width));
		return lines;
	}

	if (showAll) {
		lines.push(truncateToWidth(theme.fg("dim", `Showing all ${incompleteTodos.length} incomplete todo(s)`), width));
		for (const todo of incompleteTodos) {
			const line = `${theme.fg("dim", "○")} ${theme.fg("accent", `#${todo.id}`)} ${theme.fg("text", todo.text)}`;
			lines.push(truncateToWidth(line, width));
		}
		return lines;
	}

	const pageCount = Math.max(1, Math.ceil(incompleteTodos.length / maxVisibleIncomplete));
	const clampedPageIndex = Math.max(0, Math.min(pageIndex, pageCount - 1));
	const startIndex = clampedPageIndex * maxVisibleIncomplete;
	const visibleTodos = incompleteTodos.slice(startIndex, startIndex + maxVisibleIncomplete);
	const endIndex = startIndex + visibleTodos.length;

	lines.push(
		truncateToWidth(
			theme.fg("dim", `Showing ${startIndex + 1}-${endIndex} of ${incompleteTodos.length} incomplete (page ${clampedPageIndex + 1}/${pageCount})`),
			width,
		),
	);

	for (const todo of visibleTodos) {
		const line = `${theme.fg("dim", "○")} ${theme.fg("accent", `#${todo.id}`)} ${theme.fg("text", todo.text)}`;
		lines.push(truncateToWidth(line, width));
	}

	return lines;
}

export default function todoWidget(pi: ExtensionAPI): void {
	let visible = true;
	let todos: Todo[] = [];
	let showAll = false;
	let maxVisibleIncomplete = DEFAULT_MAX_VISIBLE_INCOMPLETE;
	let pageIndex = 0;

	function getPageCount(): number {
		const incompleteCount = todos.filter((todo) => !todo.done).length;
		return Math.max(1, Math.ceil(incompleteCount / maxVisibleIncomplete));
	}

	function clampPageIndex(): void {
		if (showAll) {
			pageIndex = 0;
			return;
		}
		pageIndex = Math.max(0, Math.min(pageIndex, getPageCount() - 1));
	}

	function renderOrClearWidget(ctx: ExtensionContext): void {
		clampPageIndex();
		if (!ctx.hasUI || !visible) {
			ctx.ui.setWidget(WIDGET_KEY, undefined);
			return;
		}

		ctx.ui.setWidget(
			WIDGET_KEY,
			(_tui, theme) => ({
				render(width: number): string[] {
					return buildWidgetLines(todos, width, theme, showAll, maxVisibleIncomplete, pageIndex);
				},
				invalidate() {},
			}),
			{ placement: "belowEditor" },
		);
	}

	function syncFromSession(ctx: ExtensionContext): void {
		todos = reconstructTodos(ctx);
		clampPageIndex();
		renderOrClearWidget(ctx);
	}

	pi.on("session_start", async (_event, ctx) => {
		visible = true;
		showAll = false;
		maxVisibleIncomplete = DEFAULT_MAX_VISIBLE_INCOMPLETE;
		pageIndex = 0;
		syncFromSession(ctx);
	});

	pi.on("session_tree", async (_event, ctx) => {
		syncFromSession(ctx);
	});

	pi.on("tool_result", async (event, ctx) => {
		if ((event as { toolName?: string }).toolName !== "todo") return;
		const details = (event as { details?: TodoDetails }).details;
		if (details?.todos) {
			todos = details.todos;
			renderOrClearWidget(ctx);
			return;
		}
		syncFromSession(ctx);
	});

	pi.on("session_shutdown", async (_event, ctx) => {
		if (ctx.hasUI) {
			ctx.ui.setWidget(WIDGET_KEY, undefined);
		}
	});

	pi.registerCommand("tasks", {
		description: "Control the todo widget below the editor",
		handler: async (args, ctx) => {
			if (!ctx.hasUI) {
				ctx.ui.notify("/tasks requires interactive mode", "error");
				return;
			}

			const action = args.trim().toLowerCase();
			if (action === "off") {
				visible = false;
				renderOrClearWidget(ctx);
				ctx.ui.notify("Todo widget disabled", "info");
				return;
			}

			if (action === "all") {
				visible = true;
				showAll = true;
				pageIndex = 0;
				renderOrClearWidget(ctx);
				ctx.ui.notify("Todo widget set to show all incomplete todos", "info");
				return;
			}

			if (action === "next") {
				visible = true;
				if (showAll) {
					ctx.ui.notify("Todo widget is showing all incomplete todos", "info");
					return;
				}
				const nextPageIndex = Math.min(pageIndex + 1, getPageCount() - 1);
				if (nextPageIndex === pageIndex) {
					ctx.ui.notify("Already on the last todo page", "info");
					return;
				}
				pageIndex = nextPageIndex;
				renderOrClearWidget(ctx);
				ctx.ui.notify(`Todo widget page ${pageIndex + 1}/${getPageCount()}`, "info");
				return;
			}

			if (action === "prev") {
				visible = true;
				if (showAll) {
					ctx.ui.notify("Todo widget is showing all incomplete todos", "info");
					return;
				}
				const nextPageIndex = Math.max(pageIndex - 1, 0);
				if (nextPageIndex === pageIndex) {
					ctx.ui.notify("Already on the first todo page", "info");
					return;
				}
				pageIndex = nextPageIndex;
				renderOrClearWidget(ctx);
				ctx.ui.notify(`Todo widget page ${pageIndex + 1}/${getPageCount()}`, "info");
				return;
			}

			const parsedCount = Number.parseInt(action, 10);
			if (Number.isFinite(parsedCount) && `${parsedCount}` === action && parsedCount > 0) {
				visible = true;
				showAll = false;
				maxVisibleIncomplete = parsedCount;
				pageIndex = 0;
				renderOrClearWidget(ctx);
				ctx.ui.notify(`Todo widget page size set to ${maxVisibleIncomplete}`, "info");
				return;
			}

			ctx.ui.notify("Usage: /tasks (all|<number>|next|prev|off)", "error");
		},
	});
}
