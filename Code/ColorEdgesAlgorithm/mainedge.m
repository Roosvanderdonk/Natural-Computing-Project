 figure, im = imread('pepperssmall.png'); imshow(im)

    %get color edges and normalize magnitude
    C = coloredges(im);
    C = C / max(C(:));

    %get grayscale edges and normalize magnitude
    G_image = single(rgb2gray(im)) / 255;
    G = sqrt(imfilter(G_image, fspecial('sobel')').^2 + imfilter(G_image, fspecial('sobel')).^2);
    G = G / max(G(:));

    %show comparison
    figure, imshow(uint8(255 * cat(3, C, G, G)))
    
    %threshold
    th=[0:0.005:0.2];
    range=size(th);
    
%     %vary the threshold for the coloredges
%     for i=1:range(2)
%         th(i)
%         CC=C;
%         CC(CC<th(i))=0;
%         CC(CC>0.0001)=1;
%         imshow(CC)
%         pause(1)
%     end

threshold = func_seperate_two_class(C)

CC=C;
        CC(CC<threshold)=1;
        CC(CC<0.9999)=0;
        figure
        imshow(CC)
        imwrite(CC, ['test_edge.png'], 'png');  
