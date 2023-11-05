Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y)
    self.health = PLAYER_HEALTH
    self.health_txt = love.graphics.newText(love.graphics.getFont(), self.health)
    self.width = PLAYER_WIDTH
    self.height = PLAYER_HEIGHT
    self.speed = PLAYER_SPEED
end

function Player:update(dt)
    -- Move Player and keep it in the screen
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
        if self.x <= 0 then
            self.x = 0
        end
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
        if self.x + self.width >= WINDOW_WIDTH then
            self.x = WINDOW_WIDTH - self.width
        end
    end
end

function Player:draw()
    love.graphics.draw(self.health_txt, PLAYER_HEALTH_X, PLAYER_HEALTH_Y, 0, 1, 1, 0, 0)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

function Player:updateHealthTxt()
    self:checkDeath()
    self.health_txt:set(self.health)
end

function Player:checkDeath()
    if (self.health == 0) then
        love.event.quit('restart')
    end
end