
clear all
%get a list of a the merged result files, fill in directory to merged result files.
list_files = dir('C:\Users\roosv_000\Documents\Natural computing results merged');

%remove non existing files '..'
list_files(1:2)=[];
nr_methods=size(list_files,1);
if nr_methods~=5
    display('folder should contain 5 merged result files')
end

%for all methods
for x = 1:nr_methods
    file_name = list_files(x).name;
    load(file_name);
    % get maximum f score for every resultfile
    [max_f_measure,index] = max(final_scores_average(:,8));
    idx = find(final_scores_average(:,8) == max_f_measure);
    
    % Check if the maximum is unique
    if size(idx,2)>1
        display('maximum is not unique')
    end
    f_scores(:,x) = final_scores_average(:,8);
    best_parameters(x,:) = final_scores_average(index,:);
    max_par_fig(x,:,:,:) = squeeze(all_figures(:,:,index,:));
end

%switch order of column to get same order as in the report
f_scores_order=f_scores;
f_scores_order(:,1) = f_scores(:,4);
f_scores_order(:,2:3) = f_scores(:,1:2);
f_scores_order(:,4) = f_scores(:,5);
f_scores_order(:,5) = f_scores(:,3);



figure;
% make a boxplot of the five methods
boxplot(f_scores_order, 'Labels',{'Gray Scale', 'RGB Max', 'RGB Sum', 'RGB Euclidean','RGB Cosine'})
xlabel('Method')
ylabel('Average F1-Score')

order_best_parameters= {list_files.name};
save( 'best_parameters', 'order_best_parameters','best_parameters', 'columns', 'max_par_fig');


