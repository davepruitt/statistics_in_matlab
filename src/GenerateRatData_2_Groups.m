function [ data, group_assignments ] = GenerateRatData_2_Groups ( ng1, ng2 )
    %Generates a matrix with 2 groups of data over multiple epochs
    %Pass two parameters into this function - each being the size of the respective group
    
    total_rats = ng1 + ng2;
    
    rng('default');
    rng(1);
    
    pre_data = randi([85 95], total_rats, 1);
    post_data = randi([20 40], total_rats, 1);
    
    g1_mean = [50 65 70 80 85 85];
    g2_mean = [40 45 50 50 55 55];
    
    for w = 1:6
        min_value_g1 = g1_mean(w) - 10;
        max_value_g1 = g1_mean(w) + 10;
        min_value_g2 = g2_mean(w) - 10;
        max_value_g2 = g2_mean(w) + 10;
        therapy_g1 = randi([min_value_g1 max_value_g1], ng1, 1);
        therapy_g2 = randi([min_value_g2 max_value_g2], ng2, 1);
        therapy(:, w) = [therapy_g1; therapy_g2];
    end
    
    data = [pre_data post_data therapy];
    
    group_assignments = ones(total_rats, 1);
    group_assignments((ng2+1):end, 1) = group_assignments((ng2+1):end, 1) + 1;
end