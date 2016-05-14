function [ ant_positions ] = RandomAntInitialization( input_image, heuristic_map, number_of_ants )
%RANDOMANTINITIALIZATION Summary of this function goes here
%   Detailed explanation goes here

nrow = size(input_image, 1);
ncol = size(input_image, 2);

rand('state', sum(clock));
temp = rand(number_of_ants, 2);
ant_positions(:,1) = round(1 + (nrow-1) * temp(:,1)); %row index
ant_positions(:,2) = round(1 + (ncol-1) * temp(:,2)); %column index

end

