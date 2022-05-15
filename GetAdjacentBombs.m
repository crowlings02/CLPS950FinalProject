% stores # of adjacent bombs for every square
adjacentGrid = zeros(numRows, numCols);

% loops through entire grid
for r=1:numRows
    for c=1:numCols
        % for each square, loop through adjacent squares
        for ra=max(r - 1, 1):min(r + 1, numRows)
            for ca=max(c - 1, 1):min(c + 1, numCols)
                % update adjacent grid with whether it is a bomb or not
                adjacentGrid(r, c) = adjacentGrid(r, c) + bombGrid(ra, ca);
            end
        end
    end
end