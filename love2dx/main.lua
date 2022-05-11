require "love2dx"

function _print(first, second)
  _G.console:pushlast(tostring(first) .. "\t" .. tostring(second))
end

function love.load()
  love.mouse.setVisible(false)
  _G.console = luax.Array:new()
  _G.page = 1
  -- classes
  _G.audio = love2dx.Audio("sound.ogg", love2dx.Audio.SOUND)
  _G.particle = love2dx.Particle(love.graphics.newImage("particle.png"), 16, function (system)
    system:setParticleLifetime(2, 5)
  	system:setEmissionRate(5)
  	system:setSizeVariation(1)
  	system:setLinearAcceleration(-20, -20, 20, 20)
  	system:setColors(1, 1, 1, 1, 1, 1, 1, 0)
  end)
  _G.sprite = love2dx.Sprite("sprite.png")
  _G.sprite.position = Vector(_G.width - _G.sprite.width, _G.height - _G.sprite.height)
  _G.spritesheet = love2dx.Spritesheet("spritesheet.png", 16)
  _G.timer = love2dx.Timer()
  _G.animation = love2dx.Animation(_G.spritesheet, 1, -1, function ()
    -- animation done
  end)
  -- gui
  _G.widgets = luax.Array:new()
  local size = 48
  local position = Vector(_G.width - size - size, size)
  _G.widgets:pushlast(love2dx.Ui.Text(position.x, position.y, size, size, "Ui.Text"))
  position:translate(0, size * 2)
  _G.widgets:pushlast(love2dx.Ui.Button(position.x, position.y, size, size, "Ui.Button", function ()
    print("button clicked!")
  end))
  position:translate(0, size * 2)
  _G.widgets:pushlast(love2dx.Ui.Checkbox(position.x, position.y, size, size, false, function (isChecked)
    print("checkbox clicked! " .. tostring(isChecked))
  end))
  -- timers
  _G.timer:after(2, function () print("after 2 (once)") end)
  _G.timer:every(1, function () print("every 1") end)
  _G.timer:after(3, function () _G.timer:cancel() end)
  -- _G.audio:play() -- just annoying while developping
end

local function _page1()
  _print("", "")
  _print("--[[Animation]]--", "")
  _print("animation=Animation(spritesheet,duration,ttl,f())", _G.animation)
  _print("animation:draw(position)", _G.animation.draw)
  _print("", "")
  _print("--[[Audio]]--", "")
  _print("audio=Audio({path,Audio.SOUND})", _G.audio)
  _print("audio.name", _G.audio.name)
  _print("audio.type", _G.audio.type)
  _print("audio:play()", _G.audio.play)
  _print("audio:pause()", _G.audio.pause)
  _print("audio:play()", _G.audio.play)
  _print("audio:stop()", _G.audio.stop)
  _print("", "")
  _print("--[[Colors]]--", "")
  _print("rgb(r,g,b)", love2dx.rgb(255 / 2, 255 / 2, 255 / 2))
  _print("rgba(r,g,b)", love2dx.rgba(255 / 2, 255 / 2, 255 / 2, 255 / 2))
  _print("", "")
  _print("--[[Particles]]--", "")
  _print("particle=Particle(image,size)", _G.particle)
  _print("particle:update(dt)", _G.particle.update)
  _print("particle:draw(position)", _G.particle.draw)
  _print("", "")
  _print("--[[Sprite]]--", "")
  _print("sprite=Sprite(path,position)", _G.sprite)
  _print("sprite.name", _G.sprite.name)
  _print("sprite.dimensions", _G.sprite.width .. "x" .. _G.sprite.height)
  _print("", "")
  _print("--[[Spritesheet]]--", "")
  _print("spritesheet=Spritesheet(image,size)", _G.spritesheet)
  _print("spritesheet:draw(n,position)", _G.spritesheet.draw)
  _print("", "")
  _print("--[[Timer]]--", "")
  _print("timer=Timer()", _G.timer)
  _print("timer:after(2,f())", _G.timer.after)
  _print("timer:every(1,f())", _G.timer.every)
  _print("timer:update(dt)", _G.timer.update)
  _print("timer:cancel()", _G.timer.cancel)
end

local function _page2()
  _print("", "")
  _print("--[[Vector]]--", "")
  _print("Vector:zero()", Vector:zero())
  _print("Vector(1,2)", Vector(1, 2))
  _print("Vector:random()", Vector:random())
  local mouse = Vector:mouse()
  _print("Vector:mouse()", mouse)
  local vector = Vector()
  _print("vector=Vector()", vector)
  _print("mouse:dot(vector)", mouse:dot(vector))
  _print("mouse:heading()", mouse:heading())
  _print("mouse:rotate(math.pi*2)", mouse:copy():rotate(math.pi * 2))
  _print("mouse:translate(1,1)", mouse:copy():translate(1, 1))
  _print("mouse:distance(vector)", mouse:distance(vector))
  _print("mouse:scale(1.1)", mouse:copy():scale(1.1))
  _print("mouse:scale(1.1,2.2)", mouse:copy():scale(1.1, 2.2))
  _print("mouse:magnitude()", mouse:magnitude())
  _print("mouse:angle(vector)", mouse:angle(vector))
  _print("mouse:sqrt()", mouse:sqrt())
  _print("mouse:normalize()", mouse:normalize())
  _print("mouse:isParallel(vector)", mouse:isParallel(vector))
  _print("mouse:unpack()", luax.Array:new(mouse:unpack()))
end

function love.update(dt)
  _G.console:clear()
  _print("FPS", love.timer.getFPS())
  _print("Time", love.timer.getTime())
  _print("WxH", _G.width .. "x" .. _G.height)
  if _G.page == 1 then
    _page1()
    _print("", "")
    _print("", "")
    _print("Press <space> for next/previous page...", "")
  elseif _G.page == 2 then
    _page2()
  else
    _G.page = 1
  end
  _G.animation:update(dt)
  _G.particle:update(dt)
end

function love.keypressed(key, _, _)
  if key == "space" then
    _G.page = _G.page + 1
  elseif key == "escape" then
    love.event.quit(0)
  end
end

function love.mousepressed(x, y, button, _)
  if button == 1 then
    love2dx.Ui.signal("mouse1pressed")
  elseif button == 2 then
    love2dx.Ui.signal("mouse2pressed")
  end
end

function love.mousereleased(x, y, button, _)
  if button == 1 then
    love2dx.Ui.signal("mouse1released")
  elseif button == 2 then
    love2dx.Ui.signal("mouse2released")
  end
end

function love.draw()
  _G.particle:draw(Vector:mouse())
  _G.sprite:draw()
  --_G.spritesheet:draw(#_G.spritesheet.quads, Vector(_G.width, _G.height):translate(-_G.spritesheet.size)
  _G.animation:draw(Vector(0, _G.height - _G.spritesheet.size)) --Vector:mouse():translate(-_G.spritesheet.size / 2))
  local y = 0
  _G.widgets:each(function (_, widget)
    widget:draw()
  end)
  _G.console:each(function (_, line)
    love.graphics.print(line, 0, y)
    y = y + 16
  end)
end
