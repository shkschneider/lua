local Sprite = luax.Class:new("sprite")

function Sprite:constructor(path, position)
  assert(type(path) == "string" and #path > 0)
  self.path = path
  self.image = love2dx.Cache:image(path)
  assert(self.image:getDimensions() ~= nil)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.position = position -- nullable
end

function Sprite:draw()
  love.graphics.draw(self.image, self.position.x, self.position.y)
end

return Sprite
