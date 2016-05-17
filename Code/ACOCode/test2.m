dataset_dir = dir('..\..\dataset');

dataset_original = {};
dataset_edge = {};

for entry = 1: size(dataset_dir,1)
    
    file_name = dataset_dir(entry).name;
    
    if strfind(file_name, '.jpg')
        if strfind(file_name, 'edge')
            dataset_edge = {dataset_edge{1}; file_name};
        else
            dataset_original = {dataset_original{1}; file_name};
        end
    end
end