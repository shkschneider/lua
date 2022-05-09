--[[
  Lua - Simplistic Array, with Love.
  - __type is "array"

  Greatly inspired from:
  - https://github.com/rick4stley/array/blob/main/array.lua
]]

local TYPE = "array"

local Array = {
  __type = TYPE
}
Array.__index = Array

function Array:new(...)
  local values = { ... }
  local array = {}
  for _, v in ipairs(values) do
    table.insert(array, v)
  end
  array.__index = array
  array.__type = TYPE
  return setmetatable(array, self)
end

function Array:copy()
  local array = Array:new()
  for i = 1, #self do
      array[i] = self[i]
  end
  return array
end

function Array:pushfirst(value)
  table.insert(self, 1, value)
  return self
end

function Array:pushlast(value)
  table.insert(self, value)
  return self
end

function Array:popfirst()
  if #self > 0 then
    table.remove(self, 1)
  end
  return self
end

function Array:poplast()
  if #self > 0 then
    table.remove(self, #self)
  end
  return self
end

function Array:first()
  return self[1]
end

function Array:last()
  return self[#self]
end

function Array:each(f, ...)
  assert(type(f) == "function")
  for i, v in ipairs(self) do
    f(i, v, ...)
  end
  return f
end

function Array:all(f)
  assert(type(f) == "function")
  for _, v in ipairs(self) do
    if f(v) == false then
      return false
    end
  end
  return true
end

function Array:count(f)
  assert(type(f) == "function")
  local n = 0
  for _, v in ipairs(self) do
    if f(v) then
      n = n + 1
    end
  end
  return n
end

function Array:any(f)
  assert(type(f) == "function")
  for _, v in ipairs(self) do
    if f(v) == true then
      return true
    end
  end
  return false
end

function Array:none(f)
  assert(type(f) == "function")
  for _, v in ipairs(self) do
    if f(v) == true then
      return false
    end
  end
  return true
end

function Array:contains(value)
  for _, v in ipairs(self) do
    if v == value then
      return true
    end
  end
  return false
end

function Array:map(f)
  assert(type(f) == "function")
  for i, v in ipairs(self) do
    self[i] = f(self[i])
  end
  return self
end

function Array:filter(f)
  assert(type(f) == "function")
  local array = Array:new()
  for i, v in ipairs(self) do
    if f(v) then
      array:pushlast(v)
    end
  end
  return array
end

function Array:split(indexOrValue)
  local arrays = Array:new(self:copy(), self:copy())
  for i, v in ipairs(self) do
    if (type(indexOrValue) == "number" and i == indexOrValue) or v == indexOrValue then
      while #arrays:first() >= i do
        arrays:first():poplast()
      end
      return arrays
    end
    arrays:last():popfirst()
  end
  return arrays
end

function Array:invert()
  local array = Array:new()
  for i = #self, 1, -1 do
    table.insert(array, self[i])
  end
  return array
end

function Array:remove(indexOrValue)
  if type(indexOrValue) == "number" then
    table.remove(self, indexOrValue)
  else
    for i, v in ipairs(self) do
      if v == indexOrValue then
        table.remove(self, i)
      end
    end
  end
  return self
end

function Array:clear()
  return self:map(function (v)
    return nil
  end)
end

function Array:__tostring()
  local s = ""
  for _, v in ipairs(self) do
    s = s .. "," .. tostring(v)
  end
  return "[" .. s:sub(2) .. "]"
end

return Array
