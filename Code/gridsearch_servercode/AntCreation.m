function [ number_of_ants ] = AntCreation( input_image )
%ANTCREATION Summary of this function goes here
%   Detailed explanation goes here

nrow = size(input_image, 1);
ncol = size(input_image, 2);

number_of_ants = round(sqrt(nrow*ncol));


end

