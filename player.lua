Player = Entity:extend()

function Player:new(image, x, y)
    Player.super.new(self, image, x, y)
    self.health = PLAYER_HEALTH
    self.health_txt = love.graphics.newText(love.graphics.getFont(), self.health)
    self.width = PLAYER_WIDTH
    self.height = PLAYER_HEIGHT
    self.speed = PLAYER_SPEED

    self.quads = {}
    self:setQuads()
    self.current_texture = 1
    self.texture = self.quads[self.current_texture]
    self.texture_change = 0.1
    self.texture_timer = 0
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
        if self.x + self.width >= WINDOW_WIDTH then
            self.x = WINDOW_WIDTH - self.width
        end
    end

    -- Update projectile texture every "texture_change" seconds
    if (self.texture_timer >= self.texture_change) then
        self:updateTexture()
        self.texture_timer = self.texture_timer - self.texture_change
    else
        self.texture_timer = self.texture_timer + dt
    end
end

function Player:draw()
    love.graphics.draw(self.health_txt, PLAYER_HEALTH_X, PLAYER_HEALTH_Y, 0, 1, 1, 0, 0)
    love.graphics.draw(self.image, self.texture, self.x, self.y)
end

-- Storing the image's quads (sections)
function Player:setQuads()
    for i=0,math.floor(self.image_width / self.width) - 1 do
        local quad = love.graphics.newQuad((i)*(self.width + 1), 0, self.width, self.height, self.image_width, self.image_height)
        table.insert(self.quads, quad)
    end
end

-- Player Animation
function Player:updateTexture()
    self.current_texture = self.current_texture + 1
    if (self.current_texture > #self.quads) then
        self.current_texture = 1
    end
    self.texture = self.quads[self.current_texture]
end

function Player:updateHealthTxt()
    self:checkDeath()
    self.health_txt:set(self.health)
end

function Player:checkDeath()
    if (self.health == 0) then
        love.event.quit('restart')
    end
end