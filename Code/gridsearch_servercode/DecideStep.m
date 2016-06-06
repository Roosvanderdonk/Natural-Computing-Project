function [ step ] = DecideStep( heuristic_map, pheromone_map, ant_possible_steps, ant_memory, alpha, beta )
%DECIDESTEP Summary of this function goes here
%   Detailed explanation goes here

%calculate the transit probability to the neighborhood of current position
ant_transit_prob_v = zeros(size(ant_possible_steps,1),1);
ant_transit_prob_p = zeros(size(ant_possible_steps,1),1);

%Caluclate transition probabilities
for kk = 1:size(ant_possible_steps, 1) %for all positions (x,y) the ant can choose from:
    
    % Check if the position is in the ants memory
    if sum(ant_memory(1, :, 1) == ant_possible_steps(kk, 1) & ant_memory(1, :, 2) == ant_possible_steps(kk, 2)) == 0 %not in ant's memory
        ant_transit_prob_v(kk) = heuristic_map(ant_possible_steps(kk,1), ant_possible_steps(kk,2));
        ant_transit_prob_p(kk) = pheromone_map(ant_possible_steps(kk,1), ant_possible_steps(kk,2));
    else %is in ant's memory, than make probabilaties of going there zero.
        ant_transit_prob_v(kk) = 0;
        ant_transit_prob_p(kk) = 0;
    end
end

% if all neighborhood positions are in memory, then the ant does not care
% about memory
if (sum(sum(ant_transit_prob_v)) == 0) || (sum(sum(ant_transit_prob_p)) == 0)
    for kk = 1:size(ant_possible_steps,1)
        ant_transit_prob_v(kk) = heuristic_map(ant_possible_steps(kk,1), ant_possible_steps(kk,2));
        ant_transit_prob_p(kk) = pheromone_map(ant_possible_steps(kk,1), ant_possible_steps(kk,2));
    end
end

%calculate the probability of moving to every possible position,
%considering v and p.
ant_transit_prob = (ant_transit_prob_v.^alpha) .* (ant_transit_prob_p.^beta) ./ (sum(sum((ant_transit_prob_v.^alpha) .* (ant_transit_prob_p.^beta))));

% generate a random number to determine the next position.
rand('state', sum(100*clock));
temp = find(cumsum(ant_transit_prob) >= rand(1), 1);

if isempty(temp)
    temp = round(rand(1) * (size(ant_possible_steps, 1) - 1) + 1);
end

step = ant_possible_steps(temp, :);
end

