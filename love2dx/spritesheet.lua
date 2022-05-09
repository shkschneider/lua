local Spritesheet = luax.Class:new("spritesheet")

function Spritesheet:constructor(image, size)
  assert(type(image) ~= nil)
  assert(type(size) == "number" and size > 0)
  assert(image:getWidth() % size == 0)
  assert(image:getHeight() % size == 0)
  self.image = image
  self.size = size
  self.quads = luax.Array:new()
  for h = 0, self.image:getHeight() - size, size do
    for w = 0, self.image:getWidth() - size, size do
      self.quads:pushlast(
        love.graphics.newQuad(w, h, size, size, self.image:getDimensions())
      )
    end
  end
end

function Spritesheet:draw(n, position)
  love.graphics.draw(self.image, self.quads[n], position:unpack())
end

return Spritesheet
