
function[numCleared, totalToClear,exploded, bombGrid] = GenerateBombs()
numBombs = 40;
numCleared = 0;
totalToClear = numRows * numCols - numBombs;

bombGrid = zeros(numRows, numCols);
randSample = randperm(numRows * numCols, numBombs);

exploded = 0;

for i=randSample
    bombGrid(idivide(int32(i) - 1, int32(numCols)) + 1, mod(i - 1, numCols) + 1) = 1;
end

end