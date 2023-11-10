Text = Object:extend()

function Text:new(string, font, x, y)
    self.string = string
    self.font = love.graphics.newFont()
    self.text = love.graphics.newText(self.font, self.string)
    self.width = self.text:getWidth()
    self.height = self.text:getHeight()
    self.x = x
    self.y = y
end

function Text:update(dt)
    if (self:mouseOver()) then
        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(255, 255, 255)
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