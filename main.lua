function love.load()
    -- Get desktop/window dimensions
    -- window_width,window_height = love.window.getDesktopDimensions()
    window_width,window_height = 800, 600
    window_width_center = window_width / 2
    window_height_center = window_height / 2

    -- Include files
    Object = require("classic/classic")
    require("entity")
    require("player")
    require("projectile")
    
    -- Create Objects/Entities
    player = Player(window_width_center, window_height - 100)

    -- Create projectiles
    projectiles_max = 2
    projectiles_wait = 0.5
    projectiles_timer = projectiles_wait
    projectiles = {}
end

function love.update(dt)
    player:update(dt)

    -- Shoot no more than the maximum number of projectiles every "projectiles_wait" seconds
    if projectiles_timer < projectiles_max then
        projectiles_timer = projectiles_timer + dt
    end

    if love.keyboard.isDown("space") and #projectiles < projectiles_max and projectiles_timer >= projectiles_wait then
        projectiles_timer = projectiles_timer - projectiles_wait
        projectile = Projectile(player.x, player.y)
        table.insert(projectiles, projectile)
    end

    for i,v in ipairs(projectiles) do
        v:update(dt)
    end

    -- Clear projectiles (avoiding memory leaks)
    for i=#projectiles,1,-1 do
        if projectiles[i].y + projectiles[i].height <= 0 then
            table.remove(projectiles, i)
        end
    end
end

function love.draw()
    player:draw()

    for i,v in ipairs(projectiles) do
        v:draw()
    end
end

-- Temporary close window
function love.keypressed(key)
    if key == "q" then
        love.event.quit()
    end
end