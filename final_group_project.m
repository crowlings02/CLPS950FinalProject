%Here screen is opened just for changing the SyncTest preferences
Screen('Preference', 'VBLTimestampingMode', -1);
Screen('Preferences', 'SkipSyncTests', 1); %forgo syncTests

%% Start Game

 % open a display window               
screens=Screen('Screens');
screenNumber=max(screens);
[window, wRect]=Screen('OpenWindow',screenNumber,0,[0,0,600,500],32,2);
Screen(window,'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); 
[xc,yc] = RectCenter(wRect);%center of screen location in pixels

black=BlackIndex(screenNumber); % define black color
white = WhiteIndex(screenNumber); % define white color
Screen('TextSize', window, 20); % set text font size

% Check for key press
ListenChar(2);	%block keyboard output to Command window
     % pause does not work but this seems to
     keywait = 33;      %start in some neutral state
     while (keywait ==33) 
         keywait = GetChar;
         if  isnan(keywait), keywait = 33;end
     end
ListenChar(1);

%KbStrokeWait;

% start screen text
Screen(window,'TextSize',25); % set font size
Screen ('FillRect',window,uint8(white)); % make entire screen white
DrawFormattedText(window, 'MINESWEEPER', 'center', yc - 30, black);
DrawFormattedText(window, 'Press any key to start', 'center', yc + 30, black);
Screen('Flip', window);  

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

%initialize size of the grid
numRows = 16;
numCols = 24;

% Squares without bombs
numCleared = 0;
numBombs = 40;
totalToClear = numRows * numCols - numBombs;

%bombs
bombGrid = zeros(numRows, numCols);
randSample = randperm(numRows * numCols, numBombs);

exploded = 0;

for i=randSample
    bombGrid(idivide(int32(i) - 1, int32(numCols)) + 1, mod(i - 1, numCols) + 1) = 1;
end

stateGrid = zeros(numRows, numCols);

[adjacentBombGrid] = GetAdjacentBombs(numRows,numCols, bombGrid);



% Flip to the screen. 
Screen('Flip', window);

% constanlty check frames
while 1
    % background of game screen
    Screen('FillRect', window, [80, 80, 80], [0, 0, 600, 500]);
    Screen(window,'TextSize',25);
    DrawFormattedText(window, 'MINESWEEPER', 'center', 30, black);

    Screen(window,'TextSize',18);
    DrawFormattedText(window, strcat('Cleared:', num2str(numCleared), '/', num2str(totalToClear)), 20, 70, black);

    Screen('FillRect', window, [255, 0, 0], [500, 30, 570, 70]);
    Screen(window,'TextSize',25);
    DrawFormattedText(window, 'Quit', 511, 58, black);

    % generate the visual grid
    for r=1:numRows
        for c=1:numCols
            % calculate x and y of each square
            left = (c - 1) * 25;
            top = (r - 1) * 25 + 100;
            
            squareColor = [160, 160, 160];

            % clicked square
            if stateGrid(r, c) ~= 0
                squareColor = [110, 110, 110];
            end

            % create rectangle of square in grid
            rect = [left + 1, top + 1, left + 24, top + 24];
            
            Screen('FillRect', window, squareColor, rect);

            % bomb and clicked
            if stateGrid(r, c) == -1
                Screen('FillOval', window, [0, 0, 0], [left + 5, top + 5, left + 20, top + 20]);
            end

            % clicked square
            if stateGrid(r, c) == 1
                % show number of bombs adjacent to clicked square
                if adjacentBombGrid(r, c) > 0
                    Screen(window,'TextSize',18);
                    DrawFormattedText(window, num2str(adjacentBombGrid(r, c)), left + 7, top + 18, black);
                end
            end
        end
    end

    Screen('Flip', window);
    
    %check for game end
    if exploded
        break;
    end

    [clicks, x, y, clickSecs] = GetClicks(window);
    
    % Click function for quit button
    if x >= 500 && x <= 570 && y >= 30 && y <= 70
         sca;
    end
    
    % Calculate row and column of square clicked
        rowClick = idivide(int32(y - 100), 25) + 1;
        colClick = idivide(int32(x), 25) + 1;
    
    % Check if click is in grid 
    if rowClick >= 1 && rowClick <= numRows && colClick >= 1 && colClick <= numCols
        % check for bombs
        if bombGrid(rowClick, colClick)
            % set square to exploded
            stateGrid(rowClick, colClick) = -1;
            exploded = 1;
        else
            % set to clicked and add it as a cleared square
            stateGrid(rowClick, colClick) = 1;
            numCleared = numCleared + 1;
            
            % check for adjacent blanks (rename to adjacent bombs grid)
            if adjacentBombGrid(rowClick, colClick) == 0
                [adjacentBombGrid, stateGrid, numCleared] = FillBlanks(rowClick, colClick, adjacentBombGrid, stateGrid, numRows, numCols, numCleared);
            end
        end
    end
end

if exploded
    Screen(window,'TextSize',20); % set font size
    Screen ('FillRect',window,uint8(white)); % make entire screen white
    Screen('DrawText', window, 'game over', xc/2, yc/2, black);
    
    Screen('Flip', window);
    %wait for a keyboard button press to terminate.
    KbStrokeWait;
end

% Clear the screen. 
sca;
