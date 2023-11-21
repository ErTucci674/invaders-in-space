Projectile = Entity:extend()

function Projectile:new(image, sound, x, y)
    Projectile.super.new(self, image, x, y)
    self.width = PROJECTILES_WIDTH
    self.height = PROJECTILES_HEIGHT
    self.speed = PROJECTILES_SPEED
    self.sound = sound

    self:setQuads()
    self.current_texture = 1
    self.texture = self.quads[self.current_texture]
    self.texture_change = 0.1
    self.texture_timer = 0
end

function Projectile:update(dt, direction)
    self.y = self.y + self.speed * direction * dt

    -- Update projectile texture every "texture_change" seconds
    self:textureUpdate(dt)
end

function Projectile:tutorialUpdate(dt)
    self.y = self.y - self.speed * dt
    if (self.y <= self.start_y - PROJECTILES_TUTORIAL_HEIGHT) then
        self.y = self.start_y
    end
    self:textureUpdate(dt)
end

function Projectile:draw()
    love.graphics.draw(self.image, self.texture, self.x, self.y)
end

-- Projectile Animation
function Projectile:textureUpdate(dt)
    if (self.texture_timer >= self.texture_change) then
        self.current_texture = self.current_texture + 1
        if (self.current_texture > #self.quads) then
            self.current_texture = 1
        end
        self.texture = self.quads[self.current_texture]
        self.texture_timer = self.texture_timer - self.texture_change
    else
        self.texture_timer = self.texture_timer + dt
    end
end

function Projectile:collision(e, direction)
    -- Player's Projectile collision
    if (direction == -1) then
        if (self.y < e.y + e.height and self.y > e.y) then
            if ((self.x > e.x and self.x < e.x + e.width) or (self.x + self.width < e.x + e.width and self.x + self.width > e.x)) then
                return true
            end
            return false
        end
        return false
    -- Enemy's Projectile collision
    else
        if (self.y + self.height > e.y) then
            if ((self.x > e.x and self.x < e.x + e.width) or (self.x + self.width < e.x + e.width and self.x + self.width > e.x)) then
                return true
            end
        end
        return false
    end
end