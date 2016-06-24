load('E:\Workspace\Natural-Computing-Project\Results\test_results.mat')
load('E:\Workspace\Natural-Computing-Project\Results\heuristic_results.mat')

agg_heur = [results_gray(:,1); results_max(:,1); results_sum(:,1); results_vec(:,1); results_cos(:,1)];
agg_test = [test_results(:,1); test_results(:,2); test_results(:,3); test_results(:,4); test_results(:,5)];

%Change lines
figure
plot([1, 2], [agg_heur, agg_test], '-o')
axis([0.75 2.25 0.75 1])
set(gca,'XTickLabel',{'','Heuristic','','','','','ACO',''})

%Boxplots
figure
boxplot([results_gray(:,1), test_results(:,1), results_max(:,1), test_results(:,2), results_sum(:,1), test_results(:,3), results_vec(:,1), test_results(:,4), results_cos(:,1), test_results(:,5)], {'H Gray', 'Gray', 'H RGB Max', 'RGB Max', 'H RGB Sum', 'RGB Sum', 'H HSV Euclidean', 'HSV Euclidean', 'H RGB Cosine', 'RGB Cosine'});
