local name = "slubyte"
if jit then
  print("luajit", _VERSION)
else
  print("lua 5.1", _VERSION)
end

do
  local name = "glob"
  print("hi", name)
end

print("hi", name)

local a, b, c = 1, 2, 3



print("a", a)
print("b", b)
print("c", c)

for i = 1, 10, 1 do
  print("i", i)
end

vim.print("hi")


local iter_state = 0
local function iter_example()
  if iter_state < 10 then
    iter_state = iter_state + 1
    return iter_state
  end
  return nil
end

for wat in iter_example do
  print("wat", wat)
end
