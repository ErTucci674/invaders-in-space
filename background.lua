Background = Object:extend()

function Background:new()
    require("star")

    self:loadPictures()

    self.stars = {}
    self.planets = {}
    self.star_timer_max = 1
    self.star_timer = 0

    self:initStars()
end

function Background:update(dt)
    -- Generate, move and delete stars outside the window borders
    self:generateStars(dt)
    self:updateStars(dt)
    self:removeStars()

    for i,planet in ipairs(self.planets) do
        planet:update(dt)
    end
end

function Background:draw()
    for i,star in ipairs(self.stars) do
        star:drawStar()
    end
    for i,planet in ipairs(self.planets) do
        planet:drawPlanet()
    end
end

function Background:loadPictures()
    star_pic = love.graphics.newImage("pictures/star.png")
    planets_pic = love.graphics.newImage("pictures/planets.png")
end

function Background:initStars()
    for i=1,20 do
        local star = Star(star_pic, math.random(0,WINDOW_WIDTH), math.random(0,WINDOW_HEIGHT))
        table.insert(self.stars, star)
    end
end

function Background:generateStars(dt)
    if (self.star_timer >= self.star_timer_max) then
        -- local star = Star(star_pic, math.random(0, WINDOW_WIDTH), 0)
        local star = Star(planets_pic, math.random(0, WINDOW_WIDTH), 0)
        -- table.insert(self.stars, star)
        table.insert(self.planets, star)
        self.star_timer = 0
        self.star_timer_max = math.random(1, 3)
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