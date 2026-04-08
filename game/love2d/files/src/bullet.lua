local Bullet = {}
Bullet.__index = Bullet

local SPEED = 500
local WIDTH = 6
local HEIGHT = 6

function Bullet.new(x, y)
    return setmetatable({
        x = x - WIDTH / 2,
        y = y,
        w = WIDTH,
        h = HEIGHT,
    }, Bullet)
end

function Bullet:update(dt)
    self.y = self.y - SPEED * dt
end

function Bullet:draw()
    love.graphics.setColor(0.95, 0.9, 0.2)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Bullet
