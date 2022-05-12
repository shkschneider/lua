local Text = Ui._Widget:new()

function Text:constructor(x, y, w, h, text)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  assert(type(text) == "string")
  self.text = text
end

function Text:draw()
  love.graphics.print(self.text, self.x, self.y)
end

return Text
