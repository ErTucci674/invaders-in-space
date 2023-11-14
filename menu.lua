Menu = Object:extend()

function Menu:new()
    strings = {"Start", "Tutorial", "Quit"}
    font = love.graphics.newFont()

    -- Creating and storing the menu selectable options
    options = {}
    local half = 0
    if (#strings > 1) then
        half = math.ceil(#strings / 2)
    end
    local text_distance = 20
    local text_start = WINDOW_HEIGHT_CENTER - (text_distance / 2) * half

    for i,string in ipairs(strings) do
        table.insert(options, Text(string, font, WINDOW_WIDTH / 2, text_start + text_distance * (i - 1)))
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