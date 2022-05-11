local Animation = luax.Class:new("animation")

function Animation:constructor(spritesheet, duration, ttl, f)
  luax.Class.assert(spritesheet, "spritesheet")
  assert(type(duration) == "number" and duration > 0)
  assert(type(ttl) == "number")
  assert(type(f) == nil or type(f) == "function")
  self.clock = 0
  self.spritesheet = spritesheet
  self.duration = duration
  self.ttl = ttl
  self.f = f
end

function Animation:update(dt)
  self.clock = self.clock + dt
  if self.clock > self.duration then
    if self.ttl > 0 then
      self.ttl = self.ttl - 1
    end
    self.clock = 0
    self.f()
  end
end

function Animation:draw(position)
  if self.ttl == 0 then return end
  local n = math.floor(self.clock / self.duration * #self.spritesheet.quads) + 1
  self.spritesheet:draw(n, position)
end

return Animation
