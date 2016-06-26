
results_gray = zeros(5,5);
results_max = zeros(5,5);
results_sum = zeros(5,5);
results_vec = zeros(5,5);
results_cos = zeros(5,5);

for image_i = 1:5
    
    edge = double(imread(strcat('dataset\testset\', num2str(image_i), '_edge.png')));
    
    
    [~, results_gray(image_i, :)] = Eval_Pheromones(edge, squeeze(heur_gray(image_i,:,:)));
    [~, results_max(image_i, :)] = Eval_Pheromones(edge, squeeze(heur_max(image_i,:,:)));
    [~, results_sum(image_i, :)] = Eval_Pheromones(edge, squeeze(heur_sum(image_i,:,:)));
    [~, results_vec(image_i, :)] = Eval_Pheromones(edge, squeeze(heur_vec(image_i,:,:)));
    [~, results_cos(image_i, :)] = Eval_Pheromones(edge, squeeze(heur_cos(image_i,:,:)));

end