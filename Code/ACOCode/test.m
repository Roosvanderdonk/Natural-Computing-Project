pheromone_map = ACOEdgeDetection('kat.jpg', ...
'VectorHeuristic', ...
'AntCreation', ...
'RandomAntInitialization', ...
'FourNPosSteps', ...
4, 300, 40, 10, 0.1, 0.1, 0.05);

T = func_seperate_two_class(pheromone_map);

result = pheromone_map;
result(result < T) = 0;
result(result >= T) = 1;

edge = imread('..\..\dataset\11_edge.jpg');
edge(edge <= 128) = 1;
edge(edge > 128) = 0;

Evaluate(edge, result)