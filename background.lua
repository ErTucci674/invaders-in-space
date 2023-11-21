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
    -- Generate, move and delete stars (and planets) outside the window borders
    self:generateStars(dt)
    self:updateStars(dt)
    self:removeStars()
end

function Background:draw()
    self:drawStars()
end

function Background:titleDraw()
    love.graphics.draw(title_pic, WINDOW_WIDTH_CENTER - title_pic:getWidth() / 2, 100)
end

function Background:loadPictures()
    star_pic = love.graphics.newImage("pictures/star.png")
    planets_pic = love.graphics.newImage("pictures/planets.png")
end

function Background:initStars()
    -- Generate an Initial background
    for i=1,20 do
        local rand = math.random(1,100)
        if (rand <= 80) then
            table.insert(self.stars, Star(star_pic, math.random(0, WINDOW_WIDTH), math.random(0,WINDOW_HEIGHT)))
        else
            table.insert(self.planets, Star(planets_pic, math.random(0, WINDOW_WIDTH), math.random(0,WINDOW_HEIGHT)))
        end
    end
end

function Background:generateStars(dt)
    if (self.star_timer >= self.star_timer_max) then
        -- Create a random number and select whether generate a star or planet
        local rand = math.random(1,100)
        if (rand <= 80) then
            table.insert(self.stars, Star(star_pic, math.random(0, WINDOW_WIDTH), WINDOW_HEIGHT))
        else
            table.insert(self.planets, Star(planets_pic, math.random(0, WINDOW_WIDTH), WINDOW_HEIGHT + PLANETS_HEIGHT))
        end

        -- Reset timer and randomize a new max
        self.star_timer = 0
        self.star_timer_max = math.random(1, 2)
    else
        self.star_timer = self.star_timer + dt
    end
end

function Background:drawStars(dt)
    for i,star in ipairs(self.stars) do
        star:drawStar()
    end
    for i,planet in ipairs(self.planets) do
        planet:drawPlanet()
    end
end

function Background:updateStars(dt)
    for i,star in ipairs(self.stars) do
        star:update(dt)
    end

    for i,planet in ipairs(self.planets) do
        planet:update(dt)
    end
end

function Background:removeStars()
    for i=#self.stars,1,-1 do
        if (self.stars[i].y <= 0) then
            table.remove(self.stars, i)
        end
    end
    for i=#self.planets,1,-1 do
        if (self.planets[i].y <= -PLANETS_HEIGHT) then
            table.remove(self.planets, i)
        end
    end
end