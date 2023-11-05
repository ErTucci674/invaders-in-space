Entity = Object:extend()

function Entity:new(x, y)
    self.health = 0
    self.x = x
    self.y = y
    self.width = 0
    self.height = 0
    self.speed = 0
end

function Entity:updateHealth(change)
    self.health = self.health + change
end