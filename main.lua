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
    enemies_adjust = false
    enemies_x_start = (WINDOW_WIDTH - (ENEMIES_COLS * ENEMY_WIDTH + (ENEMIES_COLS - 1) * ENEMIES_GAP)) / 2
    enemies_y_start = 30
    enemies_direction = 1
    enemies = {}
    for r=1,ENEMIES_ROWS do
        tmp_enemies = {}
        for c=1,ENEMIES_COLS do
            enemy = Enemy(enemies_x_start + (ENEMY_WIDTH + ENEMIES_GAP) * (c - 1), enemies_y_start + (ENEMY_HEIGHT + ENEMIES_GAP) * (r - 1))
            table.insert(tmp_enemies, enemy)
        end
        table.insert(enemies, tmp_enemies)
    end
end

function love.update(dt)
    player:update(dt)

    -- Shoot no more than the maximum number of projectiles every "projectiles_wait" seconds
    if projectiles_timer < PROJECTILES_WAIT then
        projectiles_timer = projectiles_timer + dt
    end

    if love.keyboard.isDown("space") and #projectiles < PROJECTILES_MAX and projectiles_timer >= PROJECTILES_WAIT then
        projectiles_timer = projectiles_timer - PROJECTILES_WAIT
        projectile = Projectile(player.x + player.width / 2 - PROJECTILES_WIDTH / 2, player.y)
        table.insert(projectiles, projectile)
    end

    -- Move projectiles, if any
    for i,v in ipairs(projectiles) do
        v:update(dt)
    end

    -- Clear projectiles (avoiding memory leaks)
    for i=#projectiles,1,-1 do
        if projectiles[i].y + projectiles[i].height <= 0 then
            table.remove(projectiles, i)
        end
    end

    -- Aliens movement
    for i,v in ipairs(enemies) do
        for j,enemy in ipairs(v) do
            if (enemy ~= 0) then
                enemy:update(dt, enemies_direction)
                if (enemies_direction == 1 and enemy.x + enemy.width > WINDOW_WIDTH) or (enemies_direction == -1 and enemy.x < 0) then
                    enemies_adjust = true
                    enemies_direction = enemies_direction * -1
                end
                -- Check for collision with projectiles, if any
                -- Remove projectile and reset projectile timer
                -- Remove enemy (set it to zero)
                for p,projectile in ipairs(projectiles) do
                    if (projectile:collision(enemy)) then
                        projectiles_timer = PROJECTILES_WAIT
                        table.remove(projectiles, p)
                        enemies[i][j] = 0

                        -- Check if the whole column is zero
                        if (j == 1 or j == #v) then
                            enemies = enemy:removeColumn(enemies, j)
                        end

                        showArray(enemies)

                        break
                    end
                end
            end
        end
    end

    -- Adjust the enemies in the screen
    if (enemies_adjust) then
        enemies = enemy:adjust(enemies, enemies_direction * -1)
        enemies_adjust = false
    end
end

function love.draw()
    player:draw()

    for i,p in ipairs(projectiles) do
        p:draw()
    end

    -- Draw if an alien is present in the current position (rather than a zero)
    for r,v in ipairs(enemies) do
        for c,enemy in ipairs(v) do
            if (enemies[r][c] ~= 0) then
                enemy:draw()
            end
        end
    end
end

-- TEMPORARY: close window
function love.keypressed(key)
    if key == "q" then
        love.event.quit()
    elseif key == "r" then
        love.event.quit('restart')
    end
end

-- Show array values (testing purposes)
function showArray(arr)
    for i=1,#arr do
        for j=1,#arr[i] do
            if (arr[i][j] ~= 0) then
                io.write(1, ' ')
            else
                io.write(0, ' ')
            end
        end
        print()
    end
    print(' --- ')
end