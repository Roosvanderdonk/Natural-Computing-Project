%analyse results
clear all

%get a list of a the result files
list_files = dir('C:\Users\roosv_000\Documents\Natural computing grid search');

%remove non existing files '..'
list_files(1:2)=[];

nr_files=size(list_files,1);


%%%%%%%%%%%%%%%%% GET THE OPTIMAL PARAMETERS PER METHOD %%%%%%%%%%%%%%%%%

%get the maximum f score for every file
for x = 1:nr_files
    file_name = list_files(x).name;
    load(file_name);
    % get maximum f score for every resultfile
    [max_f_measure,index] = max(final_results(:,8));
    idx = find(final_results(:,8) == max_f_measure);
    
    % Check if the maximum is unique
    if size(idx,2)>1
        display('maximum is not unique')
    end
    
    max_par(x,:) = final_results(index,:);
        
end

% [val i]=max(max_par(1:5,8))
% 
% best_par_RGBMAX = 
% best_par_RGBSUM =
% best_par_Cosine =
% best_par_Gray =
% best_par_Vector =


%%%%%%%%%%%% SAVE THE FIGURES WITH BEST PARAMETERS FOR EACH METHOD %%%%%%


%%%%%%%%%%%% MAKE BOXPLOT OF ALL F1 SCORES FOR EVERY METHOD %%%%%%%%%%

Value = [];
m=1;
%for every method
for methods=1:5
    %merge the f1 scores of the 5 result files
    for x = m:5*methods
        file_name = list_files(x).name;
        load(file_name);
        Field = num2cell(final_results);
        %concatenate the f1 scores of alle the resultfiles of one method.
        Value = cat(1, Value, Field);
    end
    m = m+5;
    %put f1 scores of all 5 methods in one matrix
    f_scores(:,methods) = cell2mat(Value(:,8));
    Value=[];
    
end

% make a boxplot of the five methods
boxplot(f_scores, 'Labels',{'RGB max', 'RGB sum', 'Cosine', 'Gray' , 'Vector'})
xlabel('Method')
ylabel('F1-Score')



