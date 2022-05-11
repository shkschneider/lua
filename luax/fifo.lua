--[[
  LuaX - First-In First-Out array-like data structure, with Love!

  - type is "class"
  - has a fixed size
  - just push() and it pops automatically
  - you can :clear() anytime
--]]

local Fifo = luax.Class:new("fifo")

local function _entry(id, data)
  assert(type(id) == "string")
  return {
    id = id,
    data = data,
  }
end

function Fifo:constructor(size)
  assert(type(size) == "number" and size > 0)
  self.size = size
  -- TODO love 5.2+: class.__len = function (t) ... end
  self.array = luax.Array()
end

function Fifo:push(id, data)
  if #self.array == self.size then
    self.array:popfirst()
  end
  self.array:pushlast(_entry(id, data))
end

function Fifo:get(id)
  return self.array:filter(function (entry)
    return entry.id == id
  end):map(function (entry)
    return entry.data
  end):first()
end

function Fifo:clear()
  self.array:clear()
end

return Fifo
