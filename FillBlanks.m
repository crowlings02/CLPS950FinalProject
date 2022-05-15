
function[adjacentBombGrid, stateGrid,numCleared] = FillBlanks(row, col, adjacentBombGrid, stateGrid, numRows, numCols, numCleared)
    % for each square, loop through adjacent squares
    for ra=max(row - 1, 1):min(row + 1, numRows)
        for ca=max(col - 1, 1):min(col + 1, numCols)
            % check adjacent square is not the square itself and hasn't been clicked
            if ((row ~= ra) || (col ~= ca)) && (stateGrid(ra, ca) == 0)
                % update square to being clicked and add it as cleared
                stateGrid(ra, ca) = 1;
                numCleared = numCleared + 1;
    
                % if it is blank, recursively call function on that blank's
                % neighbors
                if adjacentBombGrid(ra, ca) == 0
                    [adjacentBombGrid, stateGrid, numCleared] = FillEmptySquares(ra, ca, adjacentBombGrid, stateGrid, numRows, numCols, numCleared);
                end
            end
        end
    end
end