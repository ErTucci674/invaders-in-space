`--- WORK IN PROGRESS ---`

# ![logo](readmefs/icon.png) Invaders in Space - 2D Game
## About the Project
The game _Invaders in Space_ is inspired by the classic arcade game _Space Invaders_. It follows the same mechanics with small variations.

_Aliens are approaching Earth with anything but peaceful intentions. It's the player's job to stop them before it's too late._

## Game Dynamics 
The aliens are in a regular 12x6 rectangular formation made of 3 different types of aliens: **Green**, **Yellow**, **Red**. Starting from the left, each individual has 1, 2, 3 health bars.

The aliens travel as a single unit from one side to the other at a constant speed. Whenever they reach a side of the window they descend by an "Alien's Height" and change direction.

The player takes control of a spaceship that can be moved only on an x-axis at the bottom of the window. Projectiles can be shot to lower the health status of the aliens and, potentially, destroy their ships.

As the aliens get shot, their health status changes, hence their colour to the equivalent health bars number (Red->Yellow->Green).

The aliens shoot at a random pace between 1 and 3 seconds. Every time the player is hit, one health bar is lost. If the player loses the last bar, the game ends in a defeat. The same result is obtained if the one of the aliens collides with the player's spaceship, **no matter the number of health bars**.

For every destroyed alien's spaceship, the remaining ones increase their movement speed and the shooting rate. _No one can tolerate the death of a comrade, after all_.

Victory is accomplished by eliminating all the aliens before they kill the player.

## Built with
+ Lua (v5.4.2)
+ LÖVE (Framework - v11.4)

## Getting started
```
git clone https://github.com/ErTucci674/invaders-in-space.git
```

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

## Files and Code
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

As an external source is used for the object's graphics, the entity's size depends on the picture that has been implemented. Hence, in the _Constructor Function_, `Entity:new`, the sprite's measurements are taken. The `self.quads` parameter is employed by entities that utilize only a specific section (quad) of the picture, and this section is populated using the subsequent class method:

```lua
function Entity:setQuads()
    for i=0,math.floor(self.image_width / self.width) - 1 do
        local quad = love.graphics.newQuad((i)*(self.width + 1), 0, self.width, self.height, self.image_width, self.image_height)
        table.insert(self.quads, quad)
    end
end
```

### Pages
The game contains multiple "pages" including: menu, tutorial, game and gameover page. Each page is assigned as a unique _Object_ class which contains all the parameters and methods needed when the player is in that specific page.

e.g. The player opens the game for the first time and the menu page is illustrated. On the current page, buttons to start the game, move to the tutorial page or quit the game are shown. If the player clicks the start button, the game begins, a background music starts playing and new illustrations are shown: the spaceship, aliens and their animations.

## Reference links
**Classes Library (classic)**: https://github.com/rxi/classic

**Title Font**: https://www.font-generator.com/fonts/ 

**Graphics/Pixel Art**: https://www.piskelapp.com/

**Sound Effects**: https://www.soundfishing.eu/sound/, https://pixabay.com/, https://www.freesoundeffects.com/free-sounds/, https://www.youtube.com/watch?v=rr5CMS2GtCY, https://www.youtube.com/watch?v=bug1b0fQS8Y

## Aknowledgements
Harvard University Online Course (edx50) - https://www.edx.org/learn/computer-science/harvard-university-cs50-s-introduction-to-computer-science