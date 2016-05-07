colorimage = double(imread('kat.jpg')) ./ 255;
img = double(imread('kat.jpg')) ./ 255;
nrow = size(colorimage, 1);
ncol = size(colorimage, 2);

v = zeros(size(img));
v_norm = 0;
for rr =2:nrow
    for cc=2:ncol
        %definition of clique = the area that is used to compute the
        %heuristic value for this pixel
        temp1 = [rr-2 cc-1; rr-2 cc+1; rr-1 cc-2; rr-1 cc-1; rr-1 cc; rr-1 cc+1; rr-1 cc+2; rr cc-1];
        temp2 = [rr+2 cc+1; rr+2 cc-1; rr+1 cc+2; rr+1 cc+1; rr+1 cc; rr+1 cc-1; rr+1 cc-2; rr cc+1];

        temp0 = find(temp1(:,1)>=1 & temp1(:,1)<=nrow & temp1(:,2)>=1 & temp1(:,2)<=ncol & temp2(:,1)>=1 & temp2(:,1)<=nrow & temp2(:,2)>=1 & temp2(:,2)<=ncol);

        temp11 = temp1(temp0, :);
        temp22 = temp2(temp0, :);

        temp00 = zeros(size(temp11,1), 1); %fill temp00 with actual intensity differences
        temp33 = zeros(size(temp11,1), 1);
        for kk = 1:size(temp11,1)
            
            %Euclidean distance
            point_1 = colorimage(temp11(kk,1), temp11(kk,2), :);
            point_2 = colorimage(temp22(kk,1), temp22(kk,2), :);
            
            temp00(kk) = sqrt(power(point_1(1,1,1) - point_2(1,1,1), 2) + power(point_1(1,1,2) - point_2(1,1,2), 2) + power(point_1(1,1,3) - point_2(1,1,3), 2));
            temp33(kk) = abs(img(temp11(kk,1), temp11(kk,2)) - img(temp22(kk,1), temp22(kk,2)));
        end
        
        temp00
        temp33

        if size(temp11,1) == 0
            v(rr, cc) = 0;
            v_norm = v_norm + v(rr, cc);
        else
            lambda = 10;
            temp00 = sin(pi .* temp00 ./ 2 ./ lambda); %this corresponds to function (9) in the paper.
            v(rr, cc) = sum(sum(temp00.^2));
            v_norm = v_norm + v(rr, cc);
        end
    end
end
v = v./v_norm;  
v = v.*100; %contains the heuristic value for each pixel