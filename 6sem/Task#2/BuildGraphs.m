function BuildGraphs(k)
fig = figure;
x = 0.01 : 0.01 : 10;
y = k .* cos(2 * x);
plot(x, y, 'Linewidth', 1);

xlim([3.5, 5.5]); 
ylim([-4, 4]);
xlabel x;
ylabel y;
grid on;
title("y = k * cos(2x)");
legend_arr = strings(size(k));
for i = 1 : size(k)
    legend_arr(i) = "Line " + i + " - k = " + k(i);
end
lgd = legend(legend_arr, 'Location', 'eastoutside');
title(lgd,'Legends');
set(gca, 'FontSize', 11);
savefig('plot');
exportgraphics(fig,'plot.png','Resolution', 300);
end

