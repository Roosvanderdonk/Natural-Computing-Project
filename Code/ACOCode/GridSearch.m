% List all possibilities
possible_num_iterations = [3, 4, 5];
possible_ant_num_steps = [50, 250, 500];
possible_ant_memory_length = [0, 25, 50];
possible_alpha = [0.25, 1, 10];
possible_beta = [0.25, 1, 10];
possible_rho = [0.2, 0.5, 0.8];
possible_phi = [0.2, 0.5, 0.8];

% Load dataset
images = 11;

% Allocate final_results
total_entries = length(possible_num_iterations) * length(possible_ant_num_steps) ...
    * length(possible_ant_memory_length) * length(possible_alpha) ...
    * length(possible_beta) * length(possible_rho) * length(possible_phi) ...
    * length(images);
final_results = zeros(total_entries, 9);

% Start gridsearch
index = 1;
for iteration = 1: length(possible_num_iterations)
    for ant_num_steps = 1: length(possible_ant_num_steps)
        for ant_memory_length = 1: length(possible_ant_memory_length)
            for alpha = 1: length(possible_alpha)
                for beta = 1: length(possible_beta)
                    for rho = 1: length(possible_rho)
                        for phi = 1: length(possible_phi)
                            for image = 1: length(images)
                                
                                % Get input_files
                                input_file = strcat('..\..\dataset\', num2str(images(image)), '.jpg');
                                edge_file = strcat('..\..\dataset\', num2str(images(image)), '_edge.jpg');
                                
                                % Run ACO
                                pheromone_map = ACOEdgeDetection(input_file, ...
                                    'VectorHeuristic', ...
                                    'AntCreation', ...
                                    'RandomAntInitialization', ...
                                    'EightNPosSteps', ...
                                    possible_num_iterations(iteration), ...
                                    possible_ant_num_steps(ant_num_steps), ...
                                    possible_ant_memory_length(ant_memory_length), ...
                                    possible_alpha(alpha), ...
                                    possible_beta(beta), ...
                                    possible_rho(rho), ...
                                    possible_phi(phi));
                                
                                % Post processing
                                T = func_seperate_two_class(pheromone_map);
                                result = pheromone_map;
                                result(result < T) = 0;
                                result(result >= T) = 1;
                                
                                edge = imread(edge_file);
                                
                                % Save results
                                final_results(index, :) = [images(image) ...
                                    possible_num_iterations(iteration) ...
                                    possible_ant_num_steps(ant_num_steps) ...
                                    possible_ant_memory_length(ant_memory_length) ...
                                    possible_alpha(alpha) ...
                                    possible_beta(beta) ...
                                    possible_rho(rho) ...
                                    possible_phi(phi) ...
                                    Evaluate(edge, result)];
                                
                                if mod(index, 100) == 0
                                    disp(index)
                                end
                                index = index + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end













