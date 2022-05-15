
function [adjacentBombGrid] = GetAdjacentBombs(numRows, numCols,bombGrid)
% stores # of adjacent bombs for every square
adjacentBombGrid = zeros(numRows, numCols);

% loops through entire grid
for r=1:numRows
    for c=1:numCols
        % for each square, loop through adjacent squares
        for ra=max(r - 1, 1):min(r + 1, numRows)
            for ca=max(c - 1, 1):min(c + 1, numCols)
                % update adjacent grid with whether it is a bomb or not
                adjacentBombGrid(r, c) = adjacentBombGrid(r, c) + bombGrid(ra, ca);
            end
        end
    end
end