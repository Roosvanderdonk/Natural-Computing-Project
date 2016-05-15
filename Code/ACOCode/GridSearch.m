% List all possibilities


possible_num_iterations = 1:20;
possible_ant_num_steps = [10, 25, 50, 100, 200, 300, 500];
possible_ant_memory_length = [0, 10, 25, 40, 50, 100];
possible_alpha = [0.1, 0.5, 1, 5, 10, 20];
possible_beta = [0.1, 0.5, 1, 5, 10, 20];
possible_rho = 0.1:0.1:0.9;
possible_phi = 0.1:0.1:0.9;





for iteration = 1: length(possible_num_iterations)
    for ant_num_steps = 1: length(possible_ant_num_steps)
        for ant_memory_length = 1: length(possible_ant_memory_length)
            for alpha = 1: length(possible_alpha)
                for beta = 1: length(possible_beta)
                    for rho = 1: length(possible_rho)
                        for phi = 1; length(possible_phi)
                            
                            pheromone_map = ACOEdgeDetection('kat.jpg', ...
                                'VectorHeuristic', ...
                                'AntCreation', ...
                                'RandomAntInitialization', ...
                                'FourNPosSteps', ...
                                possible_num_iterations(iteration), ...
                                possible_ant_num_steps(300), ...
                                possible_ant_memory_length(40), ...
                                possible_alpha(10), ...
                                possible_beta(0.1), ...
                                possible_rho(0.1), ...
                                possible_phi(0.05));
                            
                            T = func_seperate_two_class(pheromone_map);
                            result = abs((pheromone_map >= T) .* 255 - 255);
                            
                            
                        end
                    end
                end
            end
        end
    end
end













