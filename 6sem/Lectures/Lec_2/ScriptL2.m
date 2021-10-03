clc;
clear all;

%% ���������� ����������

clc;
clear all;
A = randi(10, 4, 5);
B = (A>6); % ���������� ���������� ������ �������� ��� ������� �
C = A(A>6); % ���������� ������-������� �� ���������, ��������������� �������
clear A B C

x = linspace(1, 10, 91);
y = cos(x);
y(y<0) = 0; % ����������� �������� 0 ���� ��������� ������ 0 � ������� y
y(x<2.5)=x(x<2.5);
clear x y

a = ones(10); % ������� 10�10
b = a([1,1,4], 2:2:end);
clear a b

% ������� find
x = 3:9;
ind = find(x>6); % (x>6) = [0,0,0,0,1,1,1]; 
a = [5,6,7; 8,9,10; 11,12,13];
b = find(a>8);
[i,j] = find(a>8); % i = [3;2;3;2;3]; j = [1;2;2;3;3];
k = a(2);
l = a(4);
Linear_a = a(:);
d_arr = randi(10, 3, 4, 5);
d_linear = d_arr(:);

%% �������

clc;
clear all;

x = linspace(-10,10,500);
c = 4;
data_0 = x.^2 + c;

plot(x,data_0);

data_1 = x.^3 + c;
data_2 = x.^4 + c;
subplot(2, 1, 1), plot(x, data_1);
subplot(2, 1, 2), plot(x, data_2);

Data = [data_0; data_1; data_2]; % united plots

plot(x, Data.');
hold on;
extra_data = x;
plot(extra_data);

xlim([-5,10]) % �������

ylim([-2,6]) % �������

grid on;

legend("data 0", "data 1", "data 2", "data extra")

title("Test name");

close all;


%% �������

% ��������� �������
clc;
clear all;
powers = @(x, y) x.^y;
array1 = [3, 5, 6];
array2 = [4, 2, 2];
array3 = powers(array1, array2);

% m-�������, ��������� ������� � ����������

clear all;
array1 = randi(10, 1, 100);
[elementsmore5, disp] = dispersion (array1);
disp
elementsmore5


%% ������������ ���������� ��������� �������

%% ������� ����

% ��������, � ��� ������� ������� ���������
% x + 2y + 3z = 4
% 3x - 5y + 1z = -13
% x + 3y - 2z = 12
% ����� � � ������� ���������� Matlab

clc;
clear all;

A = [ 1, 2, 3; 3, -5, 1; 1, 3, -2];
% A_virozhd = [ 1, 2, 3; 1, 2, 3; 1, 3, -2]; % ������ ������ � �����������
% ��������
b = [4; -13; 12];
Decision1 = A\b; % ���������� Decision = A^(-1)*b
% Decision_united_vrzd = A_virozhd\b; % ������ � ������������ ���������

% ��������, � ������ ����� � ��� ����� ������ ��������. ��� ��� ���� �����
% ���������� ������� �� 1 ��������, ��������� �������� � ���� �������
b1 = [ 9; -3; 6];
b2 = [ 10; 0; 7];
b3 = [ 3; -10; -1];
b_united = [b1, b2, b3];
Decision_united = A\b_united;


% ������� ���������� ���������
clear all;
f = @(x)x.^2-2 % �������, ���� ������� ���������� �����, ������� ����� ��������� @
x0 = fzero (f, 1.4); % ��������� ����������� ������� - 1.4, ����� �������� ������ � �����������, ��� �������� ���� � ����� �����
x1 = fsolve (f, 1.4);

clc;
clear all;
a = 3;
f = @(x)TestEquation(x, a);
x0 = fsolve(f, 1.5);

%% ��������� �������������� � �����������������

% ��������������
clc;
clear all;
f = @(x) 0.25*x.^3-(1/3)*x.^2
f1 = @(x) exp(-x.^2);
test = integral(f1, 0, Inf);
int_f = integral(f, -5, 5);
%int_f2 = polyint(f);
int_f_appr = integral(f1, 0, 5, 'RelTol', 0, 'AbsTol', 1e-12);

% �����������������

step = 0.01;
x = 0:step:pi;
y = cos(x);
y2 = 4*x.^2 - 5;
dy_dx = gradient(y, step);
% dy_dx2 = polyder(y2);

%% ������� ���������������� ���������

% ���������� ����. ��������� y''+y'+y = sin(3t)
% ��������� ������� y(0) = 0, y'(0) = 0
% ����� �����-�����
% ������� ��������� � ����, ����������� ������ ������ �����������:
% y1'(t)= y2
% y2'(t)= sin(3t)-y1(t)-y2(t)
% y1(t) - �������� �������, y2(t)= dy1(t)/dt - ���������������
clc;
clear all;
y0 = [0, 0];
tspan = [0, 30];
[t, y] = ode45(@odefcn, tspan, y0);
plot (t, y(:,1));
solution = ode45(@odefcn, tspan, y0);
t = linspace(0, 30, 1000);
y = deval(solution, t); % ���������� �������� y � ����������� ������

%% ������������ � �������������

% ������������
clc;
clear all;
xt = 0:10; % ���������� ������� ������
yt = cos(xt); % ���������� ������� ������
x = linspace(0,10); % �����, � ������� ����������� ��������
y = interp1(xt, yt, x, 'spline');

% �������������
x = linspace(0,3);
y = cos(x) + 0.4*randn(size(x)); % ���������� ������
p = polyfit(x,y,4); % ������������� ��������� 4 �������
ya = polyval(p,x); % ��������� �������������

clear all;

x = linspace(0,3);
y = sin(x) + 0.3*randn(size(x));
y1 = ones(size(x));
y2 = exp(-x);
y3 = x;
M = [y1.', y2.', y3.'];
a = M\y.';
ya = a(1)*y1+a(2)*y2+a(3)*y3; % ��������� �������������

%% ���������� ��������

clc;
clear all;
syms x y
z = x.^2*y + cos(x);
a = diff(x^3); % ����������������� 
b = diff(z,y); % ����������������� �� �
c = int(x^2); % ��������������
d = int(x^2, 0, 1); % �������������� �� 0 �� 1 �� �
e = int(z, y, 0, 1); % �������������� �� 0 �� 1 �� �
f = int(1/x, 0, Inf); % �������� ����� �������������

doubld = double(d); % ��������� ���������, ���������� �� ����������, ����� ������������� � �����
zf = matlabFunction(z); % ���������� �������� � ��������� ����������� � ���� double
value = zf(1, 2);
pretty(z)

% close all


function dydt = odefcn(t, y)
dydt = zeros(2,1);
dydt(1)= y(2);
dydt(2)= -y(1)-y(2)+sin(3*t);
end
