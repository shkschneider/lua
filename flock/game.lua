Entity = require "entity"
Predator = require "predator"
Pray = require "pray"
Corpse = require "corpse"
Effect = require "effect"

local Game = {}

function Game.predator()
  print("Game.predator")
  print(_G.entities)
  print(_G.entities:filter(function (e) return e:is(Predator) end))
  print(_G.entities:filter(function (e) return e:is(Pray) end))
  return _G.entities:filter(function (e) return e:is(Predator) end):first()
end

function Game.prays(selfToIgnore)
  return _G.entities:filter(function (e) return e ~= selfToIgnore and e:is(Pray) end)
end

function Game._predator()
  _G.entities:pushfirst(Predator())
end

function Game._pray()
  _G.entities:pushlast(Pray())
end

function Game._prays()
  luax.loop(10 * _G.level, function (_)
    Game._pray()
  end)
end

function Game.load()
  Game._predator()
  Game._prays()
  _G.entities:each(function (_, entity)
    entity:load()
  end)
end

function Game.update(dt)
  if #_G.entities:filter(function (e) return e:is(Pray) end) == 0 then
    -- bonus for any level completed in less than a minute
    local delta = math.clamp(60 * _G.level - _G.clock, 0, 60)
    if delta > 0 then
      _G.score = _G.score + math.floor(delta)
    end
    -- respawns (more) prays
    _G.level = _G.level + 1
    Game._prays()
    -- corpses stay forever
  end
end

function Game.draw()
  love.graphics.setBackgroundColor(_G.colors.background.r, _G.colors.background.g, _G.colors.background.b, 1.0)
  -- entities
  _G.entities:filter(function (e) return e:is(Corpse) end):each(function (_, e) e:draw() end)
  _G.entities:filter(function (e) return e:is(Effect) end):each(function (_, e) e:draw() end)
  _G.entities:filter(function (e) return e:is(Pray) end):each(function (_, e) e:draw() end)
  _G.entities:filter(function (e) return e:is(Predator) end):each(function (_, e) e:draw() end)
  -- score
  love.graphics.setColor(_G.colors.white.r, _G.colors.white.g, _G.colors.white.b, 1.0)
  love.graphics.printf("LEVEL #" .. _G.level .. "\nSCORE: " .. _G.score, 0, 0, _G.width, "center")
  love.graphics.printf("T+" .. _G.clock .. "s", 0, 0, _G.width, "left")
  love.graphics.printf("x" .. _G.timeWarp, 0, 0, _G.width, "right")
end

return Game
