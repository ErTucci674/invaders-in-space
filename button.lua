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

Button = Object:extend()

function Button:new(x, y, width, height)
    self.width = width
    self.height = height
    self.x = x - width / 4
    self.y = y - height / 4
end

function Button:draw()
    self:background()
    if (self:mouseOver()) then
        love.graphics.setColor(0,0,255)
    end
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    love.graphics.setColor(255,255,255)
end

function Button:mouseOver()
    local mousex, mousey = love.mouse.getPosition()
    if (mousex > self.x and mousex < self.x + self.width and mousey > self.y and mousey < self.y + self.height) then
        return true
    end
    return false
end

function Button:background()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(255,255,255)
end