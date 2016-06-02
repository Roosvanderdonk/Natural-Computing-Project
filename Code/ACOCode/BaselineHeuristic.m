function [ heuristic_map ] = BaselineHeuristic( input_image )
%BASELINEHEURISTIC Calculates a heuristic for ACO for a grayscale image
%   The heuristic that was used in the basic script

nrow = size(input_image, 1);
ncol = size(input_image, 2);

heuristic_map = zeros(nrow, ncol);
heuristic_map_norm = 0;

for rr =1:nrow
    for cc=1:ncol
        %definition of clique = the area that is used to compute the
        %heuristic value for this pixel
        temp1 = [rr-2 cc-1; rr-2 cc+1; rr-1 cc-2; rr-1 cc-1; rr-1 cc; rr-1 cc+1; rr-1 cc+2; rr cc-1];
        temp2 = [rr+2 cc+1; rr+2 cc-1; rr+1 cc+2; rr+1 cc+1; rr+1 cc; rr+1 cc-1; rr+1 cc-2; rr cc+1];
        
        temp0 = find(temp1(:,1)>=1 & temp1(:,1)<=nrow & temp1(:,2)>=1 & temp1(:,2)<=ncol & temp2(:,1)>=1 & temp2(:,1)<=nrow & temp2(:,2)>=1 & temp2(:,2)<=ncol);
        
        temp11 = temp1(temp0, :);
        temp22 = temp2(temp0, :);
        
        temp00 = zeros(size(temp11,1)); %fill temp00 with actual intensity differences
        for kk = 1:size(temp11,1)
            temp00(kk) = abs(input_image(temp11(kk,1), temp11(kk,2))-input_image(temp22(kk,1), temp22(kk,2)));
        end
        
        if size(temp11,1) == 0
            heuristic_map(rr, cc) = 0;
            heuristic_map_norm = heuristic_map_norm + heuristic_map(rr, cc);
        else
            lambda = 10;
            temp00 = sin(pi .* temp00./2./lambda); %this corresponds to function (9) in the paper.
            heuristic_map(rr, cc) = sum(sum(temp00.^2));
            heuristic_map_norm = heuristic_map_norm + heuristic_map(rr, cc);
        end
    end
end
heuristic_map = heuristic_map./heuristic_map_norm;
heuristic_map = heuristic_map.*100; %contains the heuristic value for each pixel