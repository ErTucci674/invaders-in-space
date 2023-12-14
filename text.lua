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

Text = Object:extend()

function Text:new(string, font, x, y)
    self.string = string
    self.font = love.graphics.newFont()
    self.text = love.graphics.newText(self.font, self.string)
    self.width = self.text:getWidth()
    self.height = self.text:getHeight()
    self.x = x - self.width / 2
    self.y = y - self.height / 2
end

function Text:draw()
    love.graphics.draw(self.text, self.x, self.y)
end

function Text:mouseOver()
    local mousex, mousey = love.mouse.getPosition()
    if (mousex > self.x and mousex < self.x + self.width and mousey > self.y and mousey < self.y + self.height) then
        return true
    end
    return false
end