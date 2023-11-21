Tutorial = Object:extend()

function Tutorial:new()
    local font = love.graphics.newFont()

    tutorial_strings = {
        "Move your spaceship with left and right arrows",
        "Shoot with space bar",
        "3 aliens - 3 difficulties",
        "Shoot the aliens before they reach the bottom",
        "Don't let the aliens shoot you",
        "Kill the aliens fast, or they will outrun you!"
    }

    tutorial_pictures = {
        Player(player_pic, 0, 0),
        Projectile(projectile_pic, projectile_sound, 0, 0),
        {
            Enemy(enemies_pic, 0, 0, 1),
            Enemy(enemies_pic, 0, 0, 2),
            Enemy(enemies_pic, 0, 0, 3)
        },
        {
            Enemy(enemies_pic, 0, 0, 1),
            Explosion(explosion_pic, 0, 0)
        },

    }

    tutorial_lines = {}

    local text_distance = 80
    local picture_distance = 50
    local text_start = WINDOW_HEIGHT_CENTER - 0.5 * (#tutorial_strings - 1) * text_distance

    for i,string in ipairs(tutorial_strings) do
        table.insert(tutorial_lines, Text(string, font, WINDOW_WIDTH_CENTER - picture_distance, text_start + text_distance * (i - 1)))
    end

    -- Check the longest string
    local max_string = 0
    for i,line in ipairs(tutorial_lines) do
        if (line.x + line.width > max_string) then
            max_string = line.x + line.width
        end
    end

    local animation_speed = 30
    -- Shift pictures to the same 'x' value
    for i,picture in ipairs(tutorial_pictures) do
        -- check if it is a list
        if (#picture > 0) then
             for j,quad in ipairs(picture) do
                quad.x = max_string + picture_distance + quad.width * (j - 1)
                quad.y = tutorial_lines[i].y - quad.height / 2
                quad:setStart()
                quad.speed = animation_speed
            end
        else
            picture.x = max_string + picture_distance
            picture.y = tutorial_lines[i].y - picture.height / 2
            picture:setStart()
            picture.speed = animation_speed
        end
    end

end

function Tutorial:update(dt)
    for i,picture in ipairs(tutorial_pictures) do
        if (#picture > 0) then
            for j,quad in ipairs(picture) do
                quad:tutorialUpdate(dt)
            end
        else
            picture:tutorialUpdate(dt)
        end
    end
end

function Tutorial:draw()
    arrayDraw(tutorial_lines)
    arrayDraw(tutorial_pictures)
end