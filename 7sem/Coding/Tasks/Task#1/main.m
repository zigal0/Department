%> Отчистка workspace
clear all;
%> Закрытие рисунков
close all;
%> Отчистка Command Window
clc;

load('strings.mat');

%   Task#1
[alphabetX, probabilitiesX] = alphabet_probabilities(X);
[alphabetY, probabilitiesY] = alphabet_probabilities(Y);

%   Task#2
hX = entropy(X);
hY = entropy(Y);

%   Task#3
cvha = cond_val_entropy(X, Y, 'a');
cvhb = cond_val_entropy(X, Y, 'b');
cvhc = cond_val_entropy(X, Y, 'c');
cvhd = cond_val_entropy(X, Y, 'd');
try
    cvhe = cond_val_entropy(X, Y, 'e');
catch exception
    disp(exception.message)
end

%   Task#4.1
chXY = cond_entropy(X, Y);
chYX = cond_entropy(Y, X);

%   Task#4.2
jh = joint_entropy(X, Y);

%   Addtition for checking
rX = statistical_redundancy(X);
rY = statistical_redundancy(Y);
miXY = mutual_info(X,Y);
miYX = mutual_info(Y,X);

l = length(alphabetX);

% Check equality and inequality
fprintf('H(X|Y){%d} <= H(X){%d} <= log2(L){%d}\n', chXY, hX, log2(l));
fprintf('H(Y|X){%d} <= H(Y){%d} <= log2(L){%d}\n', chYX, hY, log2(l));
fprintf('|I(X,Y) - I(Y,X)| = %d\n', abs(miXY - miYX));
fprintf('|H(X,Y) - (H(X) + H(Y|X))| = %d\n', abs(jh - (hX + chYX)));
fprintf('|H(X,Y) - (H(Y) + H(X|Y))| = %d\n', abs(jh - (hY + chXY)));
