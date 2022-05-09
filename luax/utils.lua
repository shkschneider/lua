luax.lines = function (s, sep)
  assert(type(s) == "string")
  local sep = sep or "\n"
  local lines = luax.Array:new()
  for line in s:gmatch("([^\n]*)\n?") do
    lines:pushlast(line)
  end
  return lines
end

luax.loop = function (n, f, ...)
  assert(type(n) == "number")
  assert(type(f) == "function")
  for i = 1, n do
    f(i, ...)
  end
end
