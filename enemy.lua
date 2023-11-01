Enemy = Entity:extend()

function Enemy:new(x, y)
    Enemy.super.new(self, x, y)
    self.width = ENEMY_WIDTH
    self.height = ENEMY_HEIGHT
    self.speed = ENEMY_SPEED
end

function Enemy:update(dt, x, y)
    self.x = self.x + self.x * dt
    self.y = self.y + self.y * dt
end

function Enemy:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    love.graphics.setColor(255, 255, 255)
end