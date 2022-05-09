_G.isDebug = true

function love.conf(love)
  love.console = _G.isDebug
  love.window.fullscreen = false
  love.window.title = "Flock"
  love.window.width = 1440
  love.window.height = 900
end
