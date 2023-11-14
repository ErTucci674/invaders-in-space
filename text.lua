Text = Object:extend()

function Text:new(string, font, x, y)
    self.string = string
    self.font = love.graphics.newFont()
    self.text = love.graphics.newText(self.font, self.string)
    self.width = self.text:getWidth()
    self.height = self.text:getHeight()
    self.x = x - self.width / 2
    self.y = y - self.height / 2
end

function Text:update(dt)
    if (self:mouseOver()) then
        self.text:set({{255,0,0}, self.string})
        if (love.mouse.isDown(1)) then
            if (self.string == "Start") then
                current_page = "game"
            elseif (self.string == "Tutorial") then
                current_page = "tutorial"
            elseif (self.string == "Quit") then
                love.event.quit()
            end
        end
    else
        self.text:set({{255,255,255}, self.string})
    end
end

function Text:draw()
    love.graphics.draw(self.text, self.x, self.y)
end

function Text:mouseOver()
    local mousex, mousey = love.mouse.getPosition()
    if (mousex > self.x and mousex < self.x + self.width and mousey > self.y and mousey < self.y + self.height) then
        return true
    end
    return false
end