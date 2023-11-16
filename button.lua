Button = Object:extend()

function Button:new(x, y, width, height)
    self.width = width
    self.height = height
    self.x = x - width / 4
    self.y = y - height / 4
end

function Button:update(dt)
    
end

function Button:draw()
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

function Button:mouseOver()
    local mousex, mousey = love.mouse.getPosition()
    if (mousex > self.x and mousex < self.x + self.width and mousey > self.y and mousey < self.y + self.height) then
        return true
    end
    return false
end