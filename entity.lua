/*
 * Copyright (C) 2023 Alessandro Amatucci Girlanda
 *
 * This file is part of Invaders in Space.
 *
 * Invaders in Space is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Invaders in Space is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Invaders in Space. If not, see <https://www.gnu.org/licenses/>.
 */

Entity = Object:extend()

function Entity:new(image, x, y)
    self.health = 0

    self.quads = {}
    self.width = 0
    self.height = 0
    self.image = image
    self.image_width = self.image:getWidth()
    self.image_height = self.image:getHeight()

    self.x = x
    self.y = y

    self:setStart()
end

function Entity:updateHealth(change)
    self.health = self.health + change
end

-- Storing the image's quads (sections)
function Entity:setQuads()
    for i=0,math.floor(self.image_width / self.width) - 1 do
        local quad = love.graphics.newQuad((i)*(self.width + 1), 0, self.width, self.height, self.image_width, self.image_height)
        table.insert(self.quads, quad)
    end
end

function Entity:setStart()
    self.start_x = self.x
    self.start_y = self.y
end