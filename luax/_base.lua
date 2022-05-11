--[[
  LuaX - Dummy "base" table.
--]]

local TYPE = "base"

local Base = {
  __type = TYPE
}
Base.__index = Base

function Base:new(...)
  -- ...
  return setmetatable({}, self)
end

function Base:__tostring()
  return Base.TYPE .. "?"
end

return setmetatable(Base, {
  __call = function (self, ...)
    return Base:new(...)
  end
})
