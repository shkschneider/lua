Corpse = Entity:extend("corpse")

function Corpse:constructor(position)
  self.position = position
end

function Corpse:draw()
  love.graphics.setColor(_G.colors.pink.r, _G.colors.pink.g, _G.colors.pink.b, 1.0)
  love.graphics.points(self.position.x, self.position.y)
end

return Corpse
