
function[numCleared, totalToClear,exploded, numBombs, bombGrid] = GenerateBombs(numCleared, totalToClear, numBombs)

bombGrid = zeros(numRows, numCols);
randSample = randperm(numRows * numCols, numBombs);

exploded = 0;

for i=randSample
    bombGrid(idivide(int32(i) - 1, int32(numCols)) + 1, mod(i - 1, numCols) + 1) = 1;
end

end