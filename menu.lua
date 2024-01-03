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
 

Menu = Object:extend()

function Menu:new()
    local strings = {"Start", "Tutorial", "Quit"}
    local font = love.graphics.newFont()

    -- Creating and storing the menu selectable options
    menu_buttons = {}
    menu_options = {}
    local text_distance = 60
    local text_start = WINDOW_HEIGHT_CENTER - 0.5 * (#strings - 1) * text_distance

    -- Store text and check longest string length
    local max_string = 0
    local max_x = 0
    for i,string in ipairs(strings) do
        table.insert(menu_options, Text(string, font, WINDOW_WIDTH_CENTER, text_start + text_distance * (i - 1)))
        if (menu_options[i].width > max_string) then
            max_string = menu_options[i].width
            max_x = menu_options[i].x
        end
    end

    -- Generate buttons
    for i,option in ipairs(menu_options) do
        table.insert(menu_buttons, Button(max_x, option.y, max_string * 2, option.height * 2))
    end
end

function Menu:update(dt)
    -- Check if player clicked any of the buttons
    for i,button in ipairs(menu_buttons) do
        if (button:mouseOver()) then
            if (love.mouse.isDown(1)) then
                current_page = menu_options[i].string
                if (current_page == "Start") then
                    love.audio.play(back_music)
                end
            end
        end
    end
end

function Menu:draw()
    arrayDraw(menu_buttons)
    arrayDraw(menu_options)
end