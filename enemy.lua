Enemy = Entity:extend()

function Enemy:new(x, y)
    Enemy.super.new(self, x, y)
    self.width = ENEMY_WIDTH
    self.height = ENEMY_HEIGHT
    self.speed = ENEMY_SPEED
end

function Enemy:update(dt, direction)
    self.x = self.x + self.speed * direction * dt
end

function Enemy:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    love.graphics.setColor(255, 255, 255)
end

function Enemy:adjust(enemies, direction)
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

function Enemy:removeColumn(enemies, column)
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
            enemies = self:removeColumn(enemies, column_check)
        end
    end

    return enemies
end