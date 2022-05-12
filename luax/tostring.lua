--[[
  LuaX - Improved tostring() with Love!
--]]

local _tostring = tostring

local function _table2string(x)
  local s = ""
  for k, v in pairs(x) do
    if type(v) == "function" then
      s = s .. "," .. "()"
    elseif type(v) == "class" then
      s = s .. "," .. "{}"
    elseif type(v) == "array" then
      s = s .. "," .. "[]"
    else
      s = s .. "," .. _tostring(k) .. "=" .. tostring(v)
    end
  end
  return "{" .. s:sub(2) .. "}"
end

tostring = function (x)
  if type(x) == "class" then
    return _tostring(x) or luax.Class.__tostring(x)
  elseif type(x) == "array" then
    return luax.Array.__tostring(x)
  elseif type(x) == "table" then
    return _table2string(x)
  elseif type(x) == "userdata" then
    return _tostring(x):split(":"):join(" "):split(" "):first() .. "{}"
  elseif type(x) == "function" then
    return _tostring(x):split(":"):join(" "):split(" "):first() .. "()"
  else
    return _tostring(x)
  end
end
