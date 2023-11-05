Projectile = Entity:extend()

function Projectile:new(x, y)
    Projectile.super.new(self, x, y)
    self.width = PROJECTILES_WIDTH
    self.height = PROJECTILES_HEIGHT
    self.speed = PROJECTILES_SPEED
end

function Projectile:update(dt, direction)
    self.y = self.y + self.speed * direction * dt
end

function Projectile:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
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