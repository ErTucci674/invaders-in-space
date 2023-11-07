Enemy = Entity:extend()

function Enemy:new(image, x, y, health)
    Enemy.super.new(self, image, x, y)
    self.health = health
    self.width = ENEMY_WIDTH
    self.height = ENEMY_HEIGHT
    self.speed = ENEMY_SPEED

    self.quads = {}
    self:setQuads()
end

function Enemy:update(dt, direction)
    self:setTexture()
    self.x = self.x + self.speed * direction * dt
end

function Enemy:draw()
    love.graphics.draw(self.image, self.texture, self.x, self.y)
end

-- Storing the image's quads (sections)
function Enemy:setQuads()
    for i=0,math.floor(self.image_width / self.width) do
        quad = love.graphics.newQuad(1 + (i)*(self.width + 1), 1, self.width, self.height, self.image_width, self.image_height)
        table.insert(self.quads, quad)
    end
end

-- Enemy texture change depending on current health
function Enemy:setTexture()
    self.texture = self.quads[self.health]
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

-- Removing enemies' columns if none are present
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

function Enemy:enemiesCollision(enemies, e)
    -- Temporary list to check "hit-row"
    local row = {}

    for i=1,#enemies[1] do
        for j=#enemies,1,-1 do
            if (enemies[j][i] ~= 0) then
                -- table.insert(row, enemies[j][i])
                if (enemies[j][i].y + enemies[j][i].height > WINDOW_HEIGHT) then
                    love.event.quit('restart')
                elseif (enemies[j][i].y + enemies[j][i].height > e.y) then
                    if (enemies[j][i].x > e.x and enemies[j][i].x < e.x + e.width or enemies[j][i].x + enemies[j][i].width > e.x and enemies[j][i].x + enemies[j][i].width < e.x + e.width) then
                        love.event.quit('restart')
                    end
                end
                break
            end
        end
    end
end