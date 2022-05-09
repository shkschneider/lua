--[[
  Lua - Simplistic Class, with Love.
  - yet with inheritence!
  - __type is "class"
  - declare with Class:new() or Class:extend()
  - initialize with Class() which calls Class:constructor()
  - you can __name them
  - you can override :constructor() or :tostring()
  - you can use super

  Greatly inspired from:
  - https://github.com/rxi/classic/blob/master/classic.lua
  Also inspired by:
  - https://github.com/jumpsplat120/getClassic/blob/master/Object.lua
  With the help of:
  - http://lua-users.org/wiki/MetatableEvents

  If you need more features:
  - https://github.com/Sheepolution/classroom
]]

require "luax"

local TYPE = "class"

local Class = {
  __type = TYPE
}
Class.__index = Class

function Class:constructor() end

function Class:new(name)
  assert(type(name) == "string", "string expected but got " .. type(name))
  assert(#name > 1, "string expected but got one empty")
  local class = {}
  -- copy
  for k, v in pairs(self) do
    if k:find("__") == 1 then
      class[k] = v
    end
  end
  -- set (after copy!)
  class.__index = class
  class.__type = TYPE
  class.__name = name or Class.__type
  class.super = nil
  -- return
  return setmetatable(class, self)
end

function Class:extend(name)
  local class = self:new(name)
  class.super = self
  -- TODO love 5.2+: class.__len = function (t) ... end
  return setmetatable(class, self)
end

function Class:is(t)
  local meta = getmetatable(self)
  -- compares metatables
  while meta do
    if meta == t then
      return true
    end
    meta = getmetatable(meta)
  end
  return false
end

function Class:tostring()
  -- super.name:name{data...}
  local super = self.super
  local t = self.__name
  if super then t = super.__name .. ":" .. t end
  -- do not output super
  self.super = nil
  local table2string = _table2string(self)
  -- restore super
  self.super = super
  return t .. table2string
end

function Class:__tostring()
  return self:tostring()
end

function Class:__call(...)
  local class = setmetatable({}, self)
  -- if you override the constructor, need to call super constructor
  if self.super then self.super:constructor(...) end
  -- calls your constructor or the dummy one
  class:constructor(...)
  return class
end

return Class
