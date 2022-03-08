### March 9

- added strikes in dark/day modes



### March 8

- reframed the behavior in the dark/day modes
- designed a new wall/edge mechanism



### March 7

Features and modifications:

- improved the mechanism to make the insect movements more life-like
- added instructions on the screen

Optimization: 

In the attempt to fix the lagging bug, I tried to apply other approaches to implement the fading trails, yet it does not resolve the issue of lagging - it appears that some other calculations occupy a high level of resources as well. So I decided to

- remove the trail functionality
- and limit the maximum amount of light sources.



### March 6

- added variation in insect properties (mass) represented by the gradient

- changed the Attractor's (now LightSource) *attract* function to *seek* (steer) function which makes more sense of the light source's effect



### March 3 - Objectives

After considering the integrity of the program, I determined the features to be implemented:

- [x] variation in insect properties represented by the gradient
- [x] day and night modes with two different sets of fireflies behavior
- [x] a different mechanism of the wall/edges
- [x] instructions on the screen



### Feb 27

Possible features for the midterm project:

- variation in insect properties represented by the gradient
- day and night modes with two different sets of fireflies behavior
- a variable flow field controlled by the keyboard


- fire that both attracts and kills the insects
