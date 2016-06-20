%% make figures2

load('best_parameters.mat')
nr_methods = size(order_best_parameters,2)
for method = 1:nr_methods
    figure;
    for image= 1:1
     s1=subimage(squeeze(max_par_fig(method,:,:,image)))
    figure_number = num2str(method)
    fig_name = strcat('C:\Users\roosv_000\Documents\Natural-Computing-Project\Dataset\',figure_number)
     
            imwrite(s1, fig_name, 'png');  

    end
end