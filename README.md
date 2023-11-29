`--- WORK IN PROGRESS ---`

# ![logo](readmefs/icon.png) Invaders in Space - 2D Game
## About the Project
The game _Invaders in Space_ is inspired by the classic arcade game _Space Invaders_. It follows the same mechanics with small variations.

_Aliens are approaching Earth with anything but peaceful intentions. It's the player's job to stop them before it's too late._

## Game Dynamics 
The aliens are in a regular 12x6 rectangular formation made of 3 different types of aliens: **Green**, **Yellow**, **Red**. Starting from the left, each individual has 1, 2, 3 health bars.

The aliens travel as a single unit from one side to the other at a constant speed. Whenever they reach a side of the window they descend by an "Alien's Height" and change direction.

The player takes control of a spaceship that can be moved only on an x-axis at the bottom of the window. Projectiles can be shot to lower the health status of the aliens and, potentially, destroy their ships. _Important_: there can be just one player's projectile at the time on the screen.

As the aliens get shot, their health status changes, hence their colour to the equivalent health bars number (Red->Yellow->Green).

The aliens shoot at a random pace between 1 and 3 seconds. Every time the player is hit, one health bar is lost. If the player loses the last bar, the game ends in a defeat. The same result is obtained if the one of the aliens collides with the player's spaceship, **no matter the number of health bars**.

For every destroyed alien's spaceship, the remaining ones increase their movement speed and the shooting rate. _No one can tolerate the death of a comrade, after all_.

Victory is accomplished by eliminating all the aliens before they kill the player.

## Built with
+ Lua (v5.4.2)
+ LÖVE (Framework - v11.4)


## Start Playing (Windows only)
To play the game, download the zip folder
```
InvadersInSpace.zip
```
Extract the files into a new folder and open the `.exe` file and enjoy:
```
InvadersInSpace.exe
```

## Program and Execute Project
+ Programming language needed: `Lua (v5.4.2)`
+ Lua Framework needed: `LÖVE (v11.4)`

Clone directory on your device:
```
git clone https://github.com/ErTucci674/invaders-in-space.git
```

## Files and Code
### Configurations/Settings
The `conf.lua` file sets up all the main back-end configurations of the game applications. These include: window default size, LÖVE version, console visibility, audio control, input control (mouse, keyboard, joystick), etc. The function setup has been taken from the original [LÖVE](https://love2d.org/wiki/Config_Files) website and adjusted to suit game settings.

### Global Constants
Some _variables_ need to be shared between different files which can become confusing and tricky to find if declared in several ones of them. Hence, all of the constant shared _memories_ are declared and assigned in the file `globals.lua`. Lua does not include any _constant variable_ feature like the programming languages _C/C++_ have. Hence, to distinguish them from normal variables, all the constants have been declared in uppercase

### Class Library
For the flexibility and readability of the project, everything has been assigned to a class and managed through Object-Oriented Programming. In the project repository, the `classic` folder contains a library that simplifies the operation of classes:
```
path: classic/classic.lua
```

### Entity Class
The majority of the _entities_ in the game, such as the aliens, player, projectiles, require a _sprite/picture_ and a location within a set of _X-Y_ coordinates.

The file `entity.lua` is an _Object_ class that is shared among most of the entities for this exact reason.

```lua
Entity = Object:extend()

function Entity:new(image, x, y)
    self.health = 0

    self.quads = {}
    self.width = 0
    self.height = 0
    self.image = image
    self.image_width = self.image:getWidth()
    self.image_height = self.image:getHeight()

    self.x = x
    self.y = y

    self:setStart()
end
```

As an external source is used for the object's graphics, the entity's size depends on the picture that has been implemented. Hence, in the _Constructor Function_, `Entity:new`, the sprite's measurements are taken. The `self.quads` parameter is employed by entities that utilize only a specific section (quad) of the picture, or to combine them and form an animation.The array is populated using the following class method:

```lua
function Entity:setQuads()
    for i=0,math.floor(self.image_width / self.width) - 1 do
        local quad = love.graphics.newQuad((i)*(self.width + 1), 0, self.width, self.height, self.image_width, self.image_height)
        table.insert(self.quads, quad)
    end
end
```

### Entities
All the entities sub-classes are stored in the following files:

+ `player.lua`
+ `enemy.lua`
+ `projectile.lua`
+ `explosion.lua`
+ `star.lua`

Each of these takes the `entity` class their main one and then develops on top of it to add the features only that specific object has.

As the `button` and `text` objects required unique parameters, they are the only ones that do not inherit methods/parameter from another class.

### Pages
The game contains multiple "pages" including: menu, tutorial, game and gameover page. Each page is assigned as a unique _Object_ class which contains all the parameters and methods needed when the player is in that specific page.

_e.g. The player opens the game for the first time and the menu page is illustrated. On the current page, buttons to **start the game**, **change to the tutorial page** and **quit the game** are shown. If the player clicks the start button, the game begins, a background music starts playing and new illustrations are shown: the spaceship, aliens and their animations. If the tutorial button is clicked instead, different text and animations are shown_.

These pages are stored in different files:

+ `menu.lua`
+ `tutorial.lua`
+ `game.lua`
+ `gameover.lua`

### Main File
All pages are managed by the `main.lua` file. Here, all the other files included through the `require()` function.

```lua
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
```

The various pages are then stored in variables as objects so their properties can be accessed.

```lua
background = Background()
menu = Menu()
game = Game()
tutorial = Tutorial()
gameover = Gameover()
```

The page in which player is currently at is controlled by the `current_page` variable. The _LÖVE_ framework automatically manages the **loading**, **updating** and **drawing** of every page. Determined by the `current_page`'s value, the corresponding _page_ is updated and drawn in subsequent functions:

```lua
function love.load()
function love.update()
function love.draw()
```

### Background
The `game` and `menu` background graphics are uniquely _generated_ every time the game is loaded. The background is filled in black, planets and stars are then generated and moved upwards to create a _moving effect_.

Planets and stars are randomly generated based on the `rand` variable. The `generateStars` function gives a value to `rand` in between 1 and 100 every set amount of time determined by `self.star_timer_max`. Whenever the value is 80 or less, a star is produced; otherwise, a planet is generated. The main idea is to create a different animated background every time the game is played.

```lua
function Background:generateStars(dt)
    if (self.star_timer >= self.star_timer_max) then
        -- Create a random number and select whether generate a star or planet
        local rand = math.random(1,100)
        if (rand <= 80) then
            table.insert(self.stars, Star(star_pic, math.random(0, WINDOW_WIDTH), WINDOW_HEIGHT))
        else
            table.insert(self.planets, Star(planets_pic, math.random(0, WINDOW_WIDTH), WINDOW_HEIGHT + PLANETS_HEIGHT))
        end

        -- Reset timer and randomize a new max
        self.star_timer = 0
        self.star_timer_max = math.random(1, 2)
    else
        self.star_timer = self.star_timer + dt
    end
end
```

Whether a star or planet is generated, both of them are defined as star. However, when a new _star_ entity is declared, if the planets picture is inserted, then a planet is generated instead and a random _planet quad picture_ among the three is selected.

## Reference links
**LÖVE Website**: [LOVE2D](https://love2d.org/wiki/Main_Page)

**Classes Library (classic)**: [GitHub/rxi/classic](https://github.com/rxi/classic)

**Title Font**: [Font Generator](https://www.font-generator.com/fonts/ )

**Graphics/Pixel Art**: [Piskelapp](https://www.piskelapp.com/)

**Sound Effects**: [SOUNDFISHING](https://www.soundfishing.eu/sound/), [pixabay](https://pixabay.com/), [Free Sound Effects](https://www.freesoundeffects.com/), [Win Sound - Youtube](https://www.youtube.com/watch?v=rr5CMS2GtCY), [Lose Sound - Youtube](https://www.youtube.com/watch?v=bug1b0fQS8Y)

## Aknowledgements
Harvard University Online Course (edx50) - [Introduction to Computer Science](https://www.edx.org/learn/computer-science/harvard-university-cs50-s-introduction-to-computer-science)