function results = RunStats_Matlab_anovan_incorrect ( data, groups )

% This example is incorrect because "time" should be a paired variable. In other words, timepoint 2 depends on timepoint 1
% This example, however, runs the test as if everything was "unpaired".
% If this were simply 2 independent variables that were not paired in any way, such as "lesion type" and "vns +/-", then this
% example would be fine. However, this example does not work for repeated measures.

anova_data = struct('group', {}, 'timepoint', {}, 'data', {});

for r = 1:size(data, 1)
    for t = 1:size(data, 2)
        anova_data(end+1) = struct('group', groups(r), 'timepoint', t, 'data', data(r, t));
    end
end

dependent_variable = [anova_data.data];
independent_variables = {[anova_data.group] [anova_data.timepoint]};

[p, table, stats] = anovan(dependent_variable, independent_variables, 'display', 'off', 'model', 'full', ...
    'varnames', {'Group', 'Time'});

results = table;

end