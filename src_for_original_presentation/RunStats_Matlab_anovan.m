function results = RunStats_Matlab_anovan ( data, groups )

%anova_data = struct('subject', {}, 'group', {}, 'timepoint', {}, 'data', {});
anova_data = struct('group', {}, 'timepoint', {}, 'data', {});

for r = 1:size(data, 1)
    for t = 1:size(data, 2)
        %anova_data(end+1) = struct('subject', r, 'group', groups(r), 'timepoint', t, 'data', data(r, t));
        anova_data(end+1) = struct('group', groups(r), 'timepoint', t, 'data', data(r, t));
    end
end

dependent_variable = [anova_data.data];
%independent_variables = {[anova_data.subject] [anova_data.group] [anova_data.timepoint]};
independent_variables = {[anova_data.group] [anova_data.timepoint]};

nested_matrix = [0 0; 1 0];

[p, table, stats] = anovan(dependent_variable, independent_variables, ...
    'random', 1, ...
    'nested', nested_matrix, ...
    'display', 'off', ...
    'model', 'full', ...
    'varnames', {'Group', 'Time'});

results = table;

end