function love.load()
    -- Include files
    require("globals")

    Object = require("classic/classic")
    require("game")
    
    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
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