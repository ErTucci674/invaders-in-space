Star = Entity:extend()

function Star:new(image, x, y)
    Star.super.new(self, image, x, y)
    self.speed = STAR_SPEED
end

function Star:update(dt)
    self.y = self.y + self.speed * dt
end

function Star:draw()
    love.graphics.draw(self.image, self.x, self.y)
end