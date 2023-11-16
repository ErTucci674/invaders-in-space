Menu = Object:extend()

function Menu:new()
    local strings = {"Start", "Tutorial", "Quit"}
    local font = love.graphics.newFont()

    -- Creating and storing the menu selectable options
    menu_buttons = {}
    menu_options = {}
    local text_distance = 60
    local text_start = WINDOW_HEIGHT_CENTER - 0.5 * (#strings - 1) * text_distance

    -- Store text and check longest string length
    local max_string = 0
    local max_x = 0
    for i,string in ipairs(strings) do
        table.insert(menu_options, Text(string, font, WINDOW_WIDTH_CENTER, text_start + text_distance * (i - 1)))
        if (menu_options[i].width > max_string) then
            max_string = menu_options[i].width
            max_x = menu_options[i].x
        end
    end

    -- Generate buttons
    for i,option in ipairs(menu_options) do
        table.insert(menu_buttons, Button(max_x, option.y, max_string * 2, option.height * 2))
    end
end

function Menu:update(dt)
    arrayUpdate(dt,menu_options)
    arrayUpdate(dt,menu_buttons)
end

function Menu:draw()
    arrayDraw(menu_buttons)
    arrayDraw(menu_options)
end