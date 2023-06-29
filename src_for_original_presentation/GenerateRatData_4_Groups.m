function [ data, group_assignments ] = GenerateRatData_4_Groups ( ng_array )
%Generates 4 groups of data. Pass in an array where each element is the size of the respective group.

if (length(ng_array) ~= 4)
    data = [];
    group_assignments = [];
    return;
end

total_rats = sum(ng_array);
pre_data = randi([85 95], total_rats, 1);
post_data = randi([20 40], total_rats, 1);

g_means = [ 50 65 70 80 85 85; ...
            45 60 65 70 75 75; ...
            45 50 55 60 65 65; ...
            40 45 50 50 55 55];

therapy = [];
        
for w = 1:6
    therapy_this_week = [];
    for g = 1:size(g_means, 1)
        min_g = g_means(g, w) - 10;
        max_g = g_means(g, w) + 10;
        therapy_g = randi([min_g, max_g], ng_array(g), 1);
        therapy_this_week = [therapy_this_week; therapy_g];
    end
    
    therapy = [therapy therapy_this_week];
    
end

data = [pre_data post_data therapy];

group_assignments = [];
for g = 1:size(g_means, 1)
    this_group_assignments = ones(ng_array(g), 1) + (g - 1);
    group_assignments = [group_assignments; this_group_assignments];
end

end