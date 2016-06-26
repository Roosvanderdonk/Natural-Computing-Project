function [ pheromone_maps, history ] = ACORGB( image, heuristic_name, ant_creation_name, ant_initialization_name, ant_possible_step_name, num_iterations, ant_num_steps, ant_memory_length, alpha, beta, rho, phi)
%ACOEDGEDETECTION creates a pheromone map of the edges for a given image.
% IMAGE the image to be processed.
%
% HEURISTIC_NAME the name of the function that calculates the heuristic. 
%   It should take the input image as argument and return a
%   heuristic map that is the size of the image.
%
% ANT_CREATION_NAME the name of the function that calculates the amount of
% ants.
%   It should take the input image as argument and return the desired
%   number of ants.
%
% ANT_INITIALIZATION_NAME the name of the function that gives the ants
% their initial position.
%   It should take the input image, the heuristic map and the n umber of
%   ants as inputs and it should return a list(num_ants, 2) with the
%   starting location of each ant.
%
% ANT_POSSIBLE_STEP_NAME the name of the function that calculates the
% possible locations where the ant can go.
%   It should take as argument the input image and the ants location and it
%   should return a list(num_pos_steps, 2) of possible steps.
%
% NUM_ITERATIONS the number of iterations.
%
% ANT_NUM_STEPS the number of steps each ant takes per iteration.
%
% ANT_MEMORY_LENGTH the number of steps the ant keeps in his memory.
%
% ALPHA the influence of the pheromone levels on deciding which step to
% take.
%
% BETA the influence of the heuristic information on deiciding which step
% to take.
%
% RHO evaporation rate: pheromone decay after individual ant step.
%
% PHI pheromone decay coefficient: pheromone decay after all ants have done
% a step.

% pheromone matrices
pheromone_maps = zeros(3, 128, 128);
history = zeros(3, num_iterations + 1, 128, 128);

for i = 1:3
    [pheromone_maps(i,:,:), history(i,:,:,:)] = ACOEdgeDetection( image(:,:,i), heuristic_name, ant_creation_name, ant_initialization_name, ant_possible_step_name, num_iterations, ant_num_steps, ant_memory_length, alpha, beta, rho, phi );
    
end
