package.path = package.path .. ";../luax/?.lua"
require "luax"
-- namespace
love2dx = {}
love2dx.Animation = require "animation"
love2dx.Particle = require "particle"
love2dx.Spritesheet = require "spritesheet"
love2dx.Timer = require "timer"
love2dx.Vector = require "vector"
require "colors"

--[[ init ]]--

love.math.setRandomSeed(os.time())

_G.width = love.graphics.getWidth()
_G.height = love.graphics.getHeight()
