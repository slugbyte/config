local api = require('Comment.api')

local function get_region(opmode)
  if not opmode then
    local row = unpack(vim.api.nvim_win_get_cursor(0))
    return { srow = row, scol = 0, erow = row, ecol = 0 }
  end

  local marks = string.match(opmode, '[vV]') and { '<', '>' } or { '[', ']' }
  vim.print("marks", marks)
  local sln, eln = vim.api.nvim_buf_get_mark(0, marks[1]), vim.api.nvim_buf_get_mark(0, marks[2])

  return { start_row = sln[1], start_col = sln[2], end_row = eln[1], end_col = eln[2] }
end

local esc = vim.api.nvim_replace_termcodes(
  '<ESC>', true, false, true
)
vim.keymap.set("x", "c", function()
  print("fookkkk")
  vim.api.nvim_feedkeys(esc, 'nx', false)
  -- api.toggle.linewise(vim.fn.visualmode())
  vim.print(get_region("v"))
end, { desc = "wat" })

print("booyee")
--
-- if jit then
--   print("luajit", _VERSION)
-- else
--   print("lua 5.1", _VERSION)
-- end
--
-- do
--   local name = "glob"
--   print("hi", name)
-- end
--
-- print("hi", name)
--
-- local a, b, c = 1, 2, 3
--
--
--
-- print("a", a)
-- print("b", b)
-- print("c", c)
--
-- for i = 1, 10, 1 do
--   print("i", i)
-- end
--
-- vim.print("hi")
--
-- local iter_state = 0
-- local function iter_example()
--   if iter_state < 10 then
--     iter_state = iter_state + 1
--     return iter_state
--   end
--   return nil
-- end
--
-- for wat in iter_example do
--   print("wat", wat)
-- end
--
-- local note_list = {}
--
-- local note_a = {
--   content = "blah blah",
--   view_count = 3,
-- }
--
-- local note_b = {
--   content = "garbage",
--   view_count = 1,
-- }
--
-- local note_meta = {
--   __add = function(lhs, rhs)
--     lhs.view_count = lhs.view_count + rhs.view_count
--     rhs.view_count = lhs.view_count + rhs.view_count
--
--     local result = {
--       content = lhs.content,
--       view_count = lhs.view_count + rhs.view_count,
--     }
--     return result
--   end
--   ,
-- }
--
-- setmetatable(note_a, note_meta)
-- setmetatable(note_b, note_meta)
-- local goo = note_a + note_b
-- print(goo.content, goo.view_count, (goo + note_a).view_count)

-- vim.ui.input({
--   prompt = "Whats your email? "
-- }, function(email)
--   print("prepare for infonate spam @", email)
-- end)
--
-- vim.ui.select({ 'tabs', 'spaces' }, {
--   prompt = 'Select tabs or spaces:',
--   format_item = function(item)
--     return "I'd like to choose " .. item
--   end,
-- }, function(choice)
--   print("fuck your choise", choice)
-- end)
-- local loop = vim.loop
-- local function set_timeout(timeout, callback)
--   local timer = loop.new_timer()
--   timer:start(timeout, 0, function()
--     timer:stop()
--     timer:close()
--     callback()
--   end)
--   return timer
-- end
--
-- local buf = vim.api.nvim_create_buf(false, true)
-- vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "fuck", "you" })
-- local win = vim.api.nvim_open_win(buf, false, {
--   width = 5,
--   height = 2,
--   relative = "cursor",
--   col = 1,
--   row = 0,
--   style = "minimal",
-- })
--
--

-- local wat = vim.g.wat
-- table.insert(wat, win)
-- table.insert(wat, "wa")
-- table.insert(wat, "goo")

-- local wat = {}
-- -- table.insert(wat, "wa")
-- -- table.insert(wat, "goo")
--
--
-- print("wat len", #wat)
-- for i, value in ipairs(wat) do
--   print("wat", i, value)
-- end
--
-- local key_equal = function(a, b)
--   local len_a = #a
--   local len_b = #b
--   if len_a ~= len_b then
--     return false
--   end
--
--   if len_a == 1 then
--     return a == b
--   end
--
--   -- would be better to replace specifc bad things line <C- <c-
--   return string.lower(a) == string.lower(b)
-- end
--
-- local should_map = function(key, skip_list)
--   if skip_list == nil then
--     skip_list = {}
--   end
--
--   local skip = false
--   for _, skip_key in ipairs(skip_list) do
--     skip = skip or key_equal(key, skip_key)
--   end
--
--   if skip then
--     print("skiping map", key)
--   end
--   return not skip
-- end
--
-- print(should_map("a", { "'", "a", "c" }))

-- vim.keymap.set("n", '<leader>z', function()
--   for _, value in pairs(vim.g.rand_buf) do
--     vim.api.nvim_win_close(value, true)
--   end
-- end)
