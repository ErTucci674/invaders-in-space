Entity = Object:extend()

function Entity:new(image, x, y)
    self.health = 0
    self.image = love.graphics.newImage(image)
    self.image_width = self.image:getWidth()
    self.image_height = self.image:getHeight()
    self.texture = 0
    self.x = x
    self.y = y
end

function Entity:updateHealth(change)
    self.health = self.health + change
end