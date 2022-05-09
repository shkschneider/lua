package.path = package.path .. ";../luax/?.lua"

Array = require "array"
Particle = require "particle"
Spritesheet = require "spritesheet"
Animation = require "animation"
Timer = require "timer"
Vector = require "vector"
Colors = require "colors"
require "love2dx"

function _print(first, second)
  _G.console:pushlast(tostring(first) .. "\t" .. tostring(second))
end

function love.load()
  love.mouse.setVisible(false)
  _G.console = Array:new()
  _G.particle = Particle(love.graphics.newImage("particle.png"), 16, function (system)
    system:setParticleLifetime(2, 5)
  	system:setEmissionRate(5)
  	system:setSizeVariation(1)
  	system:setLinearAcceleration(-20, -20, 20, 20)
  	system:setColors(1, 1, 1, 1, 1, 1, 1, 0)
  end)
  _G.spritesheet = Spritesheet(love.graphics.newImage("spritesheet.png"), 16)
  _G.animation = Animation(_G.spritesheet, 1, -1, function ()
    -- animation done
  end)
  _G.timer = Timer()
end

function love.update(dt)
  _G.console:clear()
  _print("FPS", love.timer.getFPS())
  _print("Time", love.timer.getTime())
  _print("WxH", _G.width .. "x" .. _G.height)
  _print("", "")
  _print("--[[Colors]]--", "")
  _print("Color.rgb(r,g,b)", Colors.rgb(255 / 2, 255 / 2, 255 / 2))
  _print("Color.rgba(r,g,b)", Colors.rgba(255 / 2, 255 / 2, 255 / 2, 255 / 2))
  _print("animation:draw(position)", _G.animation.draw)
  _print("", "")
  _print("--[[Particles]]--", "")
  _print("particle=Particle(image,size)", _G.particle)
  _print("particle:update(dt)", _G.particle.update)
  _print("particle:draw(position)", _G.particle.draw)
  _print("", "")
  _print("--[[Spritesheet]]--", "")
  _print("spritesheet=Spritesheet(image,size)", _G.spritesheet)
  _print("spritesheet:draw(n,position)", _G.spritesheet.draw)
  _print("", "")
  _print("--[[Animation]]--", "")
  _print("animation=Animation(spritesheet,duration,ttl,f())", _G.animation)
  _print("animation:draw(position)", _G.animation.draw)
  _print("", "")
  _print("--[[Timer]]--", "")
  _print("timer=Timer()", _G.timer)
  _print("timer:after(s,f())", _G.timer.after)
  _print("timer:every(s,f())", _G.timer.every)
  _print("timer:update(dt)", _G.timer.update)
  _print("timer:cancel()", _G.timer.cancel)
  _print("", "")
  _print("--[[Vector]]--", "")
  local vector = Vector()
  _print("vector=Vector()", vector)
  _print("Vector:zero()", Vector:zero())
  _print("Vector(1,2)", Vector(1, 2))
  _print("Vector:random()", Vector:random())
  local mouse = Vector:mouse()
  _print("Vector:mouse()", mouse)
  _print("mouse:dot(vector)", mouse:dot(vector))
  _print("mouse:heading()", mouse:heading())
  _print("mouse:lerp(vector,0.5)", mouse:lerp(vector, 0.5)) -- FIXME
  _print("mouse:rotate(math.pi*2)", mouse:rotate(math.pi * 2)) -- FIXME
  _print("mouse:translate(1,1)", mouse:translate(1, 1))
  _print("mouse:distance(vector)", mouse:distance(vector))
  _print("mouse:scale(1.1)", mouse:scale(1.1))
  _print("mouse:scale(1.1,2.2)", mouse:scale(1.1, 2.2))
  _print("mouse:magnitude()", mouse:magnitude())
  _print("mouse:angle(vector)", mouse:angle(vector))
  _print("mouse:sqrt()", mouse:sqrt())
  _print("mouse:normalize()", mouse:normalize())
  _print("mouse:isParallel(vector)", mouse:isParallel(vector))
  _print("mouse:unpack()", Array:new(mouse:unpack()))
  _G.particle:update(dt)
  _G.animation:update(dt)
end

function love.draw()
  _G.particle:draw(Vector:mouse())
  _G.spritesheet:draw(#_G.spritesheet.quads, Vector(_G.width - _G.spritesheet.size, _G.height - _G.spritesheet.size))
  _G.animation:draw(Vector:mouse():translate(-_G.spritesheet.size / 2))
  local y = 0
  _G.console:each(function (i, s)
    love.graphics.print(s, 0, y)
    y = y + 16
  end)
end

function love.keypressed(key, _, _)
  if key == "escape" then
    love.event.quit(0)
  end
end
