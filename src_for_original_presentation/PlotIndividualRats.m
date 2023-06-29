function PlotIndividualRats ( data, groups )

figure;
hold on;

colors = colormap(lines);

temp_color_2 = colors(1, :);
colors(1, :) = colors(2, :);
colors(2, :) = temp_color_2;

for r = 1:size(data, 1)
    
    this_rat_color = colors(groups(r), :);
    x_vals = 1:size(data, 2);
    plot(x_vals, data(r, :), 'Color', this_rat_color, 'MarkerFaceColor', this_rat_color, 'LineStyle', '-', ...
        'Marker', 'o');
    
end

end