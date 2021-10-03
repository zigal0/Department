%% start main script

clc;
clear all;

%% task №1 Basic

initial = randi(30,2,9);
complex_data = zeros(1,9);
AMP = zeros(1,9);
Phase = zeros(1,9);
for i = 1 : 9
    complex_data(i) = initial(1,i)/3 + 1j*initial(2,i)/3;
    AMP(i) = abs(complex_data(i));
    Phase(i) = angle(complex_data(i));
end
sub_complex = complex_data(2) - complex_data(5);

% REWORKED
complex_data2 = randi(30, 1, 9) / 3 + 1j * randi(30, 1, 9) / 3;
randi(30, 1, 9)
AMP2 = abs(complex_data2);
Phase2 = angle(complex_data2);
sub_complex2 = complex_data2(2) - complex_data2(5);

%% task №2 Code review

clc;
clear all;

rows = 30;
cols = 30;
Check = zeros(2);

%REWORKED
tic;
% Set to 1 for diagonal elements 
check(1, 1) = toc;
A = zeros(rows, cols);
for m = 1 : cols
    A(m, m)= 1;
end
check(1, 2) = toc;
check(2, 1) = toc;
A1 = eye(rows);
check(2, 2) = toc;
if (A == A1)
    disp ("A == A1");
    disp("Time of A is " + (check(1, 2) - check(1, 1)));
    disp("Time of A1 is " + (check(2, 2) - check(2, 1)));
end

% Taking the cos from the values row 10:25 & column 25:28

B = randi(20, rows, cols);
B1 = B;
check(1, 1) = toc;
for m = 10 : 25
    for n = 25 : 28
        B(m, n)= cos(B(m, n));
    end
end
% Multiplying the values row 1:13 & 14:cols by pi
for m = 1 : 13
    for n = 14 : cols
        B(m, n)= B(m, n)* pi;
    end
end
check(1, 2) = toc;
check(2, 1) = toc;
B1(10 : 25, 25 : 28)= cos(B1(10 : 25, 25 : 28));
B1(1 : 13, 14 : cols) = B1(1 : 13, 14 : cols) * pi;
check(2, 2) = toc;
if (B == B1)
    disp ("B == B1");
    disp("Time of B is " + (check(1, 2) - check(1, 1)));
    disp("Time of B1 is " + (check(2, 2) - check(2, 1)));
end

% Sum of matrices A & B
check(1, 1) = toc;
C = zeros (rows, cols);
for m=1:rows
    for n=1:cols
        C(m,n)=A(m,n)+B(m,n);
    end
end
check(1, 2) = toc;
check(2, 1) = toc;
C1 = A1 + B1;
check(2, 2) = toc;
if (C == C1)
    disp ("C == C1");
    disp("Time of C is " + (check(1, 2) - check(1, 1)));
    disp("Time of C1 is " + (check(2, 2) - check(2, 1)));
end

%% task №3 Cell and Graph

clc;
clear all;

tree = cell({'a', {{{'d', 'e'}, 'c'}, 'b'}});
cellplot(tree);
Path = "2111";
Distant = strlength(Path);
% tree{2}{1}{1}{1}

%% task №4 Struct

clc
clear all;

Grade_MIPT = struct('otl', [10, 9, 8], 'hor', [7, 6, 5], 'ud', [4, 3], 'neud', [2, 1]);
% Grade_MIPT.otl(1)
% Grade_MIPT.hor(3)
% Grade_MIPT.ud(2)
% Grade_MIPT.neud(1)

%% task №5 File

clc
clear all;

fid = fopen('Textvar8.txt', 'r'); % Получаем файловый дескриптор
[A, count] = fread(fid, inf, 'char'); % Читаем текстовый файл в массив
A = char(A); % Преобразуем к букавам
A = lower(A); % Понижаем регистр
Probability = struct('s1', {'щ', 0}, 's2', {'у', 0}, 's3', {'ю', 0}, 's4', {'ы', 0});
% Считаем сколько раз встретились искомые символы
for i = 1:count
    for j = 1:4
        ch = "s" + j;
        if (Probability(1).(ch) == A(i))
            Probability(2).(ch) = Probability(2).(ch) + 1;
            break;
        end
    end
end
% Вычисляем вероятность
for j = 1:4
    ch = "s" + j;
    Probability(2).(ch) = Probability(2).(ch) / count;
end
% Ищем наиболее и наимение вероятные символы
pmax = Probability(2).s1;
pmin = Probability(2).s1;
Answer_1 = Probability(1).s1;
Answer_2 = Probability(1).s1;
for i = 1:4
    ch = "s" + i;
    if (pmax < Probability(2).(ch))
        pmax  = Probability(2).(ch);
        Answer_1 = Probability(1).(ch)
    end
    if (pmin > Probability(2).(ch))
        pmin  = Probability(2).(ch);
        Answer_2 = Probability(1).(ch)
    end
end
% Вывод
Answer_1
Answer_2

%% task №6 File Extra

clc
clear all;

fid = fopen('Textvar8.txt', 'r'); % Получаем файловый дескриптор
[A, count] = fread(fid, inf, 'char'); % Читаем текстовый файл в массив
% REWORKED
max = max(A(:));
A = char(A); % Преобразуем к букавам
A = lower(A); % Понижаем регистр
Cur = zeros(1, max);
% Считаем сколько раз встретились любые символы ( номер столбца
% соответсвует числовому значению char
for i = 1  : count
    Cur(uint16(A(i)))= Cur(uint16(A(i))) + 1;
end
% Вычисляем вероятность
Cur = Cur / count;
% Массив cell, где исключены символы, которые не встречались
k = 0;
% REWORKED
for i = 1 : max
    if (Cur(i) ~= 0)
        k = k + 1;
        Pro{k} = {char(i), Cur(i)};
    end
end
% Поиск наиболее и наимение вероятных символов + создание структурки
pmax = Pro{1}{2};
pmin = Pro{1}{2};
Answer_1 = Pro{1}{1};
Answer_2 = Pro{1}{1};
for i = 1 : k
    ch = "s" + i;
    Probability.(ch) = Pro{i};
    if (pmax < Pro{i}{2})
        pmax  = Pro{i}{2};
        Answer_1 = Pro{i}{1};
    end
    if (pmin > Pro{i}{2})
        pmin  = Pro{i}{2};
        Answer_2 = Pro{i}{1};
    end
end
% Вывод ответа
Answer_1
Answer_2
Pro{1}{1}
Pro{2}{1}


    