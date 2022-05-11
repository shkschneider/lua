local Particle = luax.Class:new("particle")

function Particle:constructor(path, f)
  assert(type(path) == "string" and #path > 0)
  assert(type(f) == "function")
  self.image = love2dx.Cache:image(path)
  assert(self.image:getDimensions() ~= nil)
  assert(self.image:getWidth() == self.image:getHeight())
  self.size = self.image:getWidth()
  self.system = love.graphics.newParticleSystem(self.image, size)
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
