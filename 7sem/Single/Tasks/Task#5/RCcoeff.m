% ��������� ������������ (���������� ��������������)��� �������
% ������������ ��������
%> @file RCcoeff.m
% =========================================================================
%> @brief ��������� ������������ (���������� ��������������)��� �������
%> ������������ ��������
%> @param span ����� ������� � �������� (����� ������� ��������� sinc, �����
%> � ���� ������)
%> @param nsamp ����� ������� �� ������
%> @param rolloff ���������� ����������� (alfa)
%> @return coeff ����������� ��� ������� ������ �� ������������ ��������
% =========================================================================
function coeff = RCcoeff (span, nsamp, rolloff)
%> @todo ����� ��� ������ ����
coeff = zeros(1, span * nsamp + 1);
for t = - span * nsamp / 2 : span * nsamp / 2
    i = t + span * nsamp / 2 + 1;
    if t == 0
        coeff(i) = 1;
    elseif abs(t) == nsamp / (2 * rolloff)
        coeff(i) = rolloff * sin(pi / (2 * rolloff)) / 2;
    else
        coeff(i) = sin(pi * t / nsamp) * cos (pi * rolloff * t / nsamp) ...
            / (pi * t / nsamp * (1 - (2 * rolloff * t / nsamp) ^ 2));
    end
end
coeff = coeff ./ sqrt(nsamp);
end