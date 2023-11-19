Gameover = Object:extend()

function Gameover:new()
    self.win = win_pic
    self.lose = lose_pic
    self.result = self.lose
end

function Gameover:update(dt)

end

function Gameover:draw()
    love.graphics.draw(self.result, WINDOW_WIDTH_CENTER - self.result:getWidth() / 2, WINDOW_HEIGHT_CENTER - self.result:getHeight() / 2)
end

function Gameover:resultUpdate()
    self.result = self.win
end