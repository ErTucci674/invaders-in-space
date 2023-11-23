function love.load()
    -- Set Game Icon
    local icon = love.image.newImageData("pictures/icon.png")
    love.window.setIcon(icon)

    -- Include files
    require("globals")

    Object = require("classic/classic")
    require("text")
    require("entity")
    require("background")
    require("menu")
    require("game")
    require("player")
    require("projectile")
    require("enemy")
    require("explosion")
    require("tutorial")
    require("button")
    require("gameover")
    
    -- Load External Media
    loadPictures()
    loadSounds()

    math.randomseed(os.time())

    -- Setup the different pages
    background = Background()
    menu = Menu()
    game = Game()
    tutorial = Tutorial()
    gameover = Gameover()

    current_page = "Menu"
    current_music = back_music

    love.audio.setVolume(0.5)
end

function love.update(dt)
    if (current_page == "Menu") then
        menu:update(dt)
    elseif (current_page == "Start") then
        background:update(dt)
        game:update(dt)
    elseif (current_page == "Tutorial") then
        tutorial:update(dt)
    elseif (current_page == "Game Over") then
        gameover:update(dt)
    elseif (current_page == "Quit") then
        love.event.quit()
    end
end

function love.draw()
    if (current_page == "Menu") then
        background:draw()
        background:titleDraw()
        menu:draw()
    elseif (current_page == "Start") then
        background:draw()
        game:draw()
    elseif (current_page == "Tutorial") then
        tutorial:draw()
    elseif (current_page == "Game Over") then
        love.audio.stop(back_music)
        gameover:draw()
    end
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

-- Window control keys
function love.keypressed(key)
    -- Back to menu
    if key == "escape" then
        current_page = "Menu"
        love.audio.pause(back_music)
    -- Close the game
    elseif key == "q" then
        love.event.quit()
    -- Reset game
    elseif key == "r" then
        love.event.quit('restart')
    end
end

-- LOAD FUNCTIONS --
function loadPictures()
    title_pic = love.graphics.newImage("pictures/title.png")
    player_pic = love.graphics.newImage("pictures/player.png")
    projectile_pic = love.graphics.newImage("pictures/projectile.png")
    enemies_pic = love.graphics.newImage("pictures/enemies.png")
    e_projectile_pic = love.graphics.newImage("pictures/e_projectile.png")
    explosion_pic = love.graphics.newImage("pictures/explosion.png")
    win_pic = love.graphics.newImage("pictures/win.png")
    lose_pic = love.graphics.newImage("pictures/lose.png")
end

function loadSounds()
    back_music = love.audio.newSource("sounds/game.mp3", "stream")
    projectile_sound = love.audio.newSource("sounds/projectile.mp3", "static")
    e_projectile_sound = love.audio.newSource("sounds/e_projectile.mp3", "static")
    player_hit_sound = love.audio.newSource("sounds/player_hit.mp3", "static")
    explosion_sound = love.audio.newSource("sounds/explosion.mp3", "static")
    win_sound = love.audio.newSource("sounds/win.mp3", "static")
    lose_sound = love.audio.newSource("sounds/lose.mp3", "static")
end

-- RESET GAME --
function reset()
    background = Background()
    game = Game()
    gameover = Gameover()
end