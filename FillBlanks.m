
function[adjacentGrid, stateGrid,numCleared] = FillBlanks(rowClick, colClick, adjacentGrid, stateGrid, numRows, numCols, numCleared)
    % for each square, loop through adjacent squares
        for ra=max(r - 1, 1):min(r + 1, numRows)
            for ca=max(c - 1, 1):min(c + 1, numCols)
                %make recursive
                %if blank, then it 
                if stateGrid(ra, ca) == 0
                    stateGrid(ra, ca) = 1;
                    numCleared = numCleared + 1;
                    [adjacentGrid, stateGrid, numCleared] = FillEmptySquares(ra, ca, adjacentGrid, stateGrid, numRows, numCols, numCleared);
                end
            end
        end
end
