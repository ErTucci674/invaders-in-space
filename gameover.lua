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


Gameover = Object:extend()

function Gameover:new()
    self.status = "lose"
    self.win = win_pic
    self.lose = lose_pic
    self.result = self.lose
    self.title_posx = self.result:getWidth() / 2
    self.title_posy = self.result:getHeight() / 2 + 50

    local font = love.graphics.newFont()
    self.text = Text("Back to Menu", font, WINDOW_WIDTH_CENTER, WINDOW_HEIGHT_CENTER + self.title_posy)
    self.button = Button(self.text.x, self.text.y, self.text.width * 2, self.text.height * 2)

    self.current_sound = lose_sound
    self.sound_playing = false
end

function Gameover:update(dt)
    if not self.sound_playing then
        playSound(self.current_sound)
        self.sound_playing = true
    end
    if (self.button:mouseOver() and love.mouse.isDown(1)) then
        reset()
        current_page = "Menu"
    end
end

function Gameover:draw()
    love.graphics.draw(self.result, WINDOW_WIDTH_CENTER - self.title_posx, WINDOW_HEIGHT_CENTER - self.title_posy)
    self.button:draw()
    self.text:draw()
end

function Gameover:resultUpdate()
    self.status = "win"
    self.result = self.win
    self.current_sound = win_sound
    self.title_posx = self.result:getWidth() / 2
    self.title_posy = self.result:getHeight() / 2 + 50
end