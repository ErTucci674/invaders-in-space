function love.load()
    -- Include files
    require("globals")

    Object = require("classic/classic")
    require("text")
    require("entity")
    require("background")
    require("menu")
    require("game")
    require("tutorial")
    require("button")
    
    loadPictures()
    loadSounds()

    background = Background()
    menu = Menu()
    game = Game()
    tutorial = Tutorial()

    adjustWindow()

    current_page = "menu"

    love.audio.setVolume(0.5)
end

function love.update(dt)
    if (current_page == "menu") then
        menu:update(dt)
    elseif (current_page == "game") then
        background:update(dt)
        game:update(dt)
    elseif (current_page == "tutorial") then
        tutorial:update(dt)
    end
end

function love.draw()
    love.graphics.scale(sx,sy)

    if (current_page == "menu") then
        menu:draw()
    elseif (current_page == "game") then
        background:draw()
        game:draw()
    elseif (current_page == "tutorial") then
        tutorial:draw()
    end
end

-- Scale items depending on window size
function adjustWindow()
    sx = love.graphics.getWidth() / DEFAULT_WIDTH
    sy = love.graphics.getHeight() / DEFAULT_HEIGHT
    love.graphics.setDefaultFilter("nearest", "nearest")
end

-- Drawing functions
function arrayUpdate(dt, array)
    for i,obj in ipairs(array) do
        obj:update(dt)
    end
end

function arrayDraw(array)
    for i,obj in ipairs(array) do
        -- Check if it is list
        if (#obj > 0) then
            for j,quad in ipairs(obj) do
                quad:draw()
            end
        else
            obj:draw()
        end
    end
end

-- Sound playing functions
function setupSound()
    back_music:setVolume(0.3)
end

function playSound(sound)
    love.audio.stop(sound)
    love.audio.play(sound)
end

-- Values Check
function isEven(num)
    return num % 2 == 0
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

function centerLines()
    love.graphics.rectangle("fill", 0, WINDOW_HEIGHT_CENTER, WINDOW_WIDTH, 1)
    love.graphics.rectangle("fill", WINDOW_WIDTH_CENTER, 0, 1, WINDOW_HEIGHT)
end

-- LOAD FUNCTIONS --
function loadPictures()
    player_pic = love.graphics.newImage("pictures/player.png")
    projectile_pic = love.graphics.newImage("pictures/projectile.png")
    enemies_pic = love.graphics.newImage("pictures/enemies.png")
    e_projectile_pic = love.graphics.newImage("pictures/e_projectile.png")
end

function loadSounds()
    back_music = love.audio.newSource("sounds/game.mp3", "stream")
    projectile_sound = love.audio.newSource("sounds/projectile.mp3", "static")
    e_projectile_sound = love.audio.newSource("sounds/e_projectile.mp3", "static")
end