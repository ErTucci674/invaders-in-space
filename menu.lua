Menu = Object:extend()

function Menu:new()
    strings = {"Start", "Quit"}
    font = love.graphics.newFont()

    options = {}
    local tot = #strings
    local half = math.floor(tot / 2)
    local text_height = #strings[1]
    local text_distance = text_height * 4
    local text_start = WINDOW_HEIGHT_CENTER - text_distance * half

    for i,string in ipairs(strings) do
        table.insert(options, Text(string, font, WINDOW_WIDTH / 2, text_start + (i * text_distance)))
    end
end

function Menu:update(dt)
    local mousex, mousey = love.mouse.getPosition()
    for i,option in ipairs(options) do
        option:update(dt)
    end
end

function Menu:draw()
    for i,option in ipairs(options) do
        option:draw()
    end
end