local Particle = luax.Class:new("particle")

function Particle:constructor(image, size, f)
  assert(type(image) ~= nil)
  assert(type(size) == "number")
  assert(type(f) == "function")
  self.image = image
  self.size = size
  self.system = love.graphics.newParticleSystem(image, size)
  f(self.system)
end

function Particle:update(dt)
  assert(type(dt) == "number")
  self.system:update(dt)
end

function Particle:draw(position)
  love.graphics.draw(self.system, position.x, position.y)
end

return Particle
