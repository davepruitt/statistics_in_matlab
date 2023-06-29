function results = RunStats_Matlab_anova ( data, groups, exclude_pre )

%If the user did not specify whether to exclude pre-lesion, then do so now
if (nargin < 3)
    exclude_pre = 1;
end

%Throw out the pre-lesion data for the purposes of this test (if the user has said to do so)
if (exclude_pre)
    data(:, 1) = [];
end

%Create a table to pass to the fitrm function
t = table(groups, data(:, 1), data(:, 2), data(:, 3), data(:, 4), ...
        data(:, 5), data(:, 6), data(:, 7), ...
        'VariableNames', {'Group', 'Wk1','Wk2','Wk3','Wk4','Wk5','Wk6','Wk7'});

timepoints_vector = 1:size(data, 2);
rm = fitrm(t, 'Wk1-Wk7~Group', 'WithinDesign', timepoints_vector);
ranova_tbl = anova(rm);

results = ranova_tbl;


end