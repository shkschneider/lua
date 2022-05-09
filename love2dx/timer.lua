--[[
  https://github.com/rxi/coil/blob/master/coil.lua
  TODO: multiple tasks
--]]

local Timer = Class:new("timer")

function Timer:constructor()
  self.tick = 0
  self.callback = nil
end

function Timer:after(seconds, f, ...)
  assert(type(seconds) == "number")
  assert(type(f) == "function")
  self.n = seconds
  self.tick = 0
  self.callback = function (...)
    self.clock = nil
    f(...)
  end
end

function Timer:every(seconds, f, ...)
  assert(type(seconds) == "number")
  assert(type(f) == "function")
  self.n = seconds
  self.tick = 0
  self.callback = function (...)
    self.clock = os.clock()
    f(...)
  end
end

function Timer:update(dt)
  assert(type(dt) == "number")
  if type(self.callback) ~= "function" then return end
  self.tick = self.tick + dt
  if self.tick >= self.n then
    self.tick = self.tick - self.n
    self.callback()
  end
end

function Timer:cancel()
  self:constructor()
end

return Timer
