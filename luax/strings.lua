--[[
  LuaX - Extended methods for strings, with Love!
--]]

string.split = function (str, char)
  assert(type(str) == "string")
  char = char or " "
  assert(type(char) == "string" and #char == 1)
  local array = luax.Array()
  for s in string.gmatch(str, "([^" .. char .. "]+)") do
    array:pushlast(s)
  end
  return array
end

string.explode = function (str)
  assert(type(str) == "string")
  local array = luax.Array()
  for i = 1, #str do
    array:pushlast(str:sub(i, i))
  end
  return array
end

string.starts = function (str, match)
  assert(type(str) == "string")
  assert(type(match) == "string" and #match > 0)
  return str:sub(1, #match) == match
end

string.ends = function (str, match)
  assert(type(str) == "string")
  assert(type(match) == "string" and #match > 0)
  return str:sub(#str - (#match - 1), #str) == match
end

string.trim = function (str)
  return str:gsub(" ", ""):gsub("\t", ""):gsub("\n", "")
end

string.pad = function (str, n, char)
  assert(type(str) == "string")
  assert(type(n) == "number" and n > 0)
  char = char or " "
  assert(type(char) == "string" and #char == 1)
  for i = #str, n do
    str = char .. str
  end
  return str
end

string.capitalize = function (s)
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
