local Spritesheet = luax.Class:new()

function Spritesheet:constructor(path, size)
  assert(type(path) == "string" and #path > 0)
  assert(type(size) == "number" and size > 0)
  self.image = love.graphics.newImage(path) -- no cache
  assert(self.image:getDimensions() ~= nil)
  self.size = size
  assert(self.image:getWidth() % size == 0)
  assert(self.image:getHeight() % size == 0)
  self.quads = luax.Array()
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
