# ![logo](readmefs/icon.png) Invaders in Space - 2D Game
## About the Project
The game _Invaders in Space_ is inspired by the classic arcade game _Space Invaders_. It follows the same mechanics with small variations.

_Aliens are approaching Earth with anything but peaceful intentions. It's the player's job to stop them before it's too late._

## Dynamics 
The aliens are in a regular 12x6 rectangular formation made of 3 different types of aliens: **Green**, **Yellow**, **Red**. Starting from the left, each individual has 1, 2, 3 health bars.

The aliens travel as a single unit from one side to the other at a constant speed. Whenever they reach a side of the window they descend by an "Alien's Height" and change direction.

The player takes control of a spaceship that can be moved only on an x-axis at the bottom of the window. Projectiles can be shot to lower the health status of the aliens and, potentially, destroy their ships.

As the aliens get shot, their health status changes, hence their colour to the equivalent health bars number (Red->Yellow->Green).

The aliens shoot at a random pace between 1 and 3 seconds. Every time the player is hit, one health bar is lost. If the player loses the last bar, the game ends in a defeat. The same result is obtained if the one of the aliens collides with the player's spaceship, **no matter the number of health bars**.

For every destroyed alien's spaceship, the remaining ones increase their movement speed and the shooting rate. _No one can tolerate the death of a comrade, after all_.

Victory is accomplished by eliminating all the aliens before they kill the player.

## Built with
+ Lua
+ LÖVE (Framework)

## Getting started
```
git clone https://github.com/ErTucci674/invaders-in-space.git
```

## How to execute

## Files

## Reference links
**Title Font**: https://www.font-generator.com/fonts/ 

**Graphics/Pixel Art**: https://www.piskelapp.com/

**Sound Effects**: https://www.soundfishing.eu/sound/, https://pixabay.com/, https://www.freesoundeffects.com/free-sounds/, https://www.youtube.com/watch?v=rr5CMS2GtCY, https://www.youtube.com/watch?v=bug1b0fQS8Y

## Aknowledgements
Harvard University Online Course (edx50) - https://www.edx.org/learn/computer-science/harvard-university-cs50-s-introduction-to-computer-science