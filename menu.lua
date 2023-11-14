Menu = Object:extend()

function Menu:new()
    local strings = {"Start", "Tutorial", "Quit"}
    local font = love.graphics.newFont()

    -- Creating and storing the menu selectable options
    menu_options = {}
    local half = 0
    if (#strings > 1) then
        half = math.ceil(#strings / 2)
    end
    local text_distance = 20
    local text_start = WINDOW_HEIGHT_CENTER - (text_distance / 2) * half

    for i,string in ipairs(strings) do
        table.insert(menu_options, Text(string, font, WINDOW_WIDTH_CENTER, text_start + text_distance * (i - 1)))
    end
end

function Menu:update(dt)
    local mousex, mousey = love.mouse.getPosition()
    arrayUpdate(dt,menu_options)
end

function Menu:draw()
    arrayDraw(menu_options)
end