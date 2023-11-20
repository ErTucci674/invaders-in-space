Player = Entity:extend()

function Player:new(image, x, y)
    Player.super.new(self, image, x, y)
    self.health = 1 --PLAYER_HEALTH
    self.width = PLAYER_WIDTH
    self.height = PLAYER_HEIGHT
    self.speed = PLAYER_SPEED

    self:setQuads()
    self.current_texture = 1
    self.texture = self.quads[self.current_texture]
    self.texture_change = 0.1
    self.texture_timer = 0

    self.immortal = false
    self.hit_stop = 0.1
    self.hit_timer = self.hit_stop

    self.visibility = true
end

function Player:update(dt)
    -- Move Player and keep it in the screen
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
        if self.x <= 0 then
            self.x = 0
        end
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
        if self.x + self.width >= WINDOW_WIDTH then
            self.x = WINDOW_WIDTH - self.width
        end
    end
    self:textureUpdate(dt)
end

function Player:tutorialUpdate(dt)
    self.x = self.x + self.speed * dt
    if (self.x <= self.start_x or self.x >= self.start_x + 50) then
        self.speed = self.speed * (-1)
    end
    self:textureUpdate(dt)
end

function Player:draw()
    if (self.visibility) then
        love.graphics.draw(self.image, self.texture, self.x, self.y)
    end
end

-- Player Animation
function Player:textureUpdate(dt)
    if (self.hit_timer < self.hit_stop) then
        -- Select 'hit' texture
        self.current_texture = #self.quads
        self:textureChange()

        self.hit_timer = self.hit_timer + dt

        -- Reset the 'immortal' state
        if (self.hit_timer >= self.hit_stop) then
            self.immortal = false
        end
    elseif (self.texture_timer >= self.texture_change) then

        -- Change current texture/frame with the following one 
        self.current_texture = self.current_texture + 1
        if (self.current_texture > #self.quads - 1) then
            self.current_texture = 1
        end
        self:textureChange()
        -- Update timer
        self.texture_timer = self.texture_timer - self.texture_change
    else
        -- Increase timer
        self.texture_timer = self.texture_timer + dt
    end
end

function Player:textureChange()
    self.texture = self.quads[self.current_texture]
end

-- Show player's health as the first quad of the player's picture
function Player:healthDraw()
    local scale = 0.6
    for i=0,self.health - 1 do
        love.graphics.draw(self.image, self.quads[1], (self.width / 2 + i * (self.width + 5)) * scale, (self.height / 2) * scale, 0, scale, scale)
    end
end

function Player:checkDeath()
    if (self.health == 0) then
        return true
    end
    return false
end

function Player:hit(change)
    if (not self.immortal) then
        self.immortal = true
        playSound(player_hit_sound)
        self:updateHealth(change)
        self.hit_timer = 0
    end
end