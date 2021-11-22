% �������� ������� �8. ��������� ��������������.
%> @file hw8.m
%> ����������� �������: mapping.m, AWGnoise.m
% =========================================================================
%> ���������� �������� �����
% =========================================================================
    %> �������� workspace
    clear all;
    %> �������� ��������
    close all;
    %> �������� Command Window
    clc;
% =========================================================================
% �������: �������� ������� ��������� �������������
% =========================================================================
N = 2 * 90 * 16 * 300;
bits = randi([0 1], N, 1); % ��������� ���
modData = mapping(bits, 2); % ���������
% ��������� ������
pilots(1:36) = exp(sqrt(-1)*pi/4);
step = 90*16;
leng = length(modData);
pmodData = [];
for i = 1:step:leng
    pmodData = [pmodData, pilots, modData(i:i+step-1)];
end
SNR = 20;
nsignal = AWGnoise (pmodData, SNR, 1); % �������, ���������� ���� � hw2
scatterplot(nsignal)
freqoff = 0.0005%*rand(1) % ��������������� ��������� ����� o� 0 �� 1
phaseoff = 2*pi*rand(1);
%> ��������� ����� <=> �������
leng = length(nsignal);
nsignal = nsignal.*exp(sqrt(-1)*(2*pi*[1:leng]*freqoff+phaseoff));
freqoff = 0.01; % ��������������� ��������� �����
scatterplot(nsignal)
symbols = foff (nsignal, step, pilots);
scatterplot(symbols)
mer = comm.MER;
MER = mer(modData.', symbols.')
if abs (MER-SNR)>3
    '��������� �������'
end
