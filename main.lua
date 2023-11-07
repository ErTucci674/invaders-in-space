function love.load()
    -- Include files
    require("globals")

    Object = require("classic/classic")
    require("game")
    
    game = Game()

    adjustWindow()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    love.graphics.scale(sx,sy)
    game:draw()
end

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
        love.window.setFullscreen(true, "desktop")
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