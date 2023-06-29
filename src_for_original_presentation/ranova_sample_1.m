%Make copies of our variables to use for this code
data = d;
groups = g;

%Exclude pre-lesion data. It won't be used in this statistical test.
data(:, 1) = [];

%Create a table to pass to the fitrm function
t = table(groups(:, 1), groups(:, 2), data(:, 1), data(:, 2), data(:, 3), data(:, 4), ...
        data(:, 5), data(:, 6), data(:, 7), ...
        'VariableNames', {'LesionType', 'VNS', 'Wk1','Wk2','Wk3','Wk4','Wk5','Wk6','Wk7'});

timepoints_vector = 1:size(data, 2);
rm = fitrm(t, 'Wk1-Wk7~LesionType+VNS', 'WithinDesign', timepoints_vector);

%This test will tell you effects of time and group*time
ranova_tbl = ranova(rm);

%This test will tell you effects of group
anova_tbl = anova(rm);




