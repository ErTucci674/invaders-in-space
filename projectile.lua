Projectile = Entity:extend()

function Projectile:new(image, sound, x, y)
    Projectile.super.new(self, image, x, y)
    self.width = PROJECTILES_WIDTH
    self.height = PROJECTILES_HEIGHT
    self.speed = PROJECTILES_SPEED

    self.quads = {}
    self:setQuads()
    self.current_texture = 1
    self.texture = self.quads[self.current_texture]
    self.texture_change = 0.1
    self.texture_timer = 0

    self:playSound(sound)
end

function Projectile:update(dt, direction)
    self.y = self.y + self.speed * direction * dt

    -- Update projectile texture every "texture_change" seconds
    if (self.texture_timer >= self.texture_change) then
        self:updateTexture()
        self.texture_timer = self.texture_timer - self.texture_change
    else
        self.texture_timer = self.texture_timer + dt
    end
end

function Projectile:draw()
    love.graphics.draw(self.image, self.texture, self.x, self.y)
end

-- Storing the image's quads (sections)
function Projectile:setQuads()
    for i=0,math.floor(self.image_width / self.width) - 1 do
        local quad = love.graphics.newQuad((i)*(self.width + 1), 0, self.width, self.height, self.image_width, self.image_height)
        table.insert(self.quads, quad)
    end
end

-- Projectile Animation
function Projectile:updateTexture()
    self.current_texture = self.current_texture + 1
    if (self.current_texture > #self.quads) then
        self.current_texture = 1
    end
    self.texture = self.quads[self.current_texture]
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