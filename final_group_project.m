%Here screen is opened just for changing the SyncTest preferences
Screen('Preference', 'VBLTimestampingMode', -1);
Screen('Preferences', 'SkipSyncTests', 1); %forgo syncTests

%% Start Game

% open a display window               
screens=Screen('Screens');
screenNumber=max(screens);
[window, wRect]=Screen('OpenWindow',screenNumber,0,[0,0,600,400],32,2);
Screen(window,'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); 
[xc,yc] = RectCenter(wRect);%center of screen location in pixels

black=BlackIndex(screenNumber); % define black color
white = WhiteIndex(screenNumber); % define white color
Screen('TextSize', window, 20); % set text font size

% Check for key press
KbStrokeWait;

% start screen text
Screen(window,'TextSize',20); % set font size
Screen ('FillRect',window,uint8(white)); % make entire screen white
Screen('DrawText', window, 'MINESWEEPER', xc/2, yc/2, black);
Screen('DrawText', window, 'Press any key to start', xc/2, yc/2 + 50, black);
Screen('Flip', window); 

% Check for key press
KbStrokeWait;

% Display instructions page
Screen(window,'TextSize',20); % set font size
Screen ('FillRect',window,uint8(white)); % make entire screen white
Screen('DrawText', window, 'game instructions', xc/2, yc/2, black);
Screen('DrawText', window, 'Press any key to play', xc/2, yc/2 + 50, black);
Screen('Flip', window);  

% Check for key press
KbStrokeWait;    

%% Game Screen
Screen(window,'TextSize',20); % set font size
Screen ('FillRect',window,uint8(white)); % make entire screen white
Screen('DrawText', window, 'game screen', xc/2, yc/2, black);
  

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(wRect);
% Make a base Rect of 200 by 200 pixels. This is the rect which defines the
% size of our square in pixels. Rects are rectangles, so the
% sides do not have to be the same length. The coordinates define the top
% left and bottom right coordinates of our rect [top-left-x top-left-y
% bottom-right-x bottom-right-y]. The easiest thing to do is set the first
% two coordinates to 0, then the last two numbers define the length of the
% rect in X and Y. The next line of code then centers the rect on a
% particular location of the screen.
baseRect = [0 0 200 200];

% Center the rectangle on the centre of the screen using fractional pixel
% values.
% For help see: CenterRectOnPointd
centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);

% Set the color of our square to full red. Color is defined by red green
% and blue components (RGB). So we have three numbers which
% define our RGB values. The maximum number for each is 1 and the minimum
% 0. So, "full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0
% 1]. Play around with these numbers and see the result.
rectColor = [1 0 0];

% Draw the square to the screen. For information on the command used in
% this line see Screen FillRect?
Screen('FillRect', window, rectColor, centeredRect);
   
% Flip to the screen. This command basically draws all of our previous
% commands onto the screen. See later demos in the animation section on more
% timing details. And how to demos in this section on how to draw multiple
% rects at once.
% For help see: Screen Flip?
Screen('Flip', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo.
% For help see: help KbStrokeWait
KbStrokeWait;

% Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% all features related to PTB. Note: we leave the variables in the
% workspace so you can have a look at them if you want.
% For help see: help sca
sca;
