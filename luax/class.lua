--[[
  LuaX - Simplistic Class, with Love.

  - type is "class"
  - declare with Class:new()
    - inherit from with AnotherClass:new()
    - exposes self.super
  - initialize with MyClass()
  - with constructors (automatically called upon instanciation)

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

Class.new = function (self, ...)
  local class = {}
  for k, v in pairs(self) do
    class[k] = v
  end
  class.super = self
  return setmetatable(class, class)
end

Class.constructor = function (self, ...) end

-- FIXME does work for MyClass:is(Myclass) but not for myClass:is(MyClass)
Class.is = function (self, other)
  assert(type(other) == Class.__type)
  return getmetatable(self) == getmetatable(other) or (self.super and self.super:is(other) or false)
end

Class.__call = function (self, ...)
  local class = self:new(...)
  self.super.constructor(class, ...)
  self.constructor(class, ...)
  class.super = self.super
  return class
end

Class.__tostring = function (self)
  local s = ""
  for k, v in pairs(self) do
    k = tostring(k)
    if k:find("_") ~= 1 and not Class[k] then
      if k == "super" then
        if type(v) == "class" and getmetatable(v) ~= getmetatable(Class) then
          s = s .. "," .. k .. "{}"
        end
      elseif type(v) == "function" then
        s = s .. "," .. k .. "()"
      elseif type(v) == "class" then
        s = s .. "," .. k .. "{}"
      elseif type(v) == "array" then
        s = s .. "," .. k .. "[]"
      else
        s = s .. "," .. k .. "=" .. tostring(v)
      end
    end
  end
  return "{" .. s:sub(2) .. "}"
end

return setmetatable(Class, Class)
