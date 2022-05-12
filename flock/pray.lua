--[[
  TODO: should not see behind
--]]

Pray = Entity:new()

Pray.MAX_SPEED = 175
Pray.MIN_SPEED = 100
Pray.COHESION_RADIUS = Entity.RADIUS * 8 -- 8
Pray.COHESION_DAMPER = 10 -- 10
Pray.ALIGNMENT_RADIUS = Entity.RADIUS * 4 -- 3
Pray.ALIGNMENT_DAMPER = 8 -- 8
Pray.AVOIDANCE_RADIUS = Entity.RADIUS * 3 -- 3
Pray.AVOIDANCE_AMPLIFIER = 6 -- 6
Pray.PREDATOR_AMPLIFIER = 1.5

function Pray:constructor()
  if luax.randomboolean() then
    -- top or bottom
    self.position = love2dx.Vector(
      math.random(Pray.AVOIDANCE_RADIUS, _G.width - Pray.AVOIDANCE_RADIUS),
      luax.randomtable({Pray.AVOIDANCE_RADIUS, _G.height - Pray.AVOIDANCE_RADIUS})
    )
  else
    -- left or right
    self.position = love2dx.Vector(
      luax.randomtable({Pray.AVOIDANCE_RADIUS, _G.width - Pray.AVOIDANCE_RADIUS}),
      math.random(Pray.AVOIDANCE_RADIUS, _G.height - Pray.AVOIDANCE_RADIUS)
    )
  end
  self.velocity = love2dx.Vector:random() * math.random(Pray.MIN_SPEED, Pray.MAX_SPEED)
end

-- Steer away from predators
function Pray:_attention()
  local predator = Game.predator()
  local radius = Pray.AVOIDANCE_RADIUS * Pray.PREDATOR_AMPLIFIER
  if self.position:distance(predator.position) < radius then
    local vector = (self.position - predator.position)
    self.delta = self.delta + (vector:normalize() * (radius * Pray.AVOIDANCE_AMPLIFIER / vector:sqrt()))
  end
end

-- Steer towards average position of neighbours (long range attraction)
function Pray:_cohesion()
  local vector = love2dx.Vector:zero()
  local n = 0
  for _, entity in ipairs(Game.prays()) do
    if entity ~= self and self.position:distance(entity.position) < Pray.COHESION_RADIUS then
      vector = vector + entity.position
      n = n + 1
    end
  end
  if n == 0 then return end
  vector = vector / n
  self.delta = self.delta + ((vector - self.position) / Pray.COHESION_DAMPER)
end

-- Steer towards average heading of neighbours
function Pray:_aligment()
  local vector = love2dx.Vector(_G.width / 2, _G.height / 2)
  local n = 0
  for _, entity in ipairs(Game.prays()) do
    local distance = self.position:distance(entity.position)
    if entity ~= self and distance < Pray.ALIGNMENT_RADIUS then
      vector = vector + entity.velocity--:divide(distance)
      n = n + 1
    end
  end
  if n == 0 then return end
  vector = vector / n
  self.delta = self.delta + ((vector - self.position) / Pray.COHESION_DAMPER)
end

-- Avoid crowding neighbours (short range repulsion)
function Pray:_avoidance()
  for _, entity in ipairs(Game.prays()) do
    if entity ~= self and self.position:distance(entity.position) < Pray.AVOIDANCE_RADIUS then
      local vector = (self.position - entity.position)
      self.delta = self.delta + (vector:normalize() * (Pray.AVOIDANCE_RADIUS * Pray.AVOIDANCE_AMPLIFIER / vector:sqrt()))
    end
  end
  -- walls
  if self.position.x < Pray.AVOIDANCE_RADIUS or self.position.x > _G.width - Pray.AVOIDANCE_RADIUS then
    self.velocity.x = self.velocity.x * -1
  elseif self.position.y < Pray.AVOIDANCE_RADIUS or self.position.y > _G.height - Pray.AVOIDANCE_RADIUS then
    self.velocity.y = self.velocity.y * -1
  end
  -- edges of screen
  self.position.x = math.clamp(self.position.x, Pray.AVOIDANCE_RADIUS, _G.width - Pray.AVOIDANCE_RADIUS)
  self.position.y = math.clamp(self.position.y, Pray.AVOIDANCE_RADIUS, _G.height - Pray.AVOIDANCE_RADIUS)
end

function Pray:update(dt)
  assert(type(dt) == "number")
  -- delta
  self.delta = love2dx.Vector:zero()
    -- order matters here
    self:_attention()
    self:_cohesion()
    self:_aligment()
    self:_avoidance()
    self.velocity = self.velocity + self.delta
  self.delta = nil
  -- speed limit
  if self.velocity:sqrt() > Pray.MAX_SPEED then
    self.velocity = self.velocity / self.velocity:sqrt() * Pray.MAX_SPEED
  end
  if self.velocity:sqrt() < Pray.MIN_SPEED then
    self.velocity = self.velocity / self.velocity:sqrt() * Pray.MIN_SPEED
  end
  -- apply
  self.position = self.position + self.velocity * dt
end

function Pray:draw()
  -- attention
  love.graphics.setColor(_G.colors.pink.r, _G.colors.pink.g, _G.colors.pink.b, 0.25)
  local predator = Game.predator()
  local radius = Pray.AVOIDANCE_RADIUS * Pray.PREDATOR_AMPLIFIER
  if self.position:distance(predator.position) < radius then
    love.graphics.line(self.position.x, self.position.y, predator.position.x, predator.position.y)
  end
  -- self
  love.graphics.setColor(_G.colors.white.r, _G.colors.white.g, _G.colors.white.b, 1.0)
  love.graphics.draw(
    _G.assets.s_pray,
    self.position.x, self.position.y,
    self.position:angle(self.position + self.velocity),
    1, 1, _G.assets.s_pray:getWidth() / 2, _G.assets.s_pray:getHeight() / 2
  )
  if _G.isDebug then
    -- love.graphics.setColor(_G.colors.comments.r, _G.colors.comments.g, _G.colors.comments.b, 0.25)
    -- love.graphics.circle("line", self.position.x, self.position.y, Pray.AVOIDANCE_RADIUS)
    -- love.graphics.setColor(_G.colors.yellow.r, _G.colors.yellow.g, _G.colors.yellow.b, 0.25)
    -- love.graphics.circle("line", self.position.x, self.position.y, Pray.AVOIDANCE_RADIUS * Pray.PREDATOR_AMPLIFIER)
    Game.prays(self):each(function (_, pray)
      if self.position:distance(pray.position) < Pray.COHESION_RADIUS then
        love.graphics.setColor(_G.colors.green.r, _G.colors.green.g, _G.colors.green.b, 0.5)
        love.graphics.line(self.position.x, self.position.y, pray.position.x, pray.position.y)
      end
      if self.position:distance(pray.position) < Pray.AVOIDANCE_RADIUS then
        love.graphics.setColor(_G.colors.orange.r, _G.colors.orange.g, _G.colors.orange.b, 0.5)
        love.graphics.line(self.position.x, self.position.y, pray.position.x, pray.position.y)
      end
    end)
  end
end

return Pray
