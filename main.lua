function love.load()
    -- Include files
    require("globals")

    Object = require("classic/classic")
    require("entity")
    require("player")
    require("projectile")
    require("enemy")
    
    -- Create Objects/Entities
    player = Player(WINDOW_WIDTH_CENTER - PLAYER_WIDTH / 2, WINDOW_HEIGHT - PLAYER_HEIGHT * 2)

    -- Create Projectiles
    projectiles_timer = PROJECTILES_WAIT
    projectiles = {}

    -- Create Enemies
    enemies_start = (WINDOW_WIDTH - (ENEMIES_COLS * ENEMY_WIDTH + (ENEMIES_COLS - 1) * ENEMIES_GAP)) / 2
    enemies = {}
    for r=1,ENEMIES_ROWS do
        tmp_enemies = {}
        for c=1,ENEMIES_COLS do
            enemy = Enemy(enemies_start + (ENEMY_WIDTH + ENEMIES_GAP) * (c - 1), 200 + (ENEMY_HEIGHT + ENEMIES_GAP) * (r - 1))
            table.insert(tmp_enemies, enemy)
        end
        table.insert(enemies, tmp_enemies)
    end
end

function love.update(dt)
    player:update(dt)

    -- Shoot no more than the maximum number of projectiles every "projectiles_wait" seconds
    if projectiles_timer < PROJECTILES_MAX then
        projectiles_timer = projectiles_timer + dt
    end

    if love.keyboard.isDown("space") and #projectiles < PROJECTILES_MAX and projectiles_timer >= PROJECTILES_WAIT then
        projectiles_timer = projectiles_timer - PROJECTILES_WAIT
        projectile = Projectile(player.x + player.width / 2 - PROJECTILES_WIDTH / 2, player.y)
        table.insert(projectiles, projectile)
    end

    for i,v in ipairs(projectiles) do
        v:update(dt)
    end

    -- Clear projectiles (avoiding memory leaks)
    for i=#projectiles,1,-1 do
        if projectiles[i].y + projectiles[i].height <= 0 then
            table.remove(projectiles, i)
        end
    end
end

function love.draw()
    player:draw()

    for i,v in ipairs(projectiles) do
        v:draw()
    end

    for r,v in ipairs(enemies) do
        for c,enemy in ipairs(v) do
            enemy.draw()
        end
    end
end

-- Temporary close window
function love.keypressed(key)
    if key == "q" then
        love.event.quit()
    end
end