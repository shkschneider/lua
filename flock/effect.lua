local Effect = Entity:new()

function Effect:constructor(position, spritesheet, duration)
  assert(type(position.x) == "number" and type(position.y) == "number")
  self.clock = 0
  self.position = position
  self.spritesheet = spritesheet
  self.duration = duration or (#self.spritesheet.quads * 0.1)
end

function Effect:update(dt)
  assert(type(dt) == "number")
  self.clock = self.clock + dt
  if self.clock > self.duration then
    _G.entities:remove(self)
  end
end

function Effect:draw()
  local n = math.floor(self.clock / self.duration * #self.spritesheet.quads) + 1
  love.graphics.setColor(_G.colors.white.r, _G.colors.white.g, _G.colors.white.b, 1.0)
  love.graphics.draw(
    self.spritesheet.image,
    self.spritesheet.quads[n],
    self.position.x - self.spritesheet.size / 2,
    self.position.y - self.spritesheet.size / 2
  )
end

return Effect
