function [ pheromone_map ] = ACOEdgeDetection( input_file, heuristic_name, ant_creation_name, ant_initialization_name, ant_possible_step_name, num_iterations, ant_num_steps, ant_memory_length, alpha, beta, rho, phi )
%ACOEDGEDETECTION creates a pheromone map of the edges for a given image.
% INPUT_FILE the location of the image to be processed.
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


% Load image
image = double(imread(input_file)) ./ 255;
nrow = size(image, 1);
ncol = size(image, 2);

% Caluclate Heuristic
heuristic_func = str2func(heuristic_name);
heuristic_map = heuristic_func(image);

% Initialize
pheromone_map = 0.0001 .* ones(nrow, ncol);

% Calculate number of ants
ant_creation_func = str2func(ant_creation_name);
number_of_ants = ant_creation_func(image);

% Create ant memory
ant_memory = zeros(number_of_ants, ant_memory_length, 2);

% Set begin positions of ants
ant_initialization_func = str2func(ant_initialization_name);
ant_positions = ant_initialization_func(image, heuristic_map, number_of_ants);


% Start ACO
for iteration = 1: num_iterations
    
    %record the positions where ant have reached in the last 'memory_length' iterations    
    delta_p = zeros(nrow, ncol);
    
    for step_nr = 1: ant_num_steps
        
        delta_p_current = zeros(nrow, ncol);
        
        for ant = 1:number_of_ants
            
            % Get possible moves for ant
            ant_possible_step_func = str2func(ant_possible_step_name);
            ant_possible_steps = ant_possible_step_func(image, ant_positions(ant,:,:));
            
            % Decide step
            step = DecideStep(heuristic_map, pheromone_map, ant_possible_steps, ant_memory(ant, :, :), alpha, beta);
            
            % Process step
            ant_positions(ant,:) = step;
            
            %record the delta_p_current
            delta_p_current(ant_positions(ant,1), ant_positions(ant,2)) = 1;

            % record the new position into ant's memory
            ant_memory(ant, mod(step_nr, ant_memory_length) + 1, :) = step;
            
            %update the pheromone function per ant
            pheromone_map = ((1-rho) .* pheromone_map + rho .* delta_p_current .* heuristic_map) .* delta_p_current + pheromone_map .* (abs(1 - delta_p_current));
        end
        
        % update the pheromone function when all ants did their idx step
        delta_p = (delta_p + (delta_p_current > 0)) > 0;
        pheromone_map = (1-phi) .* pheromone_map; 
    end
end
end

