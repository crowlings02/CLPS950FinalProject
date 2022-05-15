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
Screen('DrawText', window, 'game screen', xc/2, yc/2, black);
  


[numCleared, totalToClear,exploded, bombGrid] = GenerateBombs();
[adjacentGrid] = GetAdjacentBombs();


% Flip to the screen. 
Screen('Flip', window);

% constanlty check frames
while 1
    [totalToClear,stateGrid] = GenerateVisualGrid(); 

    %draw bombs
    if stateGrid(r, c) == -1
        Screen('FillOval', window, [0, 0, 0], [left + 5, top + 5, left + 20, top + 20]);
    end

    % show number of adjacent bombs if clicked
    if stateGrid(r, c) == 1
        % show number of bombs adjacent to clicked square
        if adjacentGrid(r, c) > 0
            Screen(window,'TextSize',18);
            DrawFormattedText(window, num2str(adjacentGrid(r, c)), left + 7, top + 18, black);
        end
    end

     [exploded, bombGrid, stateGrid, adjacentGrid, numCleared] = checkClicks();
    if adjacentGrid(rowClick, colClick) == 0
                [adjacentGrid, stateGrid, numCleared] = FillEmptySquares(rowClick, colClick, adjacentGrid, stateGrid, numRows, numCols, numCleared);
    end
    
    % figure out when to fill in blanks???
    %[adjacentGrid, stateGrid,numCleared] = FillBlanks();
    Screen('Flip', window);

    %check for game end
    if exploded
        Screen(window,'TextSize',20); % set font size
        Screen ('FillRect',window,uint8(white)); % make entire screen white
        Screen('DrawText', window, 'game over', xc/2, yc/2, black);
  
        %wait for a keyboard button press to terminate.
        KbStrokeWait;
    end

end

% Clear the screen. 
sca;
