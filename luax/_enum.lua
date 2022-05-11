--[[
  LuaX - Dummy "enum" table.

  Just to show how constants can be used as enums.
--]]

Enum = {}
Enum.__index = Enum

Enum.ONE,
Enum.TWO,
Enum.THREE
= 1, 2, "three"
