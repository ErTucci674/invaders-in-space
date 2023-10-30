Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y)
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
        if self.x + self.width >= window_width then
            self.x = window_width - self.width
        end
    end
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end