--[[
  TODO: standing still should lower score
--]]

Predator = Entity:extend("predator")

Predator.SPEED = 200
Predator.RANGE = Entity.RADIUS * 2
Predator.TIMER = 0.033
Predator.TRAILS = 100

function Predator:constructor()
  self.position = love2dx.Vector(_G.width / 2, _G.height / 2)
  self.velocity = love2dx.Vector(0, 0)
  self.positions = luax.Array:new()
end

function Predator:load()
  self.clock = love.timer.getTime()
end

function Predator:update(dt)
  assert(type(dt) == "number")
  local mouse = love2dx.Vector:mouse()
  -- move towards the mouse
  if self.position:distance(mouse) > Entity.RADIUS then
    local angle = math.atan2(mouse.x - self.position.x, mouse.y - self.position.y)
    self.position.x = self.position.x + math.sin(angle) * Predator.SPEED * dt
    self.position.y = self.position.y + math.cos(angle) * Predator.SPEED * dt
  end
  -- collision
  _G.entities:filter(function (e) return e:is(Pray) end):each(function (_, entity)
    print(self.position, entity.position, self.position:distance(entity.position))
    if entity ~= self and self.position:distance(entity.position) < Predator.RANGE then
      -- run on target
      self.position = (self.position + entity.position) / 2
      -- effect
      -- FIXME animation
      _G.entities:pushlast(Effect(entity.position:copy(), luax.randomtable({
        _G.assets.ss_particles1, _G.assets.ss_particles2, _G.assets.ss_particles3, _G.assets.ss_particles4
      })))
      -- kill
      _G.entities:pushlast(Corpse(entity.position:copy()))
      _G.entities:remove(entity)
      -- score
      _G.score = _G.score + _G.level
    end
  end)
  self.position = self.position + self.velocity * dt
  -- trails (using timer)
  if love.timer.getTime() - self.clock >= Predator.TIMER then
    self.clock = self.clock + Predator.TIMER
    self.positions:pushlast(self.position)
    if #self.positions > Predator.TRAILS then
      self.positions:popfirst()
    end
  end
end

function Predator:draw()
  -- trail
  self.positions:invert():each(function (i, position)
    local alpha = math.clamp(1 - i * (1 / Predator.TRAILS), 0, 1)
    if alpha >= 0.1 then
      love.graphics.setColor(_G.colors.comments.r, _G.colors.comments.g, _G.colors.comments.b, alpha)
      love.graphics.points(position.x, position.y)
    end
  end)
  -- predator
  local angle = _G.isPaused and love2dx.Vector:zero() or love2dx.Vector:mouse()
  love.graphics.setColor(_G.colors.white.r, _G.colors.white.g, _G.colors.white.b, 1.0)
  love.graphics.draw(
    _G.assets.s_predator,
    self.position.x, self.position.y,
    self.position:angle(angle),
    1, 1, _G.assets.s_predator:getWidth() / 2, _G.assets.s_predator:getHeight() / 2
  )
  love.graphics.setColor(_G.colors.orange.r, _G.colors.orange.g, _G.colors.orange.b, 0.25)
  love.graphics.circle("line", self.position.x, self.position.y, Predator.RANGE)
end

return Predator
