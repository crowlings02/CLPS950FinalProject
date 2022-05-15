

function [totalToClear,stateGrid] = GenerateVisualGrid()
%initialize size of the grid
numRows = 16;
numCols = 24;
numCleared = 0;

% Squares without bombs
totalToClear = numRows * numCols - numBombs;

stateGrid = zeros(numRows, numCols);

for r=1:numRows
    for c=1:numCols
        left = (c - 1) * 25;
        top = (r - 1) * 25 + 100;
        
        squareColor = [160, 160, 160];

        if stateGrid(r, c) ~= 0
            squareColor = [110, 110, 110];
        end

        rect = [left + 1, top + 1, left + 24, top + 24];
        
        Screen('FillRect', window, squareColor, rect);
    end
end

Screen('FillRect', window, [80, 80, 80], [0, 0, 600, 500]);

Screen(window,'TextSize',25);
DrawFormattedText(window, 'MINESWEEPER', 'center', 30, black);

Screen(window,'TextSize',18);
DrawFormattedText(window, strcat('Cleared:', num2str(numCleared), '/', num2str(totalToClear)), 20, 70, black);

Screen('FillRect', window, [255, 0, 0], [500, 30, 570, 70]);
Screen(window,'TextSize',25);
DrawFormattedText(window, 'Quit', 511, 58, black);

end
