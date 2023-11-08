Player = Entity:extend()

function Player:new(image, x, y)
    Player.super.new(self, image, x, y)
    self.health = PLAYER_HEALTH
    self.width = PLAYER_WIDTH
    self.height = PLAYER_HEIGHT
    self.speed = PLAYER_SPEED

    self:setQuads()
    self.current_texture = 1
    self.texture = self.quads[self.current_texture]
    self.texture_change = 0.1
    self.texture_timer = 0
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

    -- Update projectile texture every "texture_change" seconds
    if (self.texture_timer >= self.texture_change) then
        self:updateTexture()
        self.texture_timer = self.texture_timer - self.texture_change
    else
        self.texture_timer = self.texture_timer + dt
    end
end

function Player:draw()
    self:drawHealth()
    love.graphics.draw(self.image, self.texture, self.x, self.y)
end

-- Player Animation
function Player:updateTexture()
    self.current_texture = self.current_texture + 1
    if (self.current_texture > #self.quads) then
        self.current_texture = 1
    end
    self.texture = self.quads[self.current_texture]
end

-- Show player's health as the first quad of the player's picture
function Player:drawHealth()
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