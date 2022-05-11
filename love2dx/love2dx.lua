package.path = package.path .. ";../luax/?.lua"
require "luax"

-- namespace
love2dx = {}
love2dx.Cache = require "cache"
love2dx.Animation = require "animation"
love2dx.Audio = require "audio"
love2dx.Particle = require "particle"
love2dx.Sprite = require "sprite"
love2dx.Spritesheet = require "spritesheet"
love2dx.Timer = require "timer"
love2dx.Vector = require "vector"
love2dx.Ui = require "ui.ui"
require "colors"

--[[ init ]]--

love.math.setRandomSeed(os.time())

_G.width = love.graphics.getWidth()
_G.height = love.graphics.getHeight()
