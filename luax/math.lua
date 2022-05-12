--[[
  LuaX - Extended math, with Love!
--]]

math.clamp = function (min, n, max)
  assert(type(n) == "number")
  assert(type(min) == "number")
  assert(type(n) == "number")
  assert(type(max) == "number")
  if n < min then
    return min
  elseif n > max then
    return max
  else
    return n
  end
end

math.sign = function (n)
  assert(type(n) == "number")
  if n < 0 then
    return -1
  elseif n > 0 then
    return 1
  else
    return 0
  end
end
