FLIP MEchanism:
%MAKE SURE COLUMN 6 IS 0S
%within click action >>
click_x, click_y = location_click() % from other function, ask Caitlin how to integrate
    for flip = 1:length(square_matrix, 1)
        if square_matrix(flip, 5) == 9 && square_matrix(flip, 1) < click_x && square_matrix(flip, 2) > click_x && square_matrix(flip, 3) < click_y && square_matrix(flip, 4) > click_y
            square_matrix(flip, 6) = 1; %not necessary since the game will end anyway
            %flip corresponding square;
            'ending' = true;
        elseif square_matrix(flip, 5) == 0 && square_matrix(flip, 1) < click_x && square_matrix(flip, 2) > click_x && square_matrix(flip, 3) < click_y && square_matrix(flip, 4) > click_y
           %flip corresponding
           square_matrix(flip, 6) = 1;
           blank_flipped = true;
           while blank_flipped == true % start a while loop that scans board (infinitely) for ALL BLANKS (not just the recently flipped one)
               new_flips = false;
               for jj = 1:length(square_matrix, 1) %for each blank found, scan every square for proximity, flip
                   if square_matrix(jj, 6) == 1 && square_matrix(jj, 5) == 0 && (square_ matrix(jj-1, 6) == 0 || square_matrix(jj+1, 6) == 0 ||...) % if there are unflipped surroundings, flip al surroundings and set variable so loop continues
%                        square_matrix(jj, 1) = x1
%                        square_matrix(jj, 2) = x2
%                        square_matrix(jj, 3) = y1
%                        square_matrix(jj, 4) = y2
                       square_matrix(jj-1, 6) = 1;
                       square_matrix(jj+1, 6) = 1;
                       square_matrix(jj-L_U_DIAG, 6) = 1;
                       square_matrix(jj-R_U_DIAG, 6) = 1;
                       square_matrix(jj-ABOVE, 6) = 1;
                       square_matrix(jj-L_D_DIAG, 6) = 1;
                       square_matrix(jj-R_D_DIAG, 6) = 1;
                       square_matrix(jj-BELOW, 6) = 1;
                       new_flips = true;
                   end
               end
               if new_flips == false
                   blank_flipped = false;
               end
           end
        elseif square_matrix(flip, 1) < click_x && square_matrix(flip, 2) > click_x && square_matrix(flip, 3) < click_y && square_matrix(flip, 4) > click_y
            square_matrix(flip, 6) = 1;
            %flip corresponding square;
        end
    end