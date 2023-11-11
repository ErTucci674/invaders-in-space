Menu = Object:extend()

function Menu:new()
    strings = {"Start", "Quit"}
    font = love.graphics.newFont()

    options = {}
    for i,string in ipairs(strings) do
        table.insert(options, Text(string, font, WINDOW_WIDTH / 2, 100))
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