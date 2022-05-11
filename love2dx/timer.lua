local Task = luax.Class:new("timer.task")

function Task:constructor(delay, callback)
  assert(type(delay) == "number" and delay >= 0)
  assert(type(callback) == "function")
  self.callback = callback
  self.tick = 0
  self.delay = delay
end

function Task:update(dt)
  self.tick = self.tick + dt
  if self.tick >= self.delay then
    self.callback()
    self.callback = nil
  end
end

local Timer = luax.Class:new("timer")

function Timer:constructor()
  self.tasks = luax.Array()
end

function Timer:after(seconds, f)
  self.tasks:pushlast(Task(seconds, f))
end

function Timer:every(seconds, f)
  self:after(seconds, function ()
    f()
    self:every(seconds, f)
  end)
end

function Timer:update(dt)
  self.tasks = self.tasks:filter(function (task)
    return task.callback ~= nil
  end)
  self.tasks:each(function (_, task)
    task:update(dt)
  end)
end

function Timer:cancel(f)
  assert(type(f) == "nil" or type(f) == "function")
  if f == nil then
    self.tasks:clear()
  else
    self.tasks = self.tasks:filter(function (task)
      return task.callback ~= f
    end)
  end
end

return Timer
