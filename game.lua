Game = Object:extend()

function Game:new()  
    -- Check if player lost
    self.game_over = false
    self.player_dead = false

    -- Create Objects/Entities
    self.player = Player(player_pic, WINDOW_WIDTH_CENTER - PLAYER_WIDTH / 2, WINDOW_HEIGHT - PLAYER_HEIGHT * 2)

    -- Create Projectiles
    self.projectiles_timer = PROJECTILES_WAIT
    self.projectiles = {}

    -- Create Enemies
    self.enemies_adjust = false
    local enemies_x_start = (WINDOW_WIDTH - (ENEMIES_COLS * ENEMY_WIDTH + (ENEMIES_COLS - 1) * ENEMIES_GAP)) / 2
    local enemies_y_start = 30
    self.enemies_direction = 1
    
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

    self.enemies = {}
    for r=1,#enemies_rows do
        local tmp_enemies = {}
        for c=1,ENEMIES_COLS do
            local enemy = Enemy(enemies_pic, enemies_x_start + (ENEMY_WIDTH + ENEMIES_GAP) * (c - 1), enemies_y_start + (ENEMY_HEIGHT + ENEMIES_GAP) * (r - 1), enemies_rows[#enemies_rows - r + 1])
            table.insert(tmp_enemies, enemy)
        end
        table.insert(self.enemies, tmp_enemies)
    end

    -- Enemies Projectiles
    self.e_projectiles_wait = ENEMIES_PROJECTILES_WAIT
    self.e_projectiles_timer = 0
    self.e_projectiles = {}

    -- Explosions
    self.explosions = {}

    -- Game Over
    self.game_over_timer = 0
    self.game_over_wait = 2
end

function Game:update(dt)
    if (self.game_over) then
        self:gameOver(dt)
    else
        self:timersUpdate(dt)
        self.player:update(dt)
        self:projectilesUpdate(dt)
        self:aliensUpdate(dt)
        self:eProjectilesUpdate(dt)
    end
    self:explosionsUpdate(dt)
end

function Game:draw()
    arrayDraw(self.explosions)
    self:playerDraw()
    arrayDraw(self.projectiles)
    self:enemiesDraw()
    arrayDraw(self.e_projectiles)
end

-- UPDATE FUNCTIONS --
function Game:timersUpdate(dt)
    -- Shoot no more than the maximum number of player's projectiles every "projectiles_wait" seconds
    if self.projectiles_timer < PROJECTILES_WAIT then
        self.projectiles_timer = self.projectiles_timer + dt
    end
    -- Shoot enemies' projectiles every "e_projectiles_wait" seconds
    if self.e_projectiles_timer < ENEMIES_PROJECTILES_WAIT then
        self.e_projectiles_timer = self.e_projectiles_timer + dt
    end
end

function Game:projectilesUpdate(dt)
    -- Shoot Player's projectile
    if love.keyboard.isDown("space") and #self.projectiles < PROJECTILES_MAX and self.projectiles_timer >= PROJECTILES_WAIT then
        self.projectiles_timer = self.projectiles_timer - PROJECTILES_WAIT
        local projectile = Projectile(projectile_pic, projectile_sound, self.player.x + self.player.width / 2 - PROJECTILES_WIDTH / 2, self.player.y)
        table.insert(self.projectiles, projectile)
        playSound(projectile.sound)
    end

    -- Move Player's projectiles, if any
    for i,v in ipairs(self.projectiles) do
        v:update(dt, -1)
    end

    -- Clear player's projectiles (avoiding memory leaks)
    for i=#self.projectiles,1,-1 do
        if self.projectiles[i].y + self.projectiles[i].height <= 0 then
            table.remove(self.projectiles, i)
        end
    end
end

function Game:aliensUpdate(dt)
    -- Aliens movement
    for i,v in ipairs(self.enemies) do
        for j,enemy in ipairs(v) do
            if (enemy ~= 0) then
                enemy:update(dt, self.enemies_direction)
                if (self.enemies_direction == 1 and enemy.x + enemy.width > WINDOW_WIDTH) or (self.enemies_direction == -1 and enemy.x < 0) then
                    self.enemies_adjust = true
                    self.enemies_direction = self.enemies_direction * -1
                end
                -- Check for collision with projectiles, if any
                -- Remove projectile and reset projectile timer
                -- Remove enemy (set it to zero)
                for p,projectile in ipairs(self.projectiles) do
                    if (projectile:collision(enemy, -1)) then
                        self.projectiles_timer = PROJECTILES_WAIT
                        table.remove(self.projectiles, p)

                        self.enemies[i][j]:updateHealth(-1)
                        if (self.enemies[i][j].health == 0) then
                            -- Explosion animation
                            self:generateExplosion(self.enemies[i][j].x, self.enemies[i][j].y)

                            self.enemies[i][j] = 0
                            -- Check if the whole column is zero
                            if (j == 1 or j == #v) then
                                self.enemies = removeColumn(self.enemies, j)
                            end

                            -- Chech if all enemies are dead
                            if (#self.enemies[1] <= 0) then
                                gameover:resultUpdate()
                                current_page = "Game Over"
                            else
                                self.enemies = updateEnemiesSpeed(self.enemies, 0.5)
                            end
                        end

                        break
                    end
                end
            end
        end
    end
    -- Adjust the enemies in the screen
    if (self.enemies_adjust) then
        self.enemies = adjustEnemies(self.enemies, self.enemies_direction * -1)
        self.enemies_adjust = false
    end

    -- Check Enemies colliding with the player
    self.game_over = enemiesCollision(self.enemies, self.player)
end

function Game:eProjectilesUpdate(dt)
    -- Create Enemies projectiles
    if (self.e_projectiles_timer >= self.e_projectiles_wait) then
        self.e_projectiles_timer = self.e_projectiles_timer - self.e_projectiles_wait
        ::random_enemy::
        local e_row = math.random(1, #self.enemies)
        local e_col = math.random(1, #self.enemies[1])
        if (self.enemies[e_row][e_col] == 0) then
            goto random_enemy
        elseif (self.enemies[e_row][e_col]) then
            local enemy = self.enemies[e_row][e_col]
            local e_projectile = Projectile(e_projectile_pic, e_projectile_sound, enemy.x + enemy.width / 2 - PROJECTILES_WIDTH / 2, enemy.y + enemy.height - PROJECTILES_HEIGHT)
            e_projectile.speed = ENEMIES_PROJECTILES_SPEED
            table.insert(self.e_projectiles, e_projectile)
            playSound(e_projectile_sound)
            self.e_projectiles_wait = math.random(1, 3)
        end
    end

    -- Move enemies' projectiles, if any
    for i,p in ipairs(self.e_projectiles) do
        p:update(dt, 1)
        
        -- Check if enemy's projectile collided with player
        if (p:collision(self.player, 1)) then
            table.remove(self.e_projectiles, i)
            self.player:hit(-1)
            self.game_over = self.player:checkDeath()
        end
    end

    -- Clear enemies' projectiles (avoiding memory leaks)
    for p=#self.e_projectiles,1,-1 do
       if (self.e_projectiles[p].y > WINDOW_HEIGHT) then
            table.remove(self.e_projectiles, p)
       end
    end
end

function Game:explosionsUpdate(dt)
    for i=#self.explosions,1,-1 do
        self.explosions[i]:update(dt)
        if (self.explosions[i]:done()) then
            table.remove(self.explosions, i)
        end
    end
end

-- DRAW FUNCTIONS --
function Game:playerDraw()
    self.player:healthDraw()
    self.player:draw()
end

function Game:enemiesDraw()
    for r,v in ipairs(self.enemies) do
        for c,enemy in ipairs(v) do
            if (self.enemies[r][c] ~= 0) then
                enemy:draw()
            end
        end
    end
end

-- GENERATE ENTITIES --
function Game:generateExplosion(x, y)
    table.insert(self.explosions, Explosion(explosion_pic, x, y))
    playSound(explosion_sound)
end

-- GAME LOSS --
function Game:gameOver(dt)
    if (gameover.status == "lose") then
        if (not self.player_dead) then
            self.player.visibility = false
            self:generateExplosion(self.player.x, self.player.y)
            self.player_dead = true                
        end
        if (self.game_over_timer >= self.game_over_wait) then
            current_page = "Game Over"
        else
            self.game_over_timer = self.game_over_timer + dt
        end
    else
        current_page = "Game Over"
    end
end