
function [exploded, bombGrid, stateGrid, adjacentGrid, numCleared] = checkClicks(window, exploded, bombGrid, stateGrid, adjacentGrid, numCleared)
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
            if adjacentGrid(rowClick, colClick) == 0
                [adjacentGrid, stateGrid, numCleared] = FillBlanks(rowClick, colClick, adjacentGrid, stateGrid, numRows, numCols, numCleared);
            end
        end
    end
end