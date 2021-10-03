% ���������� MER 
%> @file MERest.m
% =========================================================================
%> @brief ���������� MER
%> @param signal ��������� ������
%> @param Nsignal ����������� ������
%> @return MER ������ ��������� � ��
% =========================================================================
function MER = MERest (signal, Nsignal)
    %>todo ����� ��� ������ ����
    MER = 10 * log10(sum(signal .* conj(signal)) / ...
    sum((signal - Nsignal) .* conj(signal - Nsignal)));
end