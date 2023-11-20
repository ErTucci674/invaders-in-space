Button = Object:extend()

function Button:new(x, y, width, height)
    self.width = width
    self.height = height
    self.x = x - width / 4
    self.y = y - height / 4
end

function Button:draw()
    if (self:mouseOver()) then
        love.graphics.setColor(0,0,255)
    end
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    love.graphics.setColor(255,255,255)
end

function Button:mouseOver()
    local mousex, mousey = love.mouse.getPosition()
    if (mousex > self.x and mousex < self.x + self.width and mousey > self.y and mousey < self.y + self.height) then
        return true
    end
    return false
end