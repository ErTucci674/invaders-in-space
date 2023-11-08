Background = Object:extend()

function Background:new()
    require("star")

    self:loadPictures()

    self.stars = {}
    self.star_timer_max = 1
    self.star_timer = 0
end

function Background:update(dt)
    -- Generate stars
    self:generateStars(dt)

    -- Move stars
    self:updateStars(dt)

    -- Delete stars if over screen boundaries
    self:removeStars()
end

function Background:draw()
    for i,star in ipairs(self.stars) do
        star:draw()
    end
end

function Background:loadPictures()
    star_pic = love.graphics.newImage("pictures/star.png")
end

function Background:generateStars(dt)
    if (self.star_timer >= self.star_timer_max) then
        local star = Star(star_pic, math.random(0, WINDOW_WIDTH), 0)
        table.insert(self.stars, star)
        self.star_timer = 0
        self.star_timer_max = math.random(1, 5)
    else
        self.star_timer = self.star_timer + dt
    end
end

function Background:updateStars(dt)
    for i,star in ipairs(self.stars) do
        star:update(dt)
    end
end

function Background:removeStars()
    for i=#self.stars,1,-1 do
        if (self.stars[i].y >= WINDOW_HEIGHT) then
            table.remove(self.stars, i)
        end
    end
end