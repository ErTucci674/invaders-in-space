Projectile = Entity:extend()

function Projectile:new(x, y)
    Projectile.super.new(self, x, y)
    self.width = PROJECTILES_WIDTH
    self.height = PROJECTILES_HEIGHT
    self.speed = PROJECTILES_SPEED
end

function Projectile:update(dt)
    self.y = self.y - self.speed * dt
end

function Projectile:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end