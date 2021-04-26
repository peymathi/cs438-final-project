# CSCI 438 Final Project

## General Summary

This is the final project for the CSCI 438 Advanced Game Development course. The project was made using the Godot Game Engine as well as Blender for 3D Modeling. The game is meant to be an aim training tool for competitive first person shooters similar to CS:GO and Valorant.

## Gameplay

## Controls

The game supports both mouse and keyboard controls as well as gamepad input controls. 

The control scheme for mouse and keyboard is as follows:

- WASD : Move
- Mouse : Look
- Left Click : Shoot
- Shift : Sprint
- Ctrl or C : Crouch
- Esc : Open Menu

The control scheme for gamepad input is as follows:

- Left Analog : Move
- Right Analog : Look
- Right Trigger : Shoot
- Left Analog Press : Sprint
- Right Analog Press : Crouch
- Start : Open Menu

## Movement

The movement of the game was largely inspired by Valorant's movement with the added feature of sprinting. I spent a lot of time working on the movement to make it as crisp and controlled as possible. Components such as having the same max speed in all 360 directions regardless of input, having a max vertical camera angle, and realistic looking sprinting with FOV change took a lot of time to implement. There was one feature that I wanted to implement, but with time I decided to move on to other aspects of the game besides movement. This feature is the restriction of sprinting to only forwards. It is a little bit weird to be able to sprint backwards and sideways, but I'm willing to live with it and maybe I'll go back and add this feature to the movement later.

## Shooting Mechanics

The game's shooting mechanics are based on RayCasting. This means that the camera is holding an invisible laser pointer that aims forward through the crosshairs and anytime a shot is registered the laser pointer will report the coordinates of the nearest collision with the laser pointer. This means that bullets have no travel time and bullet collisions are not computationally expensive. This is the same way that many popular first person shooters do it.

The gun's firerate can be set to different values. Every bullet after the first in a given amount of time will cause a progressive amount of error in the raycast. This is to simulate recoil error. Moving and shooting will also add error.

## Models, Textures, and HDRI

Most of these resources were found on Model/Texture/HDRI Haven and CGTrader for free. The hand model came from CGTrader as a blender project which I opened up and modified using an armature to curl the hand to the way I wanted. In hindsight, working with someone else's model in blender took so long I could have probably just made the hand myself. The gun model was a great find because it probably would have taken me a week to make a model and texture that looked that good. 
