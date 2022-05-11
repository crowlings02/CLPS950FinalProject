%SQUARE MATRIX MUST HAVE 0'S IN THE 5TH COLUMN
while num_bombs>0
    placement_x = rand*length(board, 2);
    placement_y = rand*length(board, 1);
    for add_bomb = 1:length(square_matrix, 1)
        if square_matrix(add_bomb, 5) ~= 9 && square_matrix(add_bomb, 1) < placement_x && square_matrix(add_bomb, 2) > placement_x && square_matrix(add_bomb, 3) < placement_y && square_matrix(add_bomb, 4) > placement_y
            square_matrix(add_bomb, 5) = 9;
            num_bombs = num_bombs - 1;
        end
    end
end


    % each r1... with coordinates will correspond to an index in a matrix,
    % # is the 5th column
size = square_matrix(1, 2) - square_matrix(1,1);
for ii = 1:length(square_matrix, 1)
    if square_matrix(ii, 5)== 9 % 9 = mine because max number of surrounding mines = 8
       square_matrix(jj-1, 5) = square_matrix(jj-1, 5) + 1;
       square_matrix(jj+1, 5) = square_matrix(jj+1, 5) + 1;
       square_matrix(jj-L_U_DIAG, 5) = square_matrix(jj-L_U_DIAG, 5) + 1;
       square_matrix(jj-R_U_DIAG, 5) = square_matrix(jj-R_U_DIAG, 5) + 1;
       square_matrix(jj-ABOVE, 5) = square_matrix(jj-ABOVE, 5)+ 1;
       square_matrix(jj-L_D_DIAG, 5) = square_matrix(jj-L_D_DIAG, 5)+ 1;
       square_matrix(jj-R_D_DIAG, 5) = square_matrix(jj-R_D_DIAG, 5) + 1;
       square_matrix(jj-BELOW, 5) = square_matrix(jj-BELOW, 5) + 1;
    end
end
