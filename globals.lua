--   Copyright (C) 2023 Alessandro Amatucci Girlanda
 
--   This file is part of Invaders in Space.
 
--   Invaders in Space is free software: you can redistribute it and/or modify
--   it under the terms of the GNU General Public License as published by
--   the Free Software Foundation, either version 3 of the License, or
--   (at your option) any later version.
 
--   Invaders in Space is distributed in the hope that it will be useful,
--   but WITHOUT ANY WARRANTY; without even the implied warranty of
--   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
--   GNU General Public License for more details.
 
--   You should have received a copy of the GNU General Public License
--   along with Invaders in Space. If not, see <https://www.gnu.org/licenses/>.


-- WINDOW --
DEFAULT_WIDTH,DEFAULT_HEIGHT = 800,600
WINDOW_WIDTH,WINDOW_HEIGHT = DEFAULT_WIDTH, DEFAULT_HEIGHT
WINDOW_WIDTH_CENTER = WINDOW_WIDTH / 2
WINDOW_HEIGHT_CENTER = WINDOW_HEIGHT / 2

-- STARS --
STAR_SPEED = -20
PLANETS_WIDTH = 20
PLANETS_HEIGHT = 20

-- PLAYER -- 
PLAYER_HEALTH = 3
PLAYER_HEALTH_X = 10
PLAYER_HEALTH_Y = 10
PLAYER_WIDTH = 40
PLAYER_HEIGHT = 40
PLAYER_SPEED = 400

-- PROJECTILES --
PROJECTILES_HEIGHT = PLAYER_HEIGHT / 2
PROJECTILES_WIDTH = PROJECTILES_HEIGHT / 2
PROJECTILES_SPEED = 300
PROJECTILES_MAX = 1
PROJECTILES_WAIT = 0.5
PROJECTILES_TUTORIAL_HEIGHT = 20

-- ENEMIES PROJECTILES (same size as player's)--
ENEMIES_PROJECTILES_SPEED = 80
ENEMIES_PROJECTILES_WAIT = 5
ENEMIES_PROJECTILES_DEC = 0.05

-- ENEMIES --
ENEMY_WIDTH = 30
ENEMY_HEIGHT = 30
ENEMY_SPEED = 50
ENEMIES_COLS = 11
ENEMIES_ROWS = 5
ENEMIES_GAP = 20
ENEMIES_SPEED_INC = 0.5