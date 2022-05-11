local Audio = luax.Class:new("audio")

Audio._VOLUME = 1.0
Audio.SOUND = "static"
Audio.MUSIC = "stream"

function Audio:constructor(path, _type)
  assert(type(path) == "string" and #path > 0)
  assert(type(_type) == "string" and #_type > 0)
  self.name = luax.Path.basename(path)
  self.type = _type
  if self.type == Audio.SOUND then
    self.source = love2dx.Cache:sound(path)
  elseif self.type == Audio.MUSIC then
    self.source = love2dx.Cache:music(path)
  end
  assert(self.source ~= nil)
  self.source:setLooping(self.type == Audio.MUSIC)
end

function Audio:getVolume()
  return self.source:getVolume()
end

function Audio:setVolume(volume)
  assert(type(volume) == "number" and math.clamp(0.0, volume, 1.0) == volume)
  return self.source:setVolume(volume)
end

function Audio:play()
  love.audio.play(self.source)
end

function Audio:pause()
  love.audio.pause(self.source)
end

function Audio:stop()
  love.audio.stop(self.source)
end

return Audio
