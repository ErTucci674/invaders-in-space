--   Copyright (C) 2023 Alessandro Amatucci Girlanda
 
--   This file is part of Invaders in Space.
 
--   Invaders in Space is free software: you can redistribute it and/or modify
--   it under the terms of the GNU General Public License as published by
--   the Free Software Foundation, either version 3 of the License, or
--   (at your option) any later version.
 
--   Invaders in Space is distributed in the hope that it will be useful,
--   but WITHOUT ANY WARRANTY; without even the implied warranty of
--   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
--   GNU General Public License for more details.
 
--   You should have received a copy of the GNU General Public License
--   along with Invaders in Space. If not, see <https://www.gnu.org/licenses/>.
 

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