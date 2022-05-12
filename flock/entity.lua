Entity = luax.Class:new()

Entity.SIZE = 32
Entity.RADIUS = Entity.SIZE / 2 / 2

function Entity:load() end
function Entity:update(dt) end
function Entity:draw() end

return Entity
