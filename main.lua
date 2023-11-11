function love.load()
    -- Include files
    require("globals")

    Object = require("classic/classic")
    require("text")
    require("entity")
    require("background")
    require("menu")
    require("game")
    
    background = Background()
    menu = Menu()
    game = Game()

    adjustWindow()

    current_page = "game"

    love.audio.setVolume(0)

    local screenWidth, screenHeight = love.window.getDesktopDimensions()
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    
    local ratio = screenHeight / windowHeight
    local newWindowWidth = windowWidth * ratio

    blackRecWidth = (screenWidth - newWindowWidth) / 2
    blackRecHeight = screenHeight
end

function love.update(dt)
    if (current_page == "menu") then
        menu:update(dt)
    elseif (current_page == "game") then
        background:update(dt)
        game:update(dt)
    end
end

function love.draw()
    -- love.graphics.scale(sy,sy)

    if (current_page == "menu") then
        menu:draw()
    elseif (current_page == "game") then
        background:draw()
        game:draw()
    end

    if (love.window.getFullscreen()) then
        sidesDraw()
    end
end

-- Scale items depending on window size
function adjustWindow()
    sx = love.graphics.getWidth() / DEFAULT_WIDTH
    sy = love.graphics.getHeight() / DEFAULT_HEIGHT
    love.graphics.setDefaultFilter("nearest", "nearest")
end

-- TEMPORARY: window control
function love.keypressed(key)
    -- Close the game
    if key == "q" then
        love.event.quit()
    -- Reset game
    elseif key == "r" then
        love.event.quit('restart')
    -- Toggle Full Screen mode
    elseif key == "f" then
        if (love.window.getFullscreen()) then
            love.window.setFullscreen(false, "desktop")
        else
            love.window.setFullscreen(true, "desktop")
        end
        adjustWindow()
    end
end

-- Show array values (testing purposes)
function showArray(arr)
    for i=1,#arr do
        for j=1,#arr[i] do
            if (arr[i][j] ~= 0) then
                io.write(1, ' ')
            else
                io.write(0, ' ')
            end
        end
        print()
    end
    print(' --- ')
end

function sidesDraw()
    love.graphics.rectangle("fill", 0, 0, blackRecWidth, blackRecHeight)
    love.graphics.rectangle("fill", 1920 - blackRecWidth, 0, blackRecWidth, blackRecHeight)
end