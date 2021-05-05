# CSCI 438 Final Project

## General Summary

This is the final project for the CSCI 438 Advanced Game Development course. The project was made using the Godot Game Engine as well as Blender for 3D Modeling. The game is meant to be an aim training tool for competitive first person shooters similar to CS:GO and Valorant.

## Installation

The executables for the game are too large to store on github, instead here are links to executables for all the main operating systems:

- [Windows](https://drive.google.com/file/d/1SYeZhQCkGy4KUKJX6YrzTJkvQnI52XIt/view?usp=sharing)
- [Mac](https://drive.google.com/file/d/1oRpSWF2LL81OuqsdiAe5xmGdPDlTcLbE/view?usp=sharing)
- [Linux](https://drive.google.com/file/d/18g1IR6ughanVchPzaxSqAjhDBSaRr5ih/view?usp=sharing)

**Note**: Your graphics card must support OpenGL ES 3.0

## Gameplay

The gameplay of the game put plainly is firing a rifle at surfaces to create bullet holes. There are several surfaces to shoot at with a sort of shooting range window area to shoot out of. It is fun to fire with infinite ammo at surfaces and then run over to them to look at the bullet holes. Overall the gameplay options are short, but this project was not meant to be a fully fleshed out game. Rather, this project is meant to be a framework for any first person game that will rely on Ray Casting bullet collisions. 

## Controls

The game supports both mouse and keyboard controls as well as gamepad input controls. 

The control scheme for mouse and keyboard is as follows:

- WASD : Move
- Mouse : Look
- Left Click : Shoot
- Shift : Sprint
- Ctrl or C : Crouch
- Esc : Quit

The control scheme for gamepad input is as follows:

- Left Analog : Move
- Right Analog : Look
- Right Trigger : Shoot
- Left Analog Press : Sprint
- Right Analog Press : Crouch
- Start : Quit

## Movement

The movement of the game was largely inspired by Valorant's movement with the added feature of sprinting. I spent a lot of time working on the movement to make it as crisp and controlled as possible. Components such as having the same max speed in all 360 directions regardless of input, having a max vertical camera angle, and realistic sprinting appearance with FOV change took a lot of time to implement. There was one feature that I wanted to implement, but with time limites I decided to move on to other aspects of the game besides movement. This feature is the restriction of sprinting to only forwards. It is a little bit weird to be able to sprint backwards and sideways, but I'm willing to live with it and maybe I'll go back and add this feature to the movement later.

## Shooting Mechanics

The game's shooting mechanics are based on Ray Casting. This means that the camera is holding an invisible laser pointer that aims forward through the crosshairs and anytime a shot is registered the laser pointer will report the coordinates of the nearest collision with the laser pointer. This means that bullets have no travel time and bullet collisions are not computationally expensive. This is the same way that many popular first person shooters do it.

When a bullet is fired and collides with a valid PhysicsBody, a bullet hole will be placed at the collision point. The way this works is that a 3D sprite image is placed at the point facing in the normal direction of the plane collided with. The bullet hole is lazily animated to look like a bullet goes through it by having two states: the first state is the bullet hole with a white center instead of black with a spotlight shining on the entire image, the second state is the static bullet hole image with a black center and no lighting or changes. When the bullet is fired, the bullet mark will be created in the first state for a fraction of a second and then transition to the second state. When played very fast (as fast as bullets!) this looks like a bullet piercing a surface.

One feature that I really wanted to implement but did not have time to work on is shooting inaccuracy. I wanted to make it so that there would be slight inaccuracies added to the raycast whenever recoiling, moving, and sprinting. Crouching would have lowered these inaccuracies. This would have made the simulation much more realistic.

## Models, Textures, and HDRI

Most of these resources were found on Model/Texture/HDRI Haven and CGTrader for free. The hand model came from CGTrader as a blender project which I opened up and modified using an armature to curl the hand to the way I wanted. In hindsight, working with someone else's model in blender took so long I could have probably just made the hand myself. The gun model was a great find because it probably would have taken me a week to make a model and texture that looked that good and I basically plugged it straight into Godot and it worked flawlessly.

A LOT of time on this project was speant learning to work with textures. I now feel pretty confident in using the SpatialMaterial resource in Godot and I have learned a lot about different texture maps including Albedo / Diffuse, Ambient Occlusion, Metallic / Specular, Roughness, Normal / Bump, and Depth maps. 

One thing that I would LOVE to spend more time looking at is the HDRI Panorama and the environment parameters in general. I really didn't understand how the HDRI image affected the lighting and shading of my textures in the scene, so a lot of the HDRI images that I thought looked cool were unusable because their lighting made my textures look bad. The HDRI used in the final product is not the background that I wanted to use, but it provided the best lighting using the default environment parameters so I went with it. 
