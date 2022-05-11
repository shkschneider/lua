--[[
  Love2dX - Simple caching of resources, with Love!

  Inspired by:
  - https://github.com/klembot/zoetrope/blob/main/zoetrope/core/cached.lua
--]]

local Cache = luax.Class:new("cache")

Cache._SIZE = 10

function Cache:constructor(size)
  self._images = luax.Fifo(size or Cache._SIZE)
  self._sounds = luax.Fifo(size or Cache._SIZE)
  self._musics = luax.Fifo(size or Cache._SIZE)
end

local function _get(fifo, id, f)
  luax.Class.assert(fifo, "fifo")
  assert(type(id) == "string" and #id > 0)
  assert(type(f) == "function")
  local data = fifo:get(id)
  if data == nil then
    fifo:push(id, f(id))
    data = fifo:get(id)
  end
  return data
end

function Cache:image(path)
  return _get(self._images, path, function (id)
    return love.graphics.newImage(id)
  end)
end

function Cache:sound(path)
  return _get(self._sounds, path, function (id)
    return love.audio.newSource(id, love2dx.Audio.SOUND)
  end)
end

function Cache:music(path)
  return _get(self._musics, path, function (id)
    return love.audio.newSource(id, love2dx.Audio.MUSIC)
  end)
end

return Cache()
