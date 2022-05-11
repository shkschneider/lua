--[[
  LuaX - A collection of common code for Lua.

  - overrides type() to handle new (internal) types
  - overrides tostring() to better handle table and new custom data

  - require "luax"
  - local l = luax.XXX()
--]]

-- namespace
luax = {}
luax.Array = require "array"
-- Base
luax.Class = require "class"
-- Enum
luax.Fifo = require "fifo"
luax.Version = require "version"
require "hash"
require "random"
require "strings"
luax.Path = require "path"
luax.Log = require "log"
require "miscellaneous"

--[[ type() ]]--

local _type = type

type = function (x)
  if x == nil then
    return "nil"
  elseif _type(x) == "table" and _type(x.__type) == "string" then
    return x.__type
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

--[[ math ]]--

function math.clamp(min, n, max)
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

function math.sign(n)
  assert(type(n) == "number")
  if n < 0 then
    return -1
  elseif n > 0 then
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
