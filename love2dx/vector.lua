Vector = luax.Class:new()

--[[ creation ]]--

function Vector:constructor(x, y)
  self.x = x or _G.width / 2
  self.y = y or _G.height / 2
end

function Vector:copy()
  return Vector(self.x, self.y)
end

function Vector:zero()
  return Vector(0, 0)
end

function Vector:random()
  local tetha = math.random() * math.pi * 2
  return Vector(math.cos(tetha), math.sin(tetha))
end

function Vector:mouse()
  return Vector(love.mouse.getX(), love.mouse.getY())
end

function Vector:center()
  return Vector(_G.width / 2, _G.height / 2)
end

--[[ modification ]]--

function Vector:rotate(theta)
  self.x = self.x * math.cos(theta) - self.y * math.sin(theta)
  self.y = self.x * math.sin(theta) + self.y * math.cos(theta)
  return self
end

function Vector:translate(dx, dy)
  self.x = self.x + dx
  self.y = self.y + (dy or dx)
  return self
end

function Vector:scale(dx, dy)
  self.x = self.x * dx
  self.y = self.y * (dy or dx)
  return self
end

--[[ calculation ]]--

function Vector:distance(vector)
  return (self - vector):magnitude()
end

function Vector:dot(vector)
  return self.x * vector.x + self.y * vector.y
end

function Vector:heading() -- rad
  return -math.atan2(self.y, self.x)
end

function Vector:magnitude() -- length
  return math.sqrt(self.x ^ 2 + self.y ^ 2)
end

function Vector:angle(vector) -- rad
  if vector then
    return math.atan2(vector.x - self.x, self.y - vector.y)
  else
    return math.atan(self.y / self.x)
 end
end

function Vector:sqrt()
   return math.sqrt(self:dot(self))
end

function Vector:normalize()
  return Vector(self.x, self.y) / self:sqrt()
end

function Vector:isParallel(vector)
  return math.abs(self:dot(vector)) == 1
end

--[[ operation ]]--

Vector.__unm = function (vector)
  return Vector(-vector.x, -vector.y)
end

Vector.__eq = function (vector1, vector2)
  return vector1.x == vector2.x and vector1.y == vector2.y
end

Vector.__add = function (vector, vectorOrNumber)
  local v = vector:copy()
  v.x = v.x + (type(vectorOrNumber) == "number" and vectorOrNumber or vectorOrNumber.x)
  v.y = v.y + (type(vectorOrNumber) == "number" and vectorOrNumber or vectorOrNumber.y)
  return v
end

Vector.__sub = function (vector, vectorOrNumber)
  local v = vector:copy()
  v.x = v.x - (type(vectorOrNumber) == "number" and vectorOrNumber or vectorOrNumber.x)
  v.y = v.y - (type(vectorOrNumber) == "number" and vectorOrNumber or vectorOrNumber.y)
  return v
end

Vector.__mul = function (vector, vectorOrNumber)
  local v = vector:copy()
  v.x = v.x * (type(vectorOrNumber) == "number" and vectorOrNumber or vectorOrNumber.x)
  v.y = v.y * (type(vectorOrNumber) == "number" and vectorOrNumber or vectorOrNumber.y)
  return v
end

Vector.__div = function (vector, vectorOrNumber)
  local v = vector:copy()
  v.x = v.x / (type(vectorOrNumber) == "number" and vectorOrNumber or vectorOrNumber.x)
  v.y = v.y / (type(vectorOrNumber) == "number" and vectorOrNumber or vectorOrNumber.y)
  return v
end

--[[ serialization ]]--

function Vector:unpack()
    return self.x, self.y
end

Vector.__tostring = function (vector)
   return "(" .. vector.x .. "," .. vector.y .. ")"
end

return Vector
