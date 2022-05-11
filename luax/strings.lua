--[[
  LuaX - Extended methods for strings, with Love!
--]]

luax.explode = function (s)
  assert(type(s) == "string")
  local array = luax.Array()
  for i = 1, #s do
    array:pushlast(s:sub(i, i))
  end
  return array
end

luax.lines = function (s, sep)
  assert(type(s) == "string")
  local sep = sep or "\n"
  local lines = luax.Array()
  for line in s:gmatch("([^\n]*)\n?") do
    lines:pushlast(line)
  end
  return lines
end

luax.starts = function (s, match)
  assert(type(s) == "string")
  assert(type(match) == "string" and #match > 0)
  return s:sub(1, #match) == match
end

luax.ends = function (s, match)
  assert(type(s) == "string")
  assert(type(match) == "string" and #match > 0)
  return s:sub(#s - (#match - 1), #s) == match
end

luax.trim = function (s)
  return s:gsub(" ", ""):gsub("\t", ""):gsub("\n", "")
end

luax.pad = function (s, n, c)
  assert(type(s) == "string")
  assert(type(n) == "number" and n > 0)
  local char = c or " "
  assert(type(char) == "string" and #char == 1)
  for i = #s, n do
    s = char .. s
  end
  return s
end

luax.capitalize = function (s)
  return s:sub(1, 1):upper() .. s:sub(2, #s):lower()
end

luax.join = function (sep, ...)
  local separator = tostring(sep or ",")
  local s = ""
  for _, v in ipairs{...} do
    s = s .. separator .. v
  end
  return s:sub(#separator + 1)
end
