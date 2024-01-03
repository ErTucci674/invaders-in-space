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

Enemy = Entity:extend()

function Enemy:new(image, x, y, health)
    Enemy.super.new(self, image, x, y)
    self.health = health
    self.width = ENEMY_WIDTH
    self.height = ENEMY_HEIGHT
    self.speed = ENEMY_SPEED

    self:setQuads()
    self:setTexture()
end

function Enemy:update(dt, direction)
    self:setTexture()
    self.x = self.x + self.speed * direction * dt
end

function Enemy:tutorialUpdate(dt)

end

function Enemy:draw()
    love.graphics.draw(self.image, self.texture, self.x, self.y)
end

-- Enemy texture change depending on current health
function Enemy:setTexture()
    self.texture = self.quads[self.health]
end

function Enemy:updateSpeed(change)
    self.speed = self.speed + change
end

function adjustEnemies(enemies, direction)
    -- Adjust aliens position in the screen depending on their direction
    -- Adjust to the right
    if (direction == 1) then
        for i=1,#enemies do
            for j=#enemies[i],1,-1 do
                if (enemies[i][j] ~= 0) then
                    enemies[i][j].x = WINDOW_WIDTH - enemies[i][j].width - (enemies[i][j].width + ENEMIES_GAP) * (#enemies[i] - j)
                end
            end
        end
    -- Adjust to the left
    else
        for i,v in ipairs(enemies) do
            for j,enemy in ipairs(v) do
                if (enemy ~= 0) then
                    enemy.x = 0 + (enemy.width + ENEMIES_GAP) * (j - 1)
                end
            end
        end
    end
    -- Drop all enemies by one enemy height
    for i,v in ipairs(enemies) do
        for j,enemy in ipairs(v) do
            if (enemy ~= 0) then
                enemy.y = enemy.y + enemy.height
            end
        end
    end
    return enemies
end

-- Removing enemies' columns if none are present
function removeColumn(enemies, column)
    column_check = 1

    -- Remove column if every row is zero
    for i=1,#enemies do
        if (enemies[i][column] ~= 0) then break end
        if (i == #enemies) then
            for j=1,#enemies do
                table.remove(enemies[j], column)
            end

            if (column == 0) then return enemies
            elseif (column > 1) then column_check = column - 1 end
            enemies = removeColumn(enemies, column_check)
        end
    end

    return enemies
end

function enemiesCollision(enemies, e)
    -- Temporary list to check "hit-row"
    local row = {}

    for i=1,#enemies[1] do
        for j=#enemies,1,-1 do
            if (enemies[j][i] ~= 0) then
                if (enemies[j][i].y + enemies[j][i].height > WINDOW_HEIGHT) then
                    return true
                elseif (enemies[j][i].y + enemies[j][i].height > e.y) then
                    if (enemies[j][i].x > e.x and enemies[j][i].x < e.x + e.width or enemies[j][i].x + enemies[j][i].width > e.x and enemies[j][i].x + enemies[j][i].width < e.x + e.width) then
                        return true
                    end
                end
                break
            end
        end
    end

    return false
end