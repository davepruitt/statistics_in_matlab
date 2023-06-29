x_values = (randi([1 100], 40, 1));
y_values = nan(40, 1);

for i = 1:40
    y_values(i) = x_values(i) + ((rand - 0.5) * (200 * rand)) + 10;
end

y_values = y_values + (abs(min(y_values)) * 2);
y_values = (y_values ./ (max(y_values)+10)) * 100;
x_values = x_values ./ 10;

ylim([0 100]);

plot(x_values, y_values, 'Marker', 'o', 'LineStyle', 'none', 'MarkerFaceColor', 'k', 'Color', 'k');
ylabel('Pull task performance');
xlabel('Forelimb motor map area (mm^2)');