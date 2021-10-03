%% start main script

clc;
clear all;

%% task №1 Logical indexing

arr = 1:100;
Answers = arr((mod(arr, 6) == 0) & (mod(arr,10) ~= 4));

%% task №2 Plot

clc;
clear all;
k = -4 + (4 + 4) * (rand(randi([1, 10]), 1)); %r = a + (b-a)*rand(N,1)
BuildGraphs(k);

%% task №3 Function

clc
clear all;
Answer = decision([132, 0, 1, 0, 1, 0, 1, 0, 8, -1], ...
    [0, 2, 4, 0, 0, 1, 1, 0, 1, 1], [1, 1, 4, 1, 0, 0, 0, 0, -10, -10]);
disp(Answer);

%% task №4 Symbolic math
clc;
clear all;
syms x y;
z = 3 * x^2 - 5 * x * y + 6 * x * y^2;
% pretty(z)
z1 = diff(z, x);
z2 = diff(z1, y);
z2d = matlabFunction(z2);
value = z2d(3);
% intr = double(subs(z2, {x, y}, {2, 3}));
fsurf(z2);
title("z2 = " + string(z2));
ylabel("y");
xlabel("x");
zlabel("z2");

%% Function 2

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