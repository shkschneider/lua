--[[
  LuaX - Improved type() with Love!
--]]

local _type = type

type = function (x)
  if x == nil then
    return "nil"
  elseif _type(x) == "table" and x.__type then
    return x.__type
  else
    return _type(x)
  end
end
