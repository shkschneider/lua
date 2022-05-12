local Checkbox = Ui._Widget:new()

function Checkbox:constructor(x, y, w, h, isChecked, f)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  assert(type(isChecked) == "boolean")
  assert(type(f) == "function")
  self.isChecked = isChecked
  self.callback = f
  Ui._Signal:register("mouse1pressed", function ()
    if self.super.isClicked(self) then
      self.isChecked = not self.isChecked
    end
  end)
  Ui._Signal:register("mouse1released", function ()
    if self.super.isClicked(self) then
      self.callback(self.isChecked)
    end
  end)
end

function Checkbox:draw()
  local mode = self.isChecked and "fill" or "line"
  love.graphics.rectangle(mode, self.x, self.y, self.w, self.h)
end

return Checkbox
