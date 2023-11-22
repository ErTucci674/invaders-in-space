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