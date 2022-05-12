--[[
  LuaX - Simplistic Class, with Love.

  - type is "class"
  - declare with Class:new()
    - inherit from with AnotherClass:new()
    - exposes self.super
  - initialize with MyClass()
  - with constructors
    - automatic call to super:constructor(...)
    - automatic call to MyClass:constructor(...)

  Greatly inspired by:
  - https://github.com/rxi/classic/blob/master/classic.lua
  Also inspired by:
  - https://github.com/jumpsplat120/getClassic/blob/master/Object.lua
  With the help of:
  - http://lua-users.org/wiki/MetatableEvents

  To go further:
  - https://github.com/Sheepolution/classroom
--]]

Class = {
  __type = "class",
  super = nil,
}

Class.new = function (self)
  local class = {}
  for k, v in pairs(self) do
    class[k] = v
  end
  class.__index = class
  class.super = self
  return setmetatable(class, {
    __call = function (self, ...)
      local class = self:new()
      if class.constructor then
        class:constructor(...)
      end
      class.super = self.super
      return setmetatable(class, class)
    end,
    __tostring = function (self)
      return self:__tostring() or Class.__tostring(self)
    end,
  })
end

Class.constructor = function (self, ...) end

Class.is = function (self, class)
  return getmetatable(self) == getmetatable(class) or (self.super and self.super:is(class) or false)
end

Class.__tostring = function (self)
  local s = ""
  for k, v in pairs(self) do
    k = tostring(k)
    if k:find("_") ~= 1 and not Class[k] then
      if k == "super" then
        s = s .. "," .. k .. "{...}"
      elseif type(v) == "function" then
        s = s .. "," .. k .. "()"
      elseif type(v) == "class" then
        s = s .. "," .. k .. "{...}"
      elseif type(v) == "array" then
        s = s .. "," .. k .. "[...]"
      else
        s = s .. "," .. k .. "=" .. tostring(v)
      end
    end
  end
  return "{" .. s:sub(2) .. "}"
end

return setmetatable(Class, Class)
