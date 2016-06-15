%% make figures

load('best_parameters.mat')
nr_methods = size(order_best_parameters,2)
for method = 1:nr_methods
    figure;
    for image= 1:5
    subplot(1,5,image)
    s1=subimage(squeeze(max_par_fig(method,:,:,image)))
    figure_number = num2str(image)
    fig_name = strcat(figure_number)
        title(fig_name')
        set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', [])
            set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', [])
    end
end