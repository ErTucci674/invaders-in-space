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
 

Tutorial = Object:extend()

function Tutorial:new()
    local font = love.graphics.newFont()

    tutorial_strings = {
        "Move your spaceship with left and right arrows",
        "Shoot with space bar",
        "3 aliens - 3 difficulties",
        "Shoot the aliens before they reach the bottom",
        "Don't let the aliens shoot you",
        "Enraged by the death of their comrades, they will waste no time in annihilating you",
        "(At any time, press Escape to go back to the Menu)"
    }

    tutorial_pictures = {
        Player(player_pic, 0, 0),
        Projectile(projectile_pic, projectile_sound, 0, 0),
        {
            Enemy(enemies_pic, 0, 0, 1),
            Enemy(enemies_pic, 0, 0, 2),
            Enemy(enemies_pic, 0, 0, 3)
        },
        {
            Projectile(projectile_pic, projectile_sound, 0, 0),
            Enemy(enemies_pic, 0, 0, 1),
            Explosion(explosion_pic, 0, 0)
        },
        {
            Projectile(projectile_pic, projectile_sound, 0, 0),
            Player(player_pic, 0, 0),
            Explosion(explosion_pic, 0, 0)
        },
    }
    tutorial_pictures[1].tutorial_animation = true

    tutorial_lines = {}

    local text_distance = 80
    local picture_distance = 50
    local text_start = WINDOW_HEIGHT_CENTER - 0.5 * (#tutorial_strings - 1) * text_distance

    for i,string in ipairs(tutorial_strings) do
        table.insert(tutorial_lines, Text(string, font, WINDOW_WIDTH_CENTER - picture_distance, text_start + text_distance * (i - 1)))
    end

    -- Check the longest string
    local max_string = 0
    for i,line in ipairs(tutorial_lines) do
        if (line.x + line.width > max_string) then
            max_string = line.x + line.width
        end
    end

    local animation_speed = 30
    -- Shift pictures to the same 'x' value
    for i,picture in ipairs(tutorial_pictures) do
        -- check if it is a list
        if (#picture > 0) then
             for j,quad in ipairs(picture) do
                quad.x = max_string + picture_distance + quad.width * (j - 1)
                quad.y = tutorial_lines[i].y - quad.height / 2
                quad:setStart()
                quad.speed = animation_speed
            end
        else
            picture.x = max_string + picture_distance
            picture.y = tutorial_lines[i].y - picture.height / 2
            picture:setStart()
            picture.speed = animation_speed
        end
    end

end

function Tutorial:update(dt)
    for i,picture in ipairs(tutorial_pictures) do
        if (#picture > 0) then
            for j,quad in ipairs(picture) do
                quad:tutorialUpdate(dt)
            end
        else
            picture:tutorialUpdate(dt)
        end
    end
end

function Tutorial:draw()
    arrayDraw(tutorial_lines)
    arrayDraw(tutorial_pictures)
end