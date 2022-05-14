%initialize size of the grid
numRows = 16;
numCols = 24;

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




% Screen(‘FillRect’, windowPtr [,color] [,rect] )
% 
% Fill “rect”. “color” is the clut index (scalar or [r g b] triplet or [r g b a]
% quadruple) that you want to poke into each pixel; default produces white with
% the standard CLUT for this window’s pixelSize. Default “rect” is entire window,
% so you can use this function to clear the window. Please note that clearing the
% entire window will set the background color of the window to the clear color,
% ie., future Screen(‘Flip’) commands will clear to the new background clear color
% specified in Screen(‘FillRect’).
% Instead of filling one rectangle, you can also specify a list of multiple
% rectangles to be filled - this is much faster when you need to draw many
% rectangles per frame. To fill n rectangles, provide “rect” as a 4 rows by n
% columns matrix, each column specifying one rectangle, e.g., rect(1,5)=left
% border of 5th rectange, rect(2,5)=top border of 5th rectangle, rect(3,5)=right
% border of 5th rectangle, rect(4,5)=bottom border of 5th rectangle. If the
% rectangles should have different colors, then provide “color” as a 3 or 4 row by
% n column matrix, the i’th column specifiying the color of the i’th rectangle.
% 
