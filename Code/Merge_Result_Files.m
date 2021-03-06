%merge the results file per method by averaging the scores for the figures

clear all

%get a list of a the result files, fill in directory to result files.
list_files = dir('C:\Users\roosv_000\Documents\Natural computing grid search');

%remove non existing files '..'
list_files(1:2)=[];
nr_files=size(list_files,1);
if nr_files~=25
    display('folder should contain 25 result files')
end


m=1;
%for every method
for methods=1:5
    scores=zeros(1296,5);
    all_results = [];
    all_figures=[]
    %merge the f1 scores of the 5 result files
    for x = m:5*methods
        file_name = list_files(x).name;
        load(file_name);
        
        %concatenate the f1 scores of alle the resultfiles of one method.
        scores = scores+final_results(:,8:12);
        all_results = cat(1, all_results, final_results);
        all_figures= cat(4,all_figures, final_figures);
        
    end
    final_results(:,8:12)=scores./5;
    final_scores_average = final_results;
    name = list_files(methods*5).name;
    name = strcat(name(1:end-5), 'all')
    save(name, 'all_results', 'columns', 'all_figures', 'final_scores_average');
    m = m+5;
           
end
