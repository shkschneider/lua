local Class = {
  is = function (self, other)
    print(self, other)
    return getmetatable(self) == other
  end,
  __call = function (self, ...)
    return {}
  end,
  __tostring = function (self)
    return "42"
  end,
}
Class.__index = Class
setmetatable({}, Class)

function Class.new(...)
  local o = {}
  o.__index = o
  return setmetatable(Class, o)
end

class1 = Class:new()
class2 = Class:new()
print(class1)
print(class2)
print(class1:is(class1))
