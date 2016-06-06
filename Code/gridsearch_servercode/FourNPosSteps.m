function [ possible_steps ] = FourNPosSteps( image, ant_position )
%FOURNPOSSTEPS Summary of this function goes here
%   Detailed explanation goes here

nrow = size(image, 1);
ncol = size(image, 2);

row = ant_position(1);
col = ant_position(2);
ant_search_range_temp = [row-1 col; row col+1; row+1 col; row col-1];

possible_steps = ant_search_range_temp(ant_search_range_temp(:,1) >= 1 & ant_search_range_temp(:,1) <= nrow & ant_search_range_temp(:,2)>= 1 & ant_search_range_temp(:,2) <= ncol, :);

end

