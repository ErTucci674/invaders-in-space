Planet = Entity:extend()

function Planet:new(image, x, y)
    Planet.super.new(self, image, x, y)
    self.speed = STAR_SPEED
end

function Planet:update(dt)

end

function Planet:draw()

end