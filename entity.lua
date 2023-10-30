Entity = Object:extend()

function Entity:new(x, y)
    self.x = x
    self.y = y
    self.height = 50
    self.width = 50
    self.speed = 800
end