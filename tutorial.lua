Tutorial = Object:extend()

function Tutorial:new()
    local font = love.graphics.newFont()

    tutorial_strings = {
        "Move your spaceship with left and right arrow",
        "Shoot with space bar",
        "Shoot the aliens before they reach the bottom",
        "Don't let the aliens shoot you"
    }

    tutorial_pictures = {
        Player(player_pic, 0, 0),
        Projectile(projectile_pic, projectile_sound, 0, 0)
    }

    tutorial_lines = {}

    local half = 0
    if (#tutorial_strings > 1) then
        half = math.ceil(#tutorial_strings / 2)
    end
    local text_distance = 50
    local text_start = WINDOW_HEIGHT_CENTER - (text_distance / 2) * half

    for i,string in ipairs(tutorial_strings) do
        table.insert(tutorial_lines, Text(string, font, WINDOW_WIDTH_CENTER, text_start + text_distance * (i - 1)))
        if (i <= #tutorial_pictures) then
            tutorial_pictures[i].x = tutorial_lines[i].x + tutorial_lines[i].width + 10
            tutorial_pictures[i].y = tutorial_lines[i].y - tutorial_pictures[i].height / 2
        end
    end

end

function Tutorial:update(dt)

end

function Tutorial:draw()
    arrayDraw(tutorial_lines)
    arrayDraw(tutorial_pictures)
end