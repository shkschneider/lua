local Sprite = luax.Class:new("sprite")

function Sprite:constructor(name, position)
  assert(type(name) == "string" and #name > 0)
  self.name = name
  self.image = love.graphics.newImage(name)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.position = position -- nullable
end

function Sprite:draw()
  love.graphics.draw(self.image, self.position.x, self.position.y)
end

return Sprite
