function [] = GridSearch(method, imageindex)
%Gridsearch Evaluates different settings of parameters for the
%given method and imagefile
%   method = 'RGBsum', normal ACS with RGB separate, then summed.
%            'RGBmax', normal ACS with RGB separate, then max per pixel.
%            'vector', HVI, euclidean distance as heuristic.
%            'cosine', RGB, cosine distance as heuristic.
%            'gray', grayscale normal ACS.
%   imageindex = the index of the image you want to do grid search on
% Saves scores in a matlab file.

% List all possibilities
possible_num_iterations = [2, 4, 6, 8];
possible_ant_num_steps = [40]; %Fixed to 40
possible_ant_memory_length = [5, 10, 15, 20];
possible_alpha = [0.9, 1, 1.1];
possible_beta = [0.05, 0.1, 1];
possible_rho = [0.05, 0.1, 0.15];
possible_phi = [0.025, 0.05, 0.1];

% Allocate final_results
total_entries = length(possible_num_iterations) * length(possible_ant_num_steps) ...
    * length(possible_ant_memory_length) * length(possible_alpha) ...
    * length(possible_beta) * length(possible_rho) * length(possible_phi);
final_results = zeros(total_entries, 12);
final_figures = zeros(128,128,total_entries);

% Keep track of which entry is analyzed
current_entry = 1;

% Start gridsearch
for iteration = 1: length(possible_num_iterations)
    for ant_num_steps = 1: length(possible_ant_num_steps)
        for ant_memory_length = 1: length(possible_ant_memory_length)
            for alpha = 1: length(possible_alpha)
                for beta = 1: length(possible_beta)
                    for rho = 1: length(possible_rho)
                        for phi = 1: length(possible_phi)
                            
                            %display progress
                            display(['Entry ' num2str(current_entry) ' of ' num2str(total_entries)])
                                                        
                            % Get input_files
                            input_file = strcat('Trainset/', num2str(imageindex), '.jpg');
                            edge_file = strcat('Trainset/', num2str(imageindex), '_edge.png');
                            
                            %read image
                            image = double(imread(input_file)) ./ 255;
                                             
                            % Run ACO method on image with specified
                            % parameters
                            pheromone_map = get_pheromone_map(method, image, ...
                                possible_num_iterations(iteration), ...
                                possible_ant_num_steps(ant_num_steps), ...
                                possible_ant_memory_length(ant_memory_length), ...
                                possible_alpha(alpha), ...
                                possible_beta(beta), ...
                                possible_rho(rho), ...
                                possible_phi(phi));
                            
                            % Read in edge, evaluate performance
                            edge = imread(edge_file);
                            [final_figures(:,:,current_entry), scores] = Eval_Pheromones(edge, pheromone_map);
                            
                            % Save results
                            final_results(current_entry, :) = [possible_num_iterations(iteration) ...
                                possible_ant_num_steps(ant_num_steps) ...
                                possible_ant_memory_length(ant_memory_length) ...
                                possible_alpha(alpha) ...
                                possible_beta(beta) ...
                                possible_rho(rho) ...
                                possible_phi(phi) ...
                                scores];
                            
                            current_entry = current_entry + 1;
                        end
                    end
                end
            end
        end
    end
end

columns = {'iterations', 'steps', 'memory', 'alpha', 'beta', 'rho', 'phi', 'f_measure', 'tp', 'tn', 'fp', 'fn'};

%Save evaluation results in .mat file
filename = ['gridsearch_' method '_' num2str(imageindex) '.mat'];
save(filename, 'final_results', 'final_figures', 'columns')

end

function [pheromone_map] = get_pheromone_map(method, image, num_iterations, ant_num_steps, ant_memory_length, alpha, beta, rho, phi)

if strcmp(method, 'RGBsum')
    pheromone_map = ACORGBsum(image, ...
        'BaselineHeuristic', ...
        'AntCreation', ...
        'RandomAntInitialization', ...
        'EightNPosSteps', ...
        num_iterations, ...
        ant_num_steps, ...
        ant_memory_length, ...
        alpha, ...
        beta, ...
        rho, ...
        phi);
    
elseif strcmp(method, 'RGBmax')
    pheromone_map = ACORGBmax(image, ...
        'BaselineHeuristic', ...
        'AntCreation', ...
        'RandomAntInitialization', ...
        'EightNPosSteps', ...
        num_iterations, ...
        ant_num_steps, ...
        ant_memory_length, ...
        alpha, ...
        beta, ...
        rho, ...
        phi);
    
elseif strcmp(method, 'vector')
    pheromone_map = ACOEdgeDetection(image, ...
        'VectorHeuristic', ...
        'AntCreation', ...
        'RandomAntInitialization', ...
        'EightNPosSteps', ...
        num_iterations, ...
        ant_num_steps, ...
        ant_memory_length, ...
        alpha, ...
        beta, ...
        rho, ...
        phi);
    
elseif strcmp(method, 'cosine')
    pheromone_map = ACOEdgeDetection(image, ...
        'CosineHeuristic', ...
        'AntCreation', ...
        'RandomAntInitialization', ...
        'EightNPosSteps', ...
        num_iterations, ...
        ant_num_steps, ...
        ant_memory_length, ...
        alpha, ...
        beta, ...
        rho, ...
        phi);
    
elseif strcmp(method, 'gray')
    
    %Turn RGB image into grayscale image
    gray = rgb2gray(image);
    gray = gray(:,:,1);
    
    pheromone_map = ACOEdgeDetection(gray, ...
        'BaselineHeuristic', ...
        'AntCreation', ...
        'RandomAntInitialization', ...
        'EightNPosSteps', ...
        num_iterations, ...
        ant_num_steps, ...
        ant_memory_length, ...
        alpha, ...
        beta, ...
        rho, ...
        phi);
    
else
    display('method not recognized')
end

end


