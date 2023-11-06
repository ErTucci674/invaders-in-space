function love.load()
    -- Include files
    require("globals")

    Object = require("classic/classic")
    require("game")
    
    game = Game()

    sx = love.graphics.getWidth() / DEFAULT_WIDTH
    sy = love.graphics.getHeight() / DEFAULT_HEIGHT

    love.graphics.setDefaultFilter("nearest", "nearest")
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    love.graphics.scale(sx,sy)
    game:draw()
end

-- TEMPORARY: close window
function love.keypressed(key)
    if key == "q" then
        love.event.quit()
    elseif key == "r" then
        love.event.quit('restart')
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