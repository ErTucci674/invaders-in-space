Menu = Object:extend()

function Menu:new()
    options = {"Start", "Quit"}
    font = love.graphics.newFont()
    start_txt = Text("Start", font, 100, 100)
end

function Menu:update(dt)
    start_txt:update(dt)
end

function Menu:draw()
    start_txt:draw()
end