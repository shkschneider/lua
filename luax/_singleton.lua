--[[
  LuaX - just return an instance in a require() to make a Singleton pattern with Love!
--]]

local Singleton = luax.Class:new("singleton")

function Singleton:constructor() end

return Singleton()
