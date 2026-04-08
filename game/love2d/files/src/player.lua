local Player = {}
Player.__index = Player

local SPEED = 300
local WIDTH = 32
local HEIGHT = 32

function Player.new(x, y)
    return setmetatable({
        x = x,
        y = y,
        w = WIDTH,
        h = HEIGHT,
    }, Player)
end

function Player:update(dt)
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.x = self.x - SPEED * dt
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.x = self.x + SPEED * dt
    end
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.y = self.y - SPEED * dt
    end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        self.y = self.y + SPEED * dt
    end

    -- Clamp to screen
    self.x = math.max(0, math.min(self.x, 800 - self.w))
    self.y = math.max(0, math.min(self.y, 600 - self.h))
end

function Player:draw()
    love.graphics.setColor(0.2, 0.8, 0.3)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Player
