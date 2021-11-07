% ��������� ������������ (���������� ��������������)��� ������� ������
% �� ������������ ��������
%> @file sqRCcoeff.m
% =========================================================================
%> @brief ��������� ������������ (���������� ��������������)��� ������� ������
%> �� ������������ ��������
%> @param span ����� ������� � �������� (����� ������� ��������� sinc, �����
%> � ���� ������)
%> @param nsamp ����� ������� �� ������
%> @param rolloff ���������� ����������� (alfa)
%> @return coeff ����������� ��� ������� ������ �� ������������ ��������
% =========================================================================
function coeff = sqRCcoeff (span, nsamp, rolloff)
%> @todo ����� ��� ������ ����
coeff = zeros(1, span * nsamp + 1);
for t = - span * nsamp / 2 : span * nsamp / 2
    i = t + span * nsamp / 2 + 1;
    if t == 0
        coeff(i) = (1 - rolloff + 4 * rolloff / pi);
    elseif abs(t) == nsamp / (4 * rolloff)
        coeff(i) = rolloff * ((1 + 2 / pi) * sin(pi / (4 * rolloff)) ...
            + (1 - 2 / pi) * cos(pi / (4 * rolloff))) / sqrt(2);
    else
        coeff(i) = (sin(pi * t * (1 - rolloff) / nsamp) + 4 * rolloff ...
            * t * cos(pi * t * (1 + rolloff) / nsamp) / nsamp) / ...
            (pi * t * (1 - (4 * rolloff * t / nsamp) ^ 2) / nsamp);
    end
end
coeff = coeff ./ sqrt(nsamp);
end