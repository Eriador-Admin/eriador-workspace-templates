local Player = require("src.player")
local Enemy = require("src.enemy")
local Bullet = require("src.bullet")

local player
local enemies = {}
local bullets = {}
local score = 0
local enemySpawnTimer = 0
local ENEMY_SPAWN_INTERVAL = 1.5

function love.load()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.15)
    player = Player.new(400, 500)
end

function love.update(dt)
    player:update(dt)

    -- Spawn enemies
    enemySpawnTimer = enemySpawnTimer + dt
    if enemySpawnTimer >= ENEMY_SPAWN_INTERVAL then
        enemySpawnTimer = 0
        table.insert(enemies, Enemy.new())
    end

    -- Update bullets
    for i = #bullets, 1, -1 do
        bullets[i]:update(dt)
        if bullets[i].y < -10 then
            table.remove(bullets, i)
        end
    end

    -- Update enemies
    for i = #enemies, 1, -1 do
        enemies[i]:update(dt)
        if enemies[i].y > 620 then
            table.remove(enemies, i)
        end
    end

    -- Bullet-enemy collisions
    for i = #bullets, 1, -1 do
        for j = #enemies, 1, -1 do
            if checkCollision(bullets[i], enemies[j]) then
                table.remove(bullets, i)
                table.remove(enemies, j)
                score = score + 10
                break
            end
        end
    end

    -- Player-enemy collisions
    for i = #enemies, 1, -1 do
        if checkCollision(player, enemies[i]) then
            table.remove(enemies, i)
            score = math.max(0, score - 5)
        end
    end
end

function love.draw()
    player:draw()

    for _, bullet in ipairs(bullets) do
        bullet:draw()
    end

    for _, enemy in ipairs(enemies) do
        enemy:draw()
    end

    -- HUD
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. score, 10, 10)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        table.insert(bullets, Bullet.new(player.x + player.w / 2, player.y))
    end
end

function checkCollision(a, b)
    return a.x < b.x + b.w and
           a.x + a.w > b.x and
           a.y < b.y + b.h and
           a.y + a.h > b.y
end
