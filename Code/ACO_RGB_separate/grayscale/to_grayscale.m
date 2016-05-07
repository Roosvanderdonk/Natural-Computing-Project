function [] = to_grayscale( filename)

RGB = imread(filename);
I = rgb2gray(RGB);

imwrite(uint8(I), gray(256), ['grayscale_' filename]); 