local Enemy = {}
Enemy.__index = Enemy

local WIDTH = 28
local HEIGHT = 28

function Enemy.new()
    local speed = 100 + math.random() * 80
    return setmetatable({
        x = math.random(WIDTH, 800 - WIDTH),
        y = -HEIGHT,
        w = WIDTH,
        h = HEIGHT,
        speed = speed,
    }, Enemy)
end

function Enemy:update(dt)
    self.y = self.y + self.speed * dt
end

function Enemy:draw()
    love.graphics.setColor(0.85, 0.2, 0.2)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Enemy
