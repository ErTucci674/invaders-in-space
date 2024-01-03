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


Explosion = Entity:extend()

function Explosion:new(image, x, y)
    Explosion.super.new(self, image, x, y)
    self.width = PLAYER_WIDTH
    self.height = PLAYER_HEIGHT

    self:setQuads()
    self.current_texture = 1
    self.texture = self.quads[1]
    self.texture_change = 0.1
    self.texture_timer = 0

    self.exploded = false
end

function Explosion:update(dt)
    self:textureUpdate(dt)
end

function Explosion:tutorialUpdate(dt)
    if self.exploded then
        self.current_texture = 1
        self.exploded = false
    else
        self:textureUpdate(dt)
    end
end

function Explosion:draw()
    love.graphics.draw(self.image, self.texture, self.x, self.y)
end

function Explosion:textureChange()
    self.texture = self.quads[self.current_texture]
end

function Explosion:textureUpdate(dt)
    if (self.texture_timer >= self.texture_change) then
        -- Change current texture/frame with the following one 
        self.current_texture = self.current_texture + 1
        if (self.current_texture > #self.quads) then
            self.exploded = true
        else
            self:textureChange()
        end
        -- Update timer
        self.texture_timer = self.texture_timer - self.texture_change
    else
        -- Increase timer
        self.texture_timer = self.texture_timer + dt
    end
end

function Explosion:done()
    if (self.exploded) then
        return true
    end
    return false
end