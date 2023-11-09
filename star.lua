Star = Entity:extend()

function Star:new(image, x, y)
    Star.super.new(self, image, x, y)
    self.speed = STAR_SPEED

    if (self.image_width == PLANETS_WIDTH * 3 + 3) then
        self.width = PLANETS_WIDTH
        self.height = PLANETS_HEIGHT
        self:setQuads()
    end

    self.quad = self.quads[math.random(1,3)]
end

function Star:update(dt)
    self.y = self.y + self.speed * dt
end

function Star:drawStar()
    love.graphics.draw(self.image, self.x, self.y)
end

function Star:drawPlanet()
    love.graphics.draw(self.image, self.quad, self.x, self.y)
end