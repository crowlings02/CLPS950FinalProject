# CLPS950FinalProject

Product: 
We recreated the minesweeper game in Matlab. 
Players can play a simplified but comprehensive version of Minsweeper.

Language, packages required:
Matlab, Psych-toolbox

How to Run/Play:
Players run the final_group_project file, and simply use key presses to 
start the game, and clicks to play minesweeper as it is traditionally played.
The goal is to clear the grid without hitting any bombs. 

Warning: (Especially if running this on a Mac), PyschToolBox may cause 
problems and be very slow. Be patient with key presses and clicks!

Project Timeline:

Week 1 (04/27 - 05/1) 
After submitting our proposal, we worked on figuring out how to approach 
the problem and dividing the project into subparts so that we could see how 
to best split the coding. After doing so, we began looking into PsychToolBox 
documentation as well as online resources to figure out how to get the 
clicking functionality working. Alexis worked on this, while Caitlin 
approached how to get different Screens showing and responding to key 
presses to switch between them.

Week 2: (5/2-5/8)
In week two, Alexis further developed code on how to make a single square 
flip in response to a click while Caitlin worked on the visual end of 
having squares show. Both teammates worked on figuring out how to connect 
the visual grid to the logical grid, and we faced issues in doing so. 
We had code that generated bombs and the numbers of adjacnet bombs, but it 
looped through the grid too many times and was inefficient. 
We also faced issues with PsychToolBox, and because Alexis got Covid, 
the end of Week 2 and Week 3 was hindered by being unable to work in 
person, although we worked together on zoom and separately the best we 
could. However, this led to future problems in integrating our code 
with slight logical differences.

Week 3:(5/9-5/16)
This week, we had to completely change the logic and structure of our code. 
Due to working separately, we had run into problems integrating. 
We realized how we could more efficiently connect the grid with the logic, 
and so restructured a lot of code. However, we initially had them all in 
separate functions but ran into issues with bugs from the different 
functions incorrectly communicating with each other. Because of this, 
we made the decision to simplify and collapse the code into only two files 
to minimize error and make variables more accessible. From here, 
we were able to complete the project in the second end of the week, 
completing the visuals, writing the recursive fill in blanks function, 
and modifying the bomb and adjacent bomb number generation. 
We were unable to add a timer or flagging, but instead displayed the 
number of squares cleared so players could still have a sense of progress. 


