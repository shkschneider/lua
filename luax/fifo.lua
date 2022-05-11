--[[
  LuaX - First-In First-Out array-like data structure, with Love!

  - type is "class"
  - has a fixed size
  - just push() and it pops automatically
  - you can :clear() anytime
--]]

local Fifo = luax.Class:new("fifo")

function Fifo:constructor(size)
  assert(type(size) == "number")
  self.size = size
  -- TODO love 5.2+: class.__len = function (t) ... end
  self.array = luax.Array()
  return self
end

function Fifo:push(value)
  if #self.array == self.size then
    self.array:popfirst()
  end
  self.array:pushlast(value)
end

function Fifo:clear()
  self.array = luax.Array()
end

return Fifo
