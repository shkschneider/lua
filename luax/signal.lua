--[[ Listener ]]--

local Listener = luax.Class:new()

function Listener:constructor(sig, callback)
  assert(sig ~= nil)
  assert(type(callback) == "function")
  self.signal = sig
  self.callback = callback
end

--[[ Signal ]]--

local Signal = luax.Class:new("signal")

function Signal:constructor()
  self.listeners = luax.Array()
end

function Signal:register(sig, f)
  local size = #self.listeners
  self.listeners:pushlast(Listener(sig, f))
  return #self.listeners > size
end

function Signal:send(sig)
  local listeners = self.listeners:filter(function (listener)
    return listener.signal == sig
  end)
  luax.Log.verbose("Signal.send:" .. tostring(sig))
  listeners:each(function (_, listener)
    listener.callback(sig)
  end)
  return #listeners > 0
end

function Signal:unregister(signalOrCallback)
  local size = #self.listeners
  self.listeners = self.listeners:filter(function (listener)
    if type(signalOrCallback) == "function" then
      return listener.callback ~= signalOrCallback
    else
      return listener.signal ~= signalOrCallback
    end
  end)
  return #self.listeners < size
end

return Signal
