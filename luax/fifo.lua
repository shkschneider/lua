local Fifo = Class:new("fifo")

function Fifo:constructor(size)
  assert(type(size) == "number")
  self.size = size
  -- TODO love 5.2+: class.__len = function (t) ... end
  self.array = Array:new()
  return self
end

function Fifo:push(value)
  if #self.array == self.size then
    self.array:popfirst()
  end
  self.array:pushlast(value)
end

function Fifo:clear()
  self.array = Array:new()
end

return Fifo
