map_data = [1 2 3 2 4 8 9 7 10 10 8 8 9 9 10 1 3 3 2 2]'; 
groups = [1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4]';

group_means = [nanmean(map_data(1:5)) nanmean(map_data(6:10)) nanmean(map_data(11:15)) nanmean(map_data(16:20))];
group_err = [   (nanstd(map_data(1:5))   / sqrt(5)) ...
                (nanstd(map_data(6:10))  / sqrt(5)) ...
                (nanstd(map_data(11:15)) / sqrt(5)) ...
                (nanstd(map_data(16:20)) / sqrt(5)) ];


figure;
errorbar(1:4, group_means, group_err, group_err, 'LineStyle', 'none', 'Marker', 'o', 'MarkerFaceColor', 'k', 'Color', 'k');
set(gca, 'XTick', 1:4);
set(gca, 'XTickLabel', {'No VNS', '0.4 mA', '0.8 mA', '1.6 mA'});



total_comparisons = 6;
normal_alpha = 0.05;
bonferroni_corrected_alpha = normal_alpha / total_comparisons;
[h, p] = ttest2(map_data(1:5), map_data(6:10), 'alpha', bonferroni_corrected_alpha)
[h, p] = ttest2(map_data(1:5), map_data(11:15), 'alpha', bonferroni_corrected_alpha)
[h, p] = ttest2(map_data(1:5), map_data(16:20), 'alpha', bonferroni_corrected_alpha)
[h, p] = ttest2(map_data(6:10), map_data(11:15), 'alpha', bonferroni_corrected_alpha)
[h, p] = ttest2(map_data(6:10), map_data(16:20), 'alpha', bonferroni_corrected_alpha)
[h, p] = ttest2(map_data(11:15), map_data(16:20), 'alpha', bonferroni_corrected_alpha)



anova_data = struct('group', {}, 'data', {});
for r = 1:length(map_data)
    anova_data(end+1) = struct('group', groups(r), 'data', map_data(r));
end

dependent_variable = [anova_data.data];
independent_variables = {[anova_data.group]};

[p, table, stats] = anovan(dependent_variable, independent_variables, 'display', 'off', 'model', 'full', ...
    'varnames', {'Group'});


