--[[
  https://en.wikipedia.org/wiki/Flocking_%28behavior%29
--]]

package.path = package.path .. ";../love2dx/?.lua"

require "love2dx"
Game = require "game"

function love.load()
  _G.clock = 0
  _G.width = love.graphics.getWidth()
  _G.height = love.graphics.getHeight()
  _G.isPaused = false
  _G.timeWarp = 1
  _G.entities = luax.Array:new()
  _G.level = 1
  _G.score = 0
  _G.colors = {
    -- monokai: https://gist.github.com/r-malon/8fc669332215c8028697a0bbfbfbb32a
    background = love2dx.rgb(46, 46, 46),
    comments = love2dx.rgb(121, 121, 121),
    white = love2dx.rgb(214, 214, 214),
    yellow = love2dx.rgb(229, 181, 103),
    green = love2dx.rgb(180, 210, 115),
    orange = love2dx.rgb(232, 125, 62),
    purple = love2dx.rgb(158, 134, 200),
    pink = love2dx.rgb(176, 82, 121),
    blue = love2dx.rgb(108, 153, 187),
  }
  _G.assets = {
    f_default = love.graphics.newImageFont("assets/f_default.png", " abcdefghijklmnopqrstuvwxyz" .. "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" .. "123456789.,!?-+/():;%&`'*#=[]\""),
    -- love.mouse.getSystemCursor("arrow")
    s_pray = love.graphics.newImage("assets/s_pray.png"),
    s_predator = love.graphics.newImage("assets/s_predator.png"),
    ss_particles1 = love2dx.Spritesheet(love.graphics.newImage("assets/ss_particles1.png"), 64),
    ss_particles2 = love2dx.Spritesheet(love.graphics.newImage("assets/ss_particles2.png"), 64),
    ss_particles3 = love2dx.Spritesheet(love.graphics.newImage("assets/ss_particles3.png"), 64),
    ss_particles4 = love2dx.Spritesheet(love.graphics.newImage("assets/ss_particles4.png"), 64),
    --[[
    s_smoke15 = Spritesheet(love.graphics.newImage("assets/s_smoke15.png"), 32),
    s_smoke30 = Spritesheet(love.graphics.newImage("assets/s_smoke30.png"), 32),
    s_smoke45 = Spritesheet(love.graphics.newImage("assets/s_smoke45.png"), 32),
    --]]
  }
  love.graphics.setDefaultFilter("nearest")
  love.graphics.setFont(_G.assets.f_default)
  Game.load()
end

function love.keypressed(key, _, _)
  -- game
  if key == "escape" then
    _G.isPaused = not _G.isPaused
  end
  -- timewarp
  if key == "up" then
    _G.timeWarp = _G.timeWarp + 1
  elseif key == "down" then
    _G.timeWarp = _G.timeWarp - 1
  end
  -- debug
  if key == "backspace" then
    _G.isDebug = not _G.isDebug
  end
  if not _G.isDebug then return end
  if key == "space" then
    _G.entities:pushlast(Pray())
  elseif key == "r" then
    _G.entities:clear()
    Game.load()
  end
end

function love.update(dt)
  if _G.isPaused then return end
  _G.clock = _G.clock + dt
  Game.update(dt)
  _G.entities:each(function (_, entity)
    entity:update(dt * _G.timeWarp)
  end)
end

function love.draw()
  -- debug
  if _G.isDebug then
    love.graphics.printf(love.timer.getFPS() .. " FPS N=" .. #_G.entities:filter(function (e) return e:is(Pray) end), 0, 0 + _G.assets.f_default:getHeight(), _G.width, "left")
    love.graphics.printf("DEBUG", 0, _G.height - _G.assets.f_default:getHeight(), _G.width, "center")
  end
  Game.draw()
  -- pause
  if _G.isPaused then
    love.graphics.setColor(0, 0, 0, 0.33)
    love.graphics.rectangle("fill", 0, 0, _G.width, _G.height)
    love.graphics.setColor(_G.colors.white.r, _G.colors.white.g, _G.colors.white.b, 1.0)
    love.graphics.printf("GAME PAUSED", 0, _G.height / 2, _G.width, "center")
  else
    love.graphics.setColor(_G.colors.white.r, _G.colors.white.g, _G.colors.white.b, 1.0)
  end
end
