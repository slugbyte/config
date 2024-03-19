-- local name = "slubyte"
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
if vim.g.wat == nil then
  vim.g.wat = {}
  print("new wat")
end

-- local wat = vim.g.wat
-- table.insert(wat, win)
-- table.insert(wat, "wa")
-- table.insert(wat, "goo")

local wat = {}
table.insert(wat, "wa")
table.insert(wat, "goo")

for i, value in ipairs(wat) do
  print("wat", i, value)
end

-- vim.keymap.set("n", '<leader>z', function()
--   for _, value in pairs(vim.g.rand_buf) do
--     vim.api.nvim_win_close(value, true)
--   end
-- end)
