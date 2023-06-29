function PlotGroupRats ( data, groups )

figure;
hold on;

colors = colormap(lines);

temp_color_2 = colors(1, :);
colors(1, :) = colors(2, :);
colors(2, :) = temp_color_2;

unique_groups = unique(groups);

for i = 1:length(unique_groups)
    group_id = unique_groups(i);
    this_group_color = colors(group_id, :);
    this_group_rats = find(groups == group_id);
    this_group_data = data(this_group_rats, :);
    this_group_mean = nanmean(this_group_data, 1);
    this_group_err = nanstd(this_group_data, 1) / sqrt(size(this_group_data, 1));
    x_vals = 1:size(this_group_data, 2);
    
    errorbar(x_vals, this_group_mean, this_group_err, this_group_err, 'Color', this_group_color, 'MarkerFaceColor', this_group_color, ...
        'LineStyle', '-', 'Marker', 'o');
    
end

end