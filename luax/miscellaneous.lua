--[[
  LuaX - Miscellaneous helper methods... with Love!
--]]

luax.loop = function (n, f, ...)
  assert(type(n) == "number")
  assert(type(f) == "function")
  for i = 1, n do
    f(i, ...)
  end
end

luax.range = function (_start, _end, step)
  local array = luax.Array()
  for i = _start, _end, (step or math.sign(_end - _start)) do
    array:pushlast(i)
  end
  return array
end
