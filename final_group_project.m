%Here screen is opened just for changing the SyncTest preferences
Screen('Preference', 'VBLTimestampingMode', -1);
Screen('Preferences', 'SkipSyncTests', 1); %forgo syncTests

%% Start Game - Intro screens coded by Caitlin, assisted by Alexis 

 % open a display window               
screens=Screen('Screens');
screenNumber=max(screens);
[window, wRect]=Screen('OpenWindow',screenNumber,0,[0,0,600,500],32,2);
Screen(window,'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); 
[xc,yc] = RectCenter(wRect);%center of screen location in pixels

black=BlackIndex(screenNumber); % define black color
white = WhiteIndex(screenNumber); % define white color
Screen('TextSize', window, 20); % set text font size
   
% Check for key press (KbStrokeWait not working initially)
ListenChar(2);	%block keyboard output to Command window
     keywait = 33;      %start in some neutral state
     while (keywait ==33) 
         keywait = GetChar;
         if  isnan(keywait), keywait = 33;end
     end
ListenChar(1);


% Start screen text
Screen(window,'TextSize',25); % set font size
Screen ('FillRect',window,uint8(white)); % make entire screen white
DrawFormattedText(window, 'MINESWEEPER', 'center', yc - 30, black);
DrawFormattedText(window, 'Press any key to start', 'center', yc + 30, black);
Screen('Flip', window);  

%wait for key to move on
KbStrokeWait;

% Instructions page
Screen(window,'TextSize',20); % set font size
Screen ('FillRect',window,uint8(white)); % make entire screen white
DrawFormattedText(window, 'Instructions', 'center', yc - 30, black);
DrawFormattedText(window, 'Click squares and clear the grid. If you hit a bomb, you lose.', 'center', yc, black);
DrawFormattedText(window, 'The numbers on the board represent', 'center', yc+30, black);
DrawFormattedText(window, 'how many bombs are adjacent to a square.','center', yc+60, black);
DrawFormattedText(window, 'Press any key to play', 'center', yc + 120, black);
Screen('Flip', window);  

% Check for key press
KbStrokeWait;    

%% Game Screen - Coded by both Alexis and Caitlin
Screen(window,'TextSize',20); % set font size
Screen ('FillRect',window,uint8(white)); % make entire screen white

%initialize size of the grid
numRows = 16;
numCols = 24;

%initialize bombs and cleared squares
numBombs = 40;
numCleared = 0;

% Initialize number of squares without bombs
totalToClear = numRows * numCols - numBombs;

% Initialize grid that stores the state of each square: has it been clicked
% or blown up (not clicked: 0, clicked: 1, bomb: -1)
stateGrid = zeros(numRows, numCols); %set default state to 0, not clicked

%% Bombs - Base Logic by Alexis (Caitlin contributed to attributing bombs to row and columns), Debugged by both 

% Initialize grid that stores if it is a bomb (1) or not (0)
bombGrid = zeros(numRows, numCols);
% Randomly sample square numbers for bomb
randSample = randperm(numRows * numCols, numBombs);
% initialize if any bombs have blown up at false initially
exploded = 0;

% Match bomb number to row and column of bomb grid to fill it in
for i=randSample
    bombGrid(idivide(int32(i) - 1, int32(numCols)) + 1, mod(i - 1, numCols) + 1) = 1;
end

%% Number of Adjacent Bombs - Coded by Alexis (Debugged & help from Caitlin)

% stores # of adjacent bombs for every square
adjacentBombGrid = zeros(numRows, numCols);

% loops through entire grid
for r=1:numRows
    for c=1:numCols
        % for each square, loop through 9 adjacent squares (including self)
        for ra=max(r - 1, 1):min(r + 1, numRows)
            for ca=max(c - 1, 1):min(c + 1, numCols)
                % fill adjacent bomb grid with corresponding bomb numbers 
                adjacentBombGrid(r, c) = adjacentBombGrid(r, c) + bombGrid(ra, ca);
            end
        end
    end
end

%% Visual Grid & Updates - Visuals coded by Caitlin (assisted by Alexis)

% constant loop to run game logic and update screen for each frame
while 1
    % background of game screen
    Screen('FillRect', window, [80, 80, 80], [0, 0, 600, 500]);
    Screen(window,'TextSize',25);
    DrawFormattedText(window, 'MINESWEEPER', 'center', 30, black);

    Screen(window,'TextSize',18);
    DrawFormattedText(window, strcat('Cleared:', num2str(numCleared), '/', num2str(totalToClear)), 20, 70, black);

    % Quit button
    Screen('FillRect', window, [255, 0, 0], [500, 30, 570, 70]);
    Screen(window,'TextSize',25);
    DrawFormattedText(window, 'Quit', 511, 58, black);

    % generate the visual grid - loop through grid
    for r=1:numRows
        for c=1:numCols
            % calculate x and y of each square (and set default color)
            left = (c - 1) * 25;
            top = (r - 1) * 25 + 100;
            
            squareColor = [160, 160, 160];

            % check states of squares

            % set color of clicked (including bomb) squares
            if stateGrid(r, c) ~= 0
                squareColor = [110, 110, 110]; %set clicked and bomb square color
            end

            % create rectangle of standard square in grid
            rect = [left + 1, top + 1, left + 24, top + 24];
            
            Screen('FillRect', window, squareColor, rect);

            % draw bomb for clicked squares with bombs
            if stateGrid(r, c) == -1
                Screen('FillOval', window, [0, 0, 0], [left + 5, top + 5, left + 20, top + 20]); %draw bomb
            end

            % Display number of adjacent bombs if clicked
            if stateGrid(r, c) == 1
                % show number if it is not blank
                if adjacentBombGrid(r, c) > 0
                    Screen(window,'TextSize',18);
                    DrawFormattedText(window, num2str(adjacentBombGrid(r, c)), left + 7, top + 18, black);
                end
            end
        end
    end
  
    % Update Screen
    Screen('Flip', window);

    % check for game end if bomb has been clicked
    if exploded
        break;
    end
 

    %% clicking - Coded and debugged by both Caitlin & Alexis
    % Get number, coordinates, and timing of all clicks
    [clicks, x, y, clickSecs] = GetClicks(window);
    
    % Click function for quit button
    if x >= 500 && x <= 570 && y >= 30 && y <= 70
         break
    end
    
    % Calculate row and column of square clicked
    rowClick = idivide(int32(y - 100), 25) + 1;
    colClick = idivide(int32(x), 25) + 1;
    
    % Check if click is in grid 
    if rowClick >= 1 && rowClick <= numRows && colClick >= 1 && colClick <= numCols
        % check for bombs
        if bombGrid(rowClick, colClick)
            % set square state to bomb and exploded
            stateGrid(rowClick, colClick) = -1;
            exploded = 1;
        
        % if not a bomb...
        else
            % set to clicked and add it as a cleared square
            stateGrid(rowClick, colClick) = 1;
            numCleared = numCleared + 1;
            
            % check for adjacent blanks and call recursive function to
            % check for cascading blanks.
            if adjacentBombGrid(rowClick, colClick) == 0
                [adjacentBombGrid, stateGrid, numCleared] = FillBlanks(rowClick, colClick, adjacentBombGrid, stateGrid, numRows, numCols, numCleared);
            end
        end
    end
end

%% End game - visual screens and text coded by Caitlin
% Game End Screen 
if exploded
    WaitSecs(3);

    Screen('FillRect', window, [255, 0, 0], [0, 0, 600, 500]);
    Screen(window,'TextSize',25);
    DrawFormattedText(window, 'GAME OVER', 'center', yc, black);

    DrawFormattedText(window, 'Press any key to quit', 'center', yc + 30, black);

    Screen('Flip', window);
   
    KbStrokeWait;

% Game Win Screen
else
    WaitSecs(3);

    Screen('FillRect', window, uint8(white), [0, 0, 600, 500]);
    Screen(window,'TextSize',25);
    DrawFormattedText(window, 'YOU WON!!', 'center', yc, black);

    DrawFormattedText(window, 'Press any key to quit', 'center', yc - 30, black);

    Screen('Flip', window);
   
    KbStrokeWait;
end

% Clear the screen. 
sca;
