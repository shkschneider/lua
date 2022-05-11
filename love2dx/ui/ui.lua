-- namespace
Ui = {}

-- internal Signal

Ui._Signal = luax.Signal()

function Ui.signal(sig)
  Ui._Signal:send(sig)
end

-- internal base Widget

Ui._Widget = luax.Class:new("widget")

function Ui._Widget:constructor(x, y, w, h) end

function Ui._Widget.isClicked(widget)
  local mouse = Vector:mouse()
  if math.clamp(widget.x, mouse.x, widget.x + widget.w) == mouse.x and math.clamp(widget.y, mouse.y, widget.y + widget.h) == mouse.y then
    return true
  end
  return false
end

function Ui._Widget:draw() end

-- public components

Ui.Text = require "ui.text"
Ui.Button = require "ui.button"
Ui.Checkbox = require "ui.checkbox"

return Ui
