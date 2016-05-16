function [] = to_grayscale( filename, index)

RGB = imread(filename);
I = rgb2gray(RGB);
I = I(:,:,1);
imwrite(uint8(I), gray(256), [num2str(index) '_grayscale.jpg']); 