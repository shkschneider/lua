local Button = Ui._Widget:new()

function Button:constructor(x, y, w, h, text, f)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  assert(type(text) == "string")
  assert(type(f) == "function")
  self.text = text
  self.callback = f
  self.isPressed = false
  Ui._Signal:register("mouse1pressed", function ()
    if not self.isPressed and self.super.isClicked(self) then
      self.isPressed = true
    end
  end)
  Ui._Signal:register("mouse1released", function ()
    if self.isPressed then
      self.callback()
      self.isPressed = false
    end
  end)
end

function Button:draw()
  local mode = self.isPressed and "fill" or "line"
  love.graphics.rectangle(mode, self.x, self.y, self.w, self.h)
  love.graphics.print(self.text, self.x, self.y)
end

return Button
