image = double(imread('dataset\testset\1.jpg')) ./ 255;

pheromone_map = ACOEdgeDetection(image, ...
'CosineHeuristic', ...
'AntCreation', ...
'RandomAntInitialization', ...
'EightNPosSteps', ...
4, 300, 40, 10, 0.1, 0.1, 0.05);

T = func_seperate_two_class(pheromone_map);

result = pheromone_map;
result(result < T) = 1;
result(result >= T) = 0;

edge = imread('dataset\testset\1_edge.png');

Evaluate(edge, result)

% added:
figure
[fig, eval] = Eval_Pheromones(edge./255, pheromone_map);
imshow(fig)