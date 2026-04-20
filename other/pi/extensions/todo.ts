/**
 * Todo Extension - Stateful todo tool with widget and manual viewer.
 *
 * This extension:
 * - Registers a `todo` tool for the LLM to manage todos.
 * - Displays a compact todo widget below the editor.
 * - Registers a `/todo` command for widget control and full-list viewing.
 *
 * State is stored in tool result details (not external files), which allows
 * proper branching - when you branch, the todo state is automatically
 * correct for that point in history.
 */

import { StringEnum } from "@mariozechner/pi-ai";
import type { ExtensionAPI, ExtensionContext, Theme } from "@mariozechner/pi-coding-agent";
import { matchesKey, Text, truncateToWidth } from "@mariozechner/pi-tui";
import { Type } from "@sinclair/typebox";

interface Todo {
	id: number;
	text: string;
	done: boolean;
}

interface TodoDetails {
	action: "list" | "add" | "toggle" | "remove" | "edit" | "clear";
	todos: Todo[];
	nextId: number;
	error?: string;
	addedId?: number;
	addedText?: string;
	addedIds?: number[];
	addedTexts?: string[];
	toggledId?: number;
	toggledText?: string;
	toggledDone?: boolean;
	removedId?: number;
	removedText?: string;
	editedId?: number;
	editedOldText?: string;
	editedNewText?: string;
	clearedCount?: number;
}

type FilterMode = "open" | "done";

const TodoParams = Type.Object({
	action: StringEnum(["list", "add", "toggle", "remove", "edit", "clear"] as const),
	text: Type.Optional(Type.String({ description: "Todo text (for add or edit)" })),
	texts: Type.Optional(Type.Array(Type.String(), { description: "Todo texts (for adding multiple todos at once)" })),
	id: Type.Optional(Type.Number({ description: "Todo ID (for toggle, remove, or edit)" })),
});

const WIDGET_KEY = "todo-widget";
const DEFAULT_MAX_VISIBLE_TODOS = 6;

function cloneTodos(todos: Todo[]): Todo[] {
	return todos.map((t) => ({ ...t }));
}

function reconstructTodos(ctx: ExtensionContext): { todos: Todo[]; nextId: number } {
	let todos: Todo[] = [];
	let nextId = 1;

	for (const entry of ctx.sessionManager.getBranch()) {
		if (entry.type !== "message") continue;
		const message = entry.message;
		if (message.role !== "toolResult" || message.toolName !== "todo") continue;

		const details = message.details as TodoDetails | undefined;
		if (!details) continue;
		todos = cloneTodos(details.todos);
		nextId = details.nextId;
	}

	return { todos, nextId };
}

function getFilteredTodos(todos: Todo[], filterMode: FilterMode): Todo[] {
	return todos.filter((todo) => (filterMode === "open" ? !todo.done : todo.done));
}

function renderTodoLine(todo: Todo, theme: Theme, width: number): string {
	const marker = todo.done ? theme.fg("success", "✓") : theme.fg("dim", "○");
	const text = todo.done ? theme.fg("dim", todo.text) : theme.fg("text", todo.text);
	const line = `${marker} ${theme.fg("accent", `#${todo.id}`)} ${text}`;
	return truncateToWidth(line, width);
}

function buildWidgetLines(
	todos: Todo[],
	width: number,
	theme: Theme,
	filterMode: FilterMode,
	maxVisibleTodos: number,
	pageIndex: number,
): string[] {
	const totalCount = todos.length;
	const completedCount = todos.filter((todo) => todo.done).length;
	const filteredTodos = getFilteredTodos(todos, filterMode);
	const lines: string[] = [];

	lines.push(truncateToWidth(theme.fg("accent", `Todos ${completedCount}/${totalCount} complete`), width));

	if (totalCount === 0) {
		lines.push(truncateToWidth(theme.fg("dim", "No todos yet."), width));
		return lines;
	}

	if (filteredTodos.length === 0) {
		const emptyMessage = filterMode === "open" ? theme.fg("success", "✓ No open todos.") : theme.fg("dim", "No done todos.");
		lines.push(truncateToWidth(emptyMessage, width));
		return lines;
	}

	const pageCount = Math.max(1, Math.ceil(filteredTodos.length / maxVisibleTodos));
	const clampedPageIndex = Math.max(0, Math.min(pageIndex, pageCount - 1));
	const startIndex = clampedPageIndex * maxVisibleTodos;
	const visibleTodos = filteredTodos.slice(startIndex, startIndex + maxVisibleTodos);

	lines.push(
		truncateToWidth(
			theme.fg("dim", `${visibleTodos.length} shown / ${filteredTodos.length} ${filterMode} (page ${clampedPageIndex + 1}/${pageCount})`),
			width,
		),
	);

	for (const todo of visibleTodos) {
		lines.push(renderTodoLine(todo, theme, width));
	}

	return lines;
}

/**
 * UI component for `/todo view`.
 */
class TodoListComponent {
	private todos: Todo[];
	private theme: Theme;
	private onClose: () => void;
	private cachedWidth?: number;
	private cachedLines?: string[];

	constructor(todos: Todo[], theme: Theme, onClose: () => void) {
		this.todos = todos;
		this.theme = theme;
		this.onClose = onClose;
	}

	handleInput(data: string): void {
		if (matchesKey(data, "escape") || matchesKey(data, "ctrl+c")) {
			this.onClose();
		}
	}

	render(width: number): string[] {
		if (this.cachedLines && this.cachedWidth === width) {
			return this.cachedLines;
		}

		const lines: string[] = [];
		const th = this.theme;

		lines.push("");
		const title = th.fg("accent", " Tasks ");
		const headerLine =
			th.fg("borderMuted", "─".repeat(3)) + title + th.fg("borderMuted", "─".repeat(Math.max(0, width - 10)));
		lines.push(truncateToWidth(headerLine, width));
		lines.push("");

		if (this.todos.length === 0) {
			lines.push(truncateToWidth(`  ${th.fg("dim", "No todos yet. Ask the agent to add some!")}`, width));
		} else {
			const done = this.todos.filter((todo) => todo.done).length;
			const total = this.todos.length;
			lines.push(truncateToWidth(`  ${th.fg("muted", `${done}/${total} completed`)}`, width));
			lines.push("");

			for (const todo of this.todos) {
				lines.push(truncateToWidth(`  ${renderTodoLine(todo, th, Math.max(0, width - 2))}`, width));
			}
		}

		lines.push("");
		lines.push(truncateToWidth(`  ${th.fg("dim", "Press Escape to close")}`, width));
		lines.push("");

		this.cachedWidth = width;
		this.cachedLines = lines;
		return lines;
	}

	invalidate(): void {
		this.cachedWidth = undefined;
		this.cachedLines = undefined;
	}
}

export default function (pi: ExtensionAPI) {
	// In-memory state (reconstructed from session on load)
	let todos: Todo[] = [];
	let nextId = 1;
	let widgetVisible = true;
	let filterMode: FilterMode = "open";
	let maxVisibleTodos = DEFAULT_MAX_VISIBLE_TODOS;
	let pageIndex = 0;

	function getPageCount(): number {
		const filteredCount = getFilteredTodos(todos, filterMode).length;
		return Math.max(1, Math.ceil(filteredCount / maxVisibleTodos));
	}

	function clampPageIndex(): void {
		pageIndex = Math.max(0, Math.min(pageIndex, getPageCount() - 1));
	}

	function renderOrClearWidget(ctx: ExtensionContext): void {
		clampPageIndex();
		if (!ctx.hasUI || !widgetVisible) {
			ctx.ui.setWidget(WIDGET_KEY, undefined);
			return;
		}

		ctx.ui.setWidget(
			WIDGET_KEY,
			(_tui, theme) => ({
				render(width: number): string[] {
					return buildWidgetLines(todos, width, theme, filterMode, maxVisibleTodos, pageIndex);
				},
				invalidate() {},
			}),
			{ placement: "belowEditor" },
		);
	}

	/**
	 * Reconstruct state from session entries.
	 * Scans tool results for this tool and applies them in order.
	 */
	const reconstructState = (ctx: ExtensionContext) => {
		const state = reconstructTodos(ctx);
		todos = state.todos;
		nextId = state.nextId;
		clampPageIndex();
		renderOrClearWidget(ctx);
	};

	// Reconstruct state on session events
	pi.on("session_start", async (_event, ctx) => {
		widgetVisible = true;
		filterMode = "open";
		maxVisibleTodos = DEFAULT_MAX_VISIBLE_TODOS;
		pageIndex = 0;
		reconstructState(ctx);
	});
	pi.on("session_tree", async (_event, ctx) => reconstructState(ctx));

	pi.on("tool_result", async (event, ctx) => {
		if ((event as { toolName?: string }).toolName !== "todo") return;
		const details = (event as { details?: TodoDetails }).details;
		if (details) {
			todos = cloneTodos(details.todos);
			nextId = details.nextId;
			renderOrClearWidget(ctx);
			return;
		}
		reconstructState(ctx);
	});

	pi.on("session_shutdown", async (_event, ctx) => {
		if (ctx.hasUI) {
			ctx.ui.setWidget(WIDGET_KEY, undefined);
		}
	});

	// Register the todo tool for the LLM
	pi.registerTool({
		name: "todo",
		label: "Todo",
		description:
			"Manage a todo list. Actions: list, add (text or texts), toggle (id), clear. " +
			"Additional actions available only when the user explicitly asks: remove (id), edit (id, text).",
		parameters: TodoParams,

		async execute(_toolCallId, params, _signal, _onUpdate, _ctx) {
			switch (params.action) {
				case "list": {
					const completedCount = todos.filter((todo) => todo.done).length;
					return {
						content: [
							{
								type: "text",
								text: todos.length
									? [`${completedCount}/${todos.length} completed`, ...todos.map((todo) => `[${todo.done ? "x" : " "}] #${todo.id}: ${todo.text}`)].join("\n")
									: "No todos yet.",
							},
						],
						details: { action: "list", todos: cloneTodos(todos), nextId } as TodoDetails,
					};
				}

				case "add": {
					const todoTexts = [params.text, ...(params.texts ?? [])].filter((text): text is string => text !== undefined);
					if (todoTexts.length === 0) {
						return {
							content: [{ type: "text", text: "Todo add requires text or texts." }],
							details: { action: "add", todos: cloneTodos(todos), nextId, error: "todo add requires text or texts" } as TodoDetails,
						};
					}
					if (todoTexts.some((text) => text.length === 0)) {
						return {
							content: [{ type: "text", text: "Todo add requires non-empty text." }],
							details: { action: "add", todos: cloneTodos(todos), nextId, error: "todo add requires non-empty text" } as TodoDetails,
						};
					}

					const addedTodos = todoTexts.map((text): Todo => ({ id: nextId++, text, done: false }));
					todos.push(...addedTodos);
					const addedIds = addedTodos.map((todo) => todo.id);
					const addedTexts = addedTodos.map((todo) => todo.text);
					return {
						content: [
							{
								type: "text",
								text:
									addedTodos.length === 1
										? `Added todo #${addedTodos[0].id}: ${addedTodos[0].text}`
										: [`Added ${addedTodos.length} todos:`, ...addedTodos.map((todo) => `#${todo.id}: ${todo.text}`)].join("\n"),
							},
						],
						details: {
							action: "add",
							todos: cloneTodos(todos),
							nextId,
							addedId: addedTodos[0].id,
							addedText: addedTodos[0].text,
							addedIds,
							addedTexts,
						} as TodoDetails,
					};
				}

				case "toggle": {
					if (params.id === undefined) {
						return {
							content: [{ type: "text", text: "Todo toggle requires an id." }],
							details: { action: "toggle", todos: cloneTodos(todos), nextId, error: "todo toggle requires an id" } as TodoDetails,
						};
					}
					const found = todos.find((item) => item.id === params.id);
					if (!found) {
						return {
							content: [{ type: "text", text: `Todo #${params.id} was not found.` }],
							details: {
								action: "toggle",
								todos: cloneTodos(todos),
								nextId,
								error: `todo #${params.id} was not found`,
							} as TodoDetails,
						};
					}
					const toggledDone = !found.done;
					todos = todos.map((t) => (t.id === params.id ? { ...t, done: toggledDone } : t));
					return {
						content: [{ type: "text", text: `Todo #${found.id} ${toggledDone ? "completed" : "uncompleted"}` }],
						details: {
							action: "toggle",
							todos: cloneTodos(todos),
							nextId,
							toggledId: found.id,
							toggledText: found.text,
							toggledDone: toggledDone,
						} as TodoDetails,
					};
				}

				case "remove": {
					if (params.id === undefined) {
						return {
							content: [{ type: "text", text: "Todo remove requires an id." }],
							details: { action: "remove", todos: cloneTodos(todos), nextId, error: "todo remove requires an id" } as TodoDetails,
						};
					}
					const toRemove = todos.find((item) => item.id === params.id);
					if (!toRemove) {
						return {
							content: [{ type: "text", text: `Todo #${params.id} was not found.` }],
							details: {
								action: "remove",
								todos: cloneTodos(todos),
								nextId,
								error: `todo #${params.id} was not found`,
							} as TodoDetails,
						};
					}
					todos = todos.filter((t) => t.id !== params.id);
					return {
						content: [{ type: "text", text: `Removed todo #${toRemove.id}: ${toRemove.text}` }],
						details: {
							action: "remove",
							todos: cloneTodos(todos),
							nextId,
							removedId: toRemove.id,
							removedText: toRemove.text,
						} as TodoDetails,
					};
				}

				case "edit": {
					if (params.id === undefined) {
						return {
							content: [{ type: "text", text: "Todo edit requires an id." }],
							details: { action: "edit", todos: cloneTodos(todos), nextId, error: "todo edit requires an id" } as TodoDetails,
						};
					}
					if (!params.text) {
						return {
							content: [{ type: "text", text: "Todo edit requires text." }],
							details: { action: "edit", todos: cloneTodos(todos), nextId, error: "todo edit requires text" } as TodoDetails,
						};
					}
					const toEdit = todos.find((item) => item.id === params.id);
					if (!toEdit) {
						return {
							content: [{ type: "text", text: `Todo #${params.id} was not found.` }],
							details: {
								action: "edit",
								todos: cloneTodos(todos),
								nextId,
								error: `todo #${params.id} was not found`,
							} as TodoDetails,
						};
					}
					const oldText = toEdit.text;
					todos = todos.map((t) => (t.id === params.id ? { ...t, text: params.text! } : t));
					return {
						content: [{ type: "text", text: `Edited todo #${toEdit.id}: ${oldText} → ${params.text}` }],
						details: {
							action: "edit",
							todos: cloneTodos(todos),
							nextId,
							editedId: toEdit.id,
							editedOldText: oldText,
							editedNewText: params.text,
						} as TodoDetails,
					};
				}

				case "clear": {
					const count = todos.length;
					todos = [];
					nextId = 1;
					return {
						content: [{ type: "text", text: count === 0 ? "Todo list was already empty." : `Cleared ${count} todos.` }],
						details: { action: "clear", todos: [], nextId: 1, clearedCount: count } as TodoDetails,
					};
				}

				default:
					return {
						content: [{ type: "text", text: `Unknown action: ${params.action}` }],
						details: {
							action: "list",
							todos: cloneTodos(todos),
							nextId,
							error: `unknown action: ${params.action}`,
						} as TodoDetails,
					};
			}
		},

		renderCall(args, theme, _context) {
			let text = theme.fg("toolTitle", theme.bold("todo ")) + theme.fg("muted", args.action);
			if (args.text) text += ` ${theme.fg("dim", `"${args.text}"`)}`;
			if (args.texts?.length) text += ` ${theme.fg("dim", `(${args.texts.length} todos)`)}`;
			if (args.id !== undefined) text += ` ${theme.fg("accent", `#${args.id}`)}`;
			return new Text(text, 0, 0);
		},

		renderResult(result, { expanded }, theme, _context) {
			const details = result.details as TodoDetails | undefined;
			if (!details) {
				const text = result.content[0];
				return new Text(text?.type === "text" ? text.text : "", 0, 0);
			}

			if (details.error) {
				return new Text(theme.fg("error", `Error: ${details.error}`), 0, 0);
			}

			const todoList = details.todos;

			switch (details.action) {
				case "list": {
					if (todoList.length === 0) {
						return new Text(theme.fg("dim", "No todos yet."), 0, 0);
					}
					const completedCount = todoList.filter((todo) => todo.done).length;
					let listText = theme.fg("muted", `${completedCount}/${todoList.length} completed`);
					const display = expanded ? todoList : todoList.slice(0, 5);
					for (const todo of display) {
						const check = todo.done ? theme.fg("success", "✓") : theme.fg("dim", "○");
						const itemText = todo.done ? theme.fg("dim", todo.text) : theme.fg("muted", todo.text);
						listText += `\n${check} ${theme.fg("accent", `#${todo.id}`)} ${itemText}`;
					}
					if (!expanded && todoList.length > 5) {
						listText += `\n${theme.fg("dim", `... ${todoList.length - 5} more`)}`;
					}
					return new Text(listText, 0, 0);
				}

				case "add": {
					const addedIds = details.addedIds;
					const addedTexts = details.addedTexts;
					if (addedIds?.length && addedTexts?.length && addedIds.length === addedTexts.length) {
						if (addedIds.length === 1) {
							return new Text(
								theme.fg("success", "✓ Added todo ") +
									theme.fg("accent", `#${addedIds[0]}`) +
									" " +
									theme.fg("muted", `— ${addedTexts[0]}`),
								0,
								0,
							);
						}
						let addedText = theme.fg("success", `✓ Added ${addedIds.length} todos`);
						for (let index = 0; index < addedIds.length; index++) {
							addedText += `\n${theme.fg("accent", `#${addedIds[index]}`)} ${theme.fg("muted", `— ${addedTexts[index]}`)}`;
						}
						return new Text(addedText, 0, 0);
					}

					const addedId = details.addedId;
					const addedText = details.addedText;
					if (addedId !== undefined && addedText) {
						return new Text(
							theme.fg("success", "✓ Added todo ") +
								theme.fg("accent", `#${addedId}`) +
								" " +
								theme.fg("muted", `— ${addedText}`),
							0,
							0,
						);
					}
					const added = todoList[todoList.length - 1];
					return new Text(
						theme.fg("success", "✓ Added todo ") +
							theme.fg("accent", `#${added.id}`) +
							" " +
							theme.fg("muted", `— ${added.text}`),
						0,
						0,
					);
				}

				case "toggle": {
					const toggledId = details.toggledId;
					const toggledText = details.toggledText;
					const toggledDone = details.toggledDone;
					if (toggledId !== undefined && toggledText && toggledDone !== undefined) {
						const statusText = toggledDone ? "completed" : "uncompleted";
						return new Text(
							theme.fg("success", "✓ Todo ") +
								theme.fg("accent", `#${toggledId}`) +
								" " +
								theme.fg("muted", `${statusText} — ${toggledText}`),
							0,
							0,
						);
					}
					const text = result.content[0];
					const msg = text?.type === "text" ? text.text : "";
					return new Text(theme.fg("success", "✓ ") + theme.fg("muted", msg), 0, 0);
				}

				case "remove": {
					const removedId = details.removedId;
					const removedText = details.removedText;
					if (removedId !== undefined && removedText) {
						return new Text(
							theme.fg("success", "✓ Removed todo ") +
								theme.fg("accent", `#${removedId}`) +
								" " +
								theme.fg("muted", `— ${removedText}`),
							0,
							0,
						);
					}
					const text = result.content[0];
					const msg = text?.type === "text" ? text.text : "";
					return new Text(theme.fg("success", "✓ ") + theme.fg("muted", msg), 0, 0);
				}

				case "edit": {
					const editedId = details.editedId;
					const editedNewText = details.editedNewText;
					if (editedId !== undefined && editedNewText) {
						return new Text(
							theme.fg("success", "✓ Edited todo ") +
								theme.fg("accent", `#${editedId}`) +
								" " +
								theme.fg("muted", `— ${editedNewText}`),
							0,
							0,
						);
					}
					const text = result.content[0];
					const msg = text?.type === "text" ? text.text : "";
					return new Text(theme.fg("success", "✓ ") + theme.fg("muted", msg), 0, 0);
				}

				case "clear": {
					const clearedCount = details.clearedCount ?? 0;
					const clearText = clearedCount === 0 ? "Todo list already empty" : `Cleared ${clearedCount} todos`;
					return new Text(theme.fg("success", "✓ ") + theme.fg("muted", clearText), 0, 0);
				}
			}
		},
	});

	pi.registerCommand("todo", {
		description: "Control the todo widget below the editor, or view all todos",
		handler: async (args, ctx) => {
			if (!ctx.hasUI) {
				ctx.ui.notify("/todo requires interactive mode", "error");
				return;
			}

			const action = args.trim().toLowerCase();

			if (action === "view") {
				await ctx.ui.custom<void>((_tui, theme, _kb, done) => {
					return new TodoListComponent(todos, theme, () => done());
				});
				return;
			}

			if (action === "off") {
				widgetVisible = false;
				renderOrClearWidget(ctx);
				ctx.ui.notify("Todo widget disabled", "info");
				return;
			}

			if (action === "open" || action === "done") {
				widgetVisible = true;
				filterMode = action;
				pageIndex = 0;
				renderOrClearWidget(ctx);
				ctx.ui.notify(`Todo widget set to show ${filterMode} todos`, "info");
				return;
			}

			if (action === "next") {
				widgetVisible = true;
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
				widgetVisible = true;
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
				widgetVisible = true;
				maxVisibleTodos = parsedCount;
				pageIndex = 0;
				renderOrClearWidget(ctx);
				ctx.ui.notify(`Todo widget page size set to ${maxVisibleTodos}`, "info");
				return;
			}

			ctx.ui.notify("Usage: /todo (view|open|done|<number>|next|prev|off)", "error");
		},
	});
}
