% �������� ������� �3. �������� ����������� ������� �� ���������, ������� � ������ �������.
%> @file hw3.m
% ������������ �����: mapping.m (���������� ���� ������� ����������� ��� �� ���������)
%                     AWGnoise.m(���������� ���� ������� ���������� ����)
%                     Nerr.m    (���������� ���� ������� ���������� ����)
% �������:
% �������� ������� ��������� ����������� ��� �� ��������� demapping.m
% ��������� ���������� �������������� ��� ������� �������
% �� 10^(-5) ��� ���� ���������, �������� � ����������.
% ��������� ���������� �������������� �� 10^(-5), ��� ������� ������� ���
% LDPC �����������. �������� � ��������������� ��� ����������� ��� QPSK
%> @warning ����� 1.2 2.2 - ������� �������� ����������� ��������������
%> �������� (�� ����������� � ����������)
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
%> ������� 1. ������� �������
% =========================================================================
for constellation = 1:5
    % ����� ���������
    switch (constellation)
        case 1 % BPSK
            BitInSym = 1;                 % ����������� ��� �� �����
            ConstName = 'BPSK';
            SNR = (1:11);                 % Es/No ��
        case 2 % QPSK
            BitInSym = 2;                 % ����������� ��� �� �����
            ConstName = 'QPSK';
            SNR = (4:14);
        case 3 % 8PSK
            BitInSym = 3;                 % ����������� ��� �� �����
            ConstName = '8PSK';
            SNR = (8:18);
        case 4 % 16APSK
            BitInSym = 4;
            ConstName = '16APSK';
            SNR = (11:21);
        case 5 % 16QAM
            BitInSym = 4;
            ConstName = '16QAM';
            SNR = (11:21);
    end
    % =====================================================================
    %> �������� 1.1 ��� ����
    % =====================================================================
    bits = randi([0 1], 1, 120000); % ��������� ���
    modData = mapping(bits, constellation); % ���������
    %> ������� ������� �� ����� ��������
    checkBits = demapping (modData, constellation, 0);
    ERR = Nerr (bits, checkBits)
    if ERR == 0
        ans = '�������� 1.1 - �����'
        ConstName = ConstName
    else
        ans = '�������� 1.1 - ������'
        ConstName = ConstName
    end
    %     % =====================================================================
    %     %> �������� 1.2 ���������� ��������������
    %     % =====================================================================
    %     % ��������: ����� ��������� �������� �����!!!
    BER = [];
    for i = 1:length(SNR)
        N = 3000000; % ����� ���, ���� ������ ������� ����� - �������.
        bits = randi([0 1], 1, N); % ��������� ���
        modData = mapping(bits, constellation); % ���������
        nsignal = AWGnoise (modData, SNR(i), 1); % �������, ���������� ���� � hw2
        checkBits = demapping (nsignal, constellation, 0);
        ERR = Nerr (bits, checkBits)
        BER = [BER, ERR/N];
    end
    f = figure;
    semilogy(SNR, BER, 'r^-')
    hold on
    semilogy(SNR-10*log10(BitInSym), BER, 'bo-')
    grid on
    title(ConstName)
    xlabel('EbNo(dB)/EsNo(dB)')
    ylabel('BER')
    %> ��������� ���������� �����������
    ConstName = [ConstName,'.fig'];
    savefig(f,ConstName);
end
% =========================================================================
%> �������� 2.1 ������ �������
% =========================================================================
%> �������� ������� � ������ ��������
%> ����������� LDPC ��� ��� �������� ����� (�������� ����� 64800 ���)
%> ��������� DVB-S2 ������� �������� 1/2, ������������ ����������
%> �������� 50
LDPCenc = comm.LDPCEncoder; %> ������������� ������
LDPCdec = comm.LDPCDecoder; %> ������������� ��������
N = 32400; % ����� ��� (�� ������� ������� LDPC ����)
bits = randi([0 1], N, 1); % ��������� ���
LDPCcod = LDPCenc(bits); % �����������
modData = mapping(LDPCcod.', 5); % ���������
nsignal = AWGnoise (modData, 7, 1); % �������, ���������� ���� � hw2
LLR = demapping(nsignal, 5, 1, 7); % ������ �������
checkBits =  LDPCdec(LLR);
ERR = Nerr (bits, checkBits);
if ERR == 0
    ans = '�������� 2.1 - �����'
else
    ans = '�������� 2.1 - ������'
end
% =====================================================================
%> �������� 2.2 - ������ �������
% =====================================================================
BER = [];
SNR = [5:0.05:7];
for i = 1:length(SNR) % �������� ��������� SNR
    Ne = 0;
    for frame = 1:300 % ����� ����� ����
        bits = randi([0 1], N, 1); % ��������� ���
        LDPCcod = LDPCenc(bits); % �����������
        modData = mapping(LDPCcod.', 5); % ���������
        nsignal = AWGnoise (modData, SNR(i), 1); % �������, ���������� ���� � hw2
        LLR = demapping (nsignal, 5, 1, SNR(i)); % ������ �������
        checkBits =  LDPCdec(LLR);
        ERR = Nerr (bits, checkBits);
        Ne = Ne+ERR
    end
    BER = [BER, Ne/(N*frame)];
end
f = figure;
semilogy(SNR, BER, 'r^-')
hold on
semilogy(SNR-10*log10(2/2), BER, 'bo-')
grid on
title('QPSK LDPC 1/2')
xlabel('EbNo(dB)/EsNo(dB)')
ylabel('BER')
%> ��������� ���������� �����������
ConstName = ['QPSK_LDPC.fig'];
savefig(f,ConstName);



