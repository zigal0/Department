% �������� ������� �1. ����������� ��� �� ���������.
%> @file hw1.m
% ������������ �����: mapping.m (���� ��� ������� ����������� ��� �� ���������).
% �������: �������� �� ��������� ����������� ������� � �������, ����� ��� 
% pskmod, apskmod, qammod,comm.[��� ���������]Modulator � �.�.
% ����������� ���� mapping.m, ��� ������ ��� �������.
% ������ ���� ������ ��� ������������ ����� �������.
% ��������: �� �������� ������ �������� �������� �� ������� �����������
% ������� dec2bin � de2bi. �������, ��� ������� ��� � ������������ 
% ������������������ ������� ������. 
% ��� ����������� ������ ��������� ��������� ������ ��������� �
% ������������ � �������
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
%> �������� ���������
% =========================================================================
% �������� �������������� ������������ ��������� �����������
for constellation = 1:5
    switch (constellation)
        case 1 % BPSK  
            BitInSym = 1;                 % ����������� ��� �� �����
            ConstName = 'BPSK';
            demod = comm.BPSKDemodulator; % ����������� �����������
        case 2 % QPSK
            BitInSym = 2;                 % ����������� ��� �� �����
            ConstName = 'QPSK';
            demod = comm.QPSKDemodulator; % ����������� �����������
        case 3 % 8PSK
            BitInSym = 3;                 % ����������� ��� �� �����
            ConstName = '8PSK';
            demod = comm.PSKDemodulator('ModulationOrder', 8); % ����������� �����������
        case 4 % 16APSK
            BitInSym = 4;
            ConstName = '16APSK';
            % �� ������ 2018� ��� ������������ ������������, ������� ���
            % ���� �������� ���������
        case 5 % 16QAM
            BitInSym = 4;
            ConstName = '16QAM';
    end
%> ��������� ������������ ����� �� ���������
    data = (0:2^BitInSym-1);
    bits = de2bi(data, BitInSym);
    bits = reshape(bits(:,end:-1:1).', 1, []);
    modData = mapping(bits, constellation);
    
    %> ������������
    scatterplot(modData)
    text(real(modData)+0.1, imag(modData), dec2bin(data))
    title(ConstName)
    axis([-2 2 -2 2])
    %> ������� ������� �������� (�������� ����������)
    P = sum(modData.*conj(modData))/length(modData);
    if abs(1-P)>0.00001
        Error = '��������� ���������� ���������'
        ConstName = ConstName
    end
    if constellation < 4
        %> ������������ ����������� �������������
        bits = randi([0 1], 1, 120000); % ��������� ���
        modData = mapping(bits, constellation);
        checkData = demod(modData.');
        checkBits = de2bi(checkData, BitInSym);
        checkBits = reshape(checkBits(:,end:-1:1).', 1, []);
        Nerr = sum(xor(checkBits,bits))
        if Nerr~= 0
            Error = '��������� ���������'
            ConstName = ConstName
        end
    elseif constellation == 5
        %> ������������ ����������� �������������
        bits = randi([0 1], 1, 120000); % ��������� ���
        modData = mapping(bits, constellation);
        norm = sqrt(10);
        modData = norm*modData;
        %modData = qammod(bits, 16);
        checkData = qamdemod(modData.', 16);
        %checkData = qamdemod(modData, 16);%.', 16);
        checkBits = de2bi(checkData, BitInSym);
        checkBits = reshape(checkBits(:,end:-1:1).', 1, []);
        Nerr = sum(xor(checkBits,bits))
        if Nerr~= 0
            Error = '��������� ���������'
            ConstName = ConstName
        end
    end
end

    
