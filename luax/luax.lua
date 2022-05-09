--[[ type() ]]--

local _type = type

type = function (x)
  if x == nil then
    return "nil"
  elseif _type(x) == "table" and x.__type ~= nil then
    return tostring(x.__type)
  else
    return _type(x)
  end
end

--[[ tostring() ]]--

local _tostring = tostring

function _table2string(t)
  local s = ""
  for k, v in pairs(t) do
    if _tostring(k):find("_") ~= 1 then
      if type(v) == "function" then
        s = s .. "," .. k .. "=" .. "function()"
      elseif type(v) == "array" then
        s = s .. "," .. _tostring(v)
      elseif type(v) == "table" then
        s = s .. "," .. k .. "=" .. _table2string(v)
      else
        s = s .. "," .. k .. "=" .. _tostring(v)
      end
    end
  end
  return "{" .. s:sub(2) .. "}"
end

tostring = function (x)
  if x == nil then
    return "nil"
  elseif type(x) == "function" then
    return "function()"
  elseif type(x) == "table" then
    return _table2string(x)
  else
    return _tostring(x)
  end
end

--[[ colors ]]--

function rgb(r, g, b)
  assert(type(r) == "number" or type(r) == "nil")
  assert(type(g) == "number" or type(r) == "nil")
  assert(type(b) == "number" or type(r) == "nil")
  r = r or 255
  g = g or 255
  b = b or 255
  return { r = r / 255, g = g / 255, b = b / 255 }
end

function rgba(r, g, b, a)
  assert(type(r) == "number" or type(r) == "nil")
  assert(type(g) == "number" or type(r) == "nil")
  assert(type(b) == "number" or type(r) == "nil")
  assert(type(a) == "number" or type(r) == "nil")
  r = r or 255
  g = g or 255
  b = b or 255
  a = a or 1
  return { r = r / 255, g = g / 255, b = b / 255, a = a }
end

--[[ loop() ]]--

function loop(n, f, ...)
  assert(type(n) == "number")
  assert(type(f) == "function")
  for i = 1, n do
    f(i, ...)
  end
end

--[[ lines() ]]--

function lines(s, sep)
  assert(type(s) == "string")
  local sep = sep or "\n"
  local lines = Array:new()
  for line in s:gmatch("([^\n]*)\n?") do
    lines:pushlast(line)
  end
  return lines
end

--[[ random ]]--

math.randomseed(os.time())

function randomboolean()
  return randomtable({true, false})
end

function randomtable(table)
  return table[math.random(#table)]
end

--[[ math ]]--

local _mathClamp = math.clamp

function math.clamp(x, min, max)
  if type(_mathClamp) == "function" then
    return _mathClamp(x, min, max)
  end
  assert(type(x) == "number")
  assert(type(min) == "number")
  assert(type(max) == "number")
  if x < min then
    return min
  elseif x > max then
    return max
  else
    return x
  end
end

local _mathSign = math.sign

function math.sign(x)
  if type(_mathSign) == "function" then
    return _mathSign(x)
  end
  assert(type(x) == "number")
  if x < 0 then
    return -1
  elseif x > 0 then
    return 1
  else
    return 0
  end
end

--[[ exit() ]]--

local _exit = exit

function exit(code)
  if type(_exit) == "function" then
    _exit(code)
  end
  assert(type(x) == "number")
  assert(x > 0)
  os.exit(code)
end
