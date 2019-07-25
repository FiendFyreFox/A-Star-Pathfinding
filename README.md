# A-Star-Pathfinding
A simple A* implementation in Processing 3.5.3 which generates a random maze of a customizable size then solves it. 


# Directions:

Open the astart-priorityqueue file, then change the values at the top of the file to your liking.
cols/rows: the number of columns / rows in the maze, these can be different, but it will cause problems.
GridSize: the density / size of each node displayed in the window. it should be (1/cols) * window size X
startX/startY: the coordinates of the starting node. After running the program, you can change these by clicking on a node while holding 's'
endX/endY: the coordinates of the end node. After running the program, you can change these by clicking on a node while holding 'e'
canMoveDiag: This controls whether the AI will consider diagonal moves as it pathfinds. If false this can lead to multiple paths being the same length.
WallWeight: the ratio of walls to walkable nodes. if this is 0 the rato wil be 1:1, if it is 1 there will be no walls. if it is -1 there will be a 3:1 ratio.

# Additional notes:

Clicking on a node will turn it into a wall. Shift clicking will remove a wall. In either case the algorithm will run again.
