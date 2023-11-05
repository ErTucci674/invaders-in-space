-- WINDOW --
-- window_width,window_height = love.window.getDesktopDimensions()
WINDOW_WIDTH,WINDOW_HEIGHT = 800, 600
WINDOW_WIDTH_CENTER = WINDOW_WIDTH / 2
WINDOW_HEIGHT_CENTER = WINDOW_HEIGHT / 2

-- PLAYER --
PLAYER_WIDTH = 25
PLAYER_HEIGHT = 25
PLAYER_SPEED = 400

-- PROJECTILES --
PROJECTILES_HEIGHT = PLAYER_HEIGHT / 2
PROJECTILES_WIDTH = PROJECTILES_HEIGHT / 2
PROJECTILES_SPEED = 800
PROJECTILES_MAX = 2
PROJECTILES_WAIT = 1

-- ENEMIES PROJECTILES (same size as player's)--
ENEMIES_PROJECTILES_SPEED = 80
ENEMIES_PROJECTILES_WAIT = 5

-- ENEMIES --
ENEMY_WIDTH = 25
ENEMY_HEIGHT = 25
ENEMY_SPEED = 50
ENEMIES_COLS = 11
ENEMIES_ROWS = 5
ENEMIES_GAP = 20