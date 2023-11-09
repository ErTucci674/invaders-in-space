Game = Object:extend()

function Game:new()
    require("player")
    require("projectile")
    require("enemy")
    
    math.randomseed(os.time())

    loadPictures()
    loadSounds()

    -- Check if player lost
    game_over = false

    -- Create Objects/Entities
    player = Player(player_pic, WINDOW_WIDTH_CENTER - PLAYER_WIDTH / 2, WINDOW_HEIGHT - PLAYER_HEIGHT * 2)

    -- Create Projectiles
    projectiles_timer = PROJECTILES_WAIT
    projectiles = {}

    -- Create Enemies
    enemies_adjust = false
    local enemies_x_start = (WINDOW_WIDTH - (ENEMIES_COLS * ENEMY_WIDTH + (ENEMIES_COLS - 1) * ENEMIES_GAP)) / 2
    local enemies_y_start = 30
    enemies_direction = 1
    
    -- Every half number of enemy rows (round up) gains one additional health
    local enemies_rows = {}
    local enemies_to_insert = ENEMIES_ROWS
    local health = 1
    while(enemies_to_insert > 0) do
        local rows = math.ceil(enemies_to_insert / 2)
        for i=1,rows do
            table.insert(enemies_rows, health)
        end
        enemies_to_insert = enemies_to_insert - rows
        health = health + 1
    end

    enemies = {}
    for r=1,#enemies_rows do
        tmp_enemies = {}
        for c=1,ENEMIES_COLS do
            enemy = Enemy(enemies_pic, enemies_x_start + (ENEMY_WIDTH + ENEMIES_GAP) * (c - 1), enemies_y_start + (ENEMY_HEIGHT + ENEMIES_GAP) * (r - 1), enemies_rows[#enemies_rows - r + 1])
            table.insert(tmp_enemies, enemy)
        end
        table.insert(enemies, tmp_enemies)
    end

    -- Enemies Projectiles
    e_projectiles_wait = ENEMIES_PROJECTILES_WAIT
    e_projectiles_timer = 0
    e_projectiles = {}

    back_music:setVolume(0.3)
    love.audio.play(back_music)
end

function Game:update(dt)
    if (game_over) then
        love.event.quit('restart')
    end

    timersUpdate(dt)
    player:update(dt)
    projectilesUpdate(dt)
    aliensUpdate(dt)
    eProjectilesUpdate(dt)

end

function Game:draw()
    playerDraw()
    projectilesDraw()
    enemiesDraw()
    eProjectilesDraw()
end

-- UPDATE FUNCTIONS --
function timersUpdate(dt)
    -- Shoot no more than the maximum number of player's projectiles every "projectiles_wait" seconds
    if projectiles_timer < PROJECTILES_WAIT then
        projectiles_timer = projectiles_timer + dt
    end
    -- Shoot enemies' projectiles every "e_projectiles_wait" seconds
    if e_projectiles_timer < ENEMIES_PROJECTILES_WAIT then
        e_projectiles_timer = e_projectiles_timer + dt
    end
end

function projectilesUpdate(dt)
    -- Shoot Player's projectile
    if love.keyboard.isDown("space") and #projectiles < PROJECTILES_MAX and projectiles_timer >= PROJECTILES_WAIT then
        projectiles_timer = projectiles_timer - PROJECTILES_WAIT
        projectile = Projectile(projectile_pic, projectile_sound, player.x + player.width / 2 - PROJECTILES_WIDTH / 2, player.y)
        table.insert(projectiles, projectile)
    end

    -- Move Player's projectiles, if any
    for i,v in ipairs(projectiles) do
        v:update(dt, -1)
    end

    -- Clear player's projectiles (avoiding memory leaks)
    for i=#projectiles,1,-1 do
        if projectiles[i].y + projectiles[i].height <= 0 then
            table.remove(projectiles, i)
        end
    end
end

function aliensUpdate(dt)
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
                    if (projectile:collision(enemy, -1)) then
                        projectiles_timer = PROJECTILES_WAIT
                        table.remove(projectiles, p)

                        enemies[i][j]:updateHealth(-1)
                        if (enemies[i][j].health == 0) then
                            enemies[i][j] = 0
                            -- Check if the whole column is zero
                            if (j == 1 or j == #v) then
                                enemies = removeColumn(enemies, j)
                            end
                            -- Chech if all enemies are dead
                            if (#enemies[1] <= 0) then
                                print('DEAD')
                                love.event.quit('restart')
                            else
                                enemies = updateEnemiesSpeed(enemies, 0.5)
                            end
                        end

                        break
                    end
                end
            end
        end
    end
    -- Adjust the enemies in the screen
    if (enemies_adjust) then
        enemies = adjustEnemies(enemies, enemies_direction * -1)
        enemies_adjust = false
    end

    -- Check Enemies colliding with the player
    game_over = enemiesCollision(enemies, player)
end

function eProjectilesUpdate(dt)
    -- Create Enemies projectiles
    if (e_projectiles_timer >= e_projectiles_wait) then
        e_projectiles_timer = e_projectiles_timer - e_projectiles_wait
        ::random_enemy::
        local e_row = math.random(1, #enemies)
        local e_col = math.random(1, #enemies[1])
        if (enemies[e_row][e_col] == 0) then
            goto random_enemy
        elseif (enemies[e_row][e_col]) then
            enemy = enemies[e_row][e_col]
            e_projectile = Projectile(e_projectile_pic, e_projectile_sound, enemy.x + enemy.width / 2 - PROJECTILES_WIDTH / 2, enemy.y + enemy.height - PROJECTILES_HEIGHT)
            e_projectile.speed = ENEMIES_PROJECTILES_SPEED
            table.insert(e_projectiles, e_projectile)
            e_projectiles_wait = math.random(1, 3)
        end
    end

    -- Move enemies' projectiles, if any
    for i,p in ipairs(e_projectiles) do
        p:update(dt, 1)
        
        -- Check if enemy's projectile collided with player
        if (p:collision(player, 1)) then
            table.remove(e_projectiles, i)
            player:updateHealth(-1)
            game_over = player:checkDeath()
        end
    end

    -- Clear enemies' projectiles (avoiding memory leaks)
    for p=#e_projectiles,1,-1 do
       if (e_projectiles[p].y > WINDOW_HEIGHT) then
            table.remove(e_projectiles, p)
       end
    end
end

-- DRAW FUNCTIONS --
function playerDraw()
    player:draw()
end

function projectilesDraw()
    for i,p in ipairs(projectiles) do
        p:draw()
    end
end

function enemiesDraw()
    for r,v in ipairs(enemies) do
        for c,enemy in ipairs(v) do
            if (enemies[r][c] ~= 0) then
                enemy:draw()
            end
        end
    end
end

function eProjectilesDraw()
    for i,p in ipairs(e_projectiles) do
        p:draw()
    end
end

-- LOAD FUNCTIONS --
function loadPictures()
    player_pic = love.graphics.newImage("pictures/player.png")
    projectile_pic = love.graphics.newImage("pictures/projectile.png")
    enemies_pic = love.graphics.newImage("pictures/enemies.png")
    e_projectile_pic = love.graphics.newImage("pictures/e_projectile.png")
end

function loadSounds()
    back_music = love.audio.newSource("sounds/game.mp3", "stream")
    projectile_sound = love.audio.newSource("sounds/projectile.mp3", "static")
    e_projectile_sound = love.audio.newSource("sounds/e_projectile.mp3", "static")
end