% ����������� ��� �� ��������
%> @file mapping.m
% =========================================================================
%> @brief ����������� ��� �� ���������
%> @param bits ����, ������������ �� ��������� (������ ���� ������ ����� ���
%> �� ����� ���������)
%> @param constellation �������� ����������� ��� ���� ���������:
%> [1] - BPSK, [2] - QPSK, [3] - 8PSK, [4] - 16APSK, [5] - 16QAM
%> @return symbols ����� � IQ ������������
%> @warning ��������� ������ ���� ������������ �� �������� �� 1.
%> ������������ ����� ��������� ������ ��������� � �������� � �������.
%> ��������� ��� ���������� ����� ����� �������, ��� bi2de � reshape
% =========================================================================
function symbols = mapping (bits, constellation)
if constellation == 5
    numberOfPoints = 2 ^ 4;
else
    numberOfPoints = 2 ^ constellation;
end
switch constellation
    case 1
        bitsOrder = [
            0;
            1;
            ];
        bitsValue = makeCircle(numberOfPoints);
    case 2
        bitsOrder = [
            0, 0;
            0, 1;
            1, 1;
            1, 0
            ];
        bitsValue = makeCircle(numberOfPoints);
    case 3
        bitsOrder = [
            0, 0, 0;
            0, 0, 1;
            0, 1, 1;
            0, 1, 0;
            1, 1, 0;
            1, 1, 1;
            1, 0, 1;
            1, 0, 0
            ];
        bitsValue = makeCircle(numberOfPoints);
    case 4
        bitsOrder = [
            0, 1, 0, 0;
            0, 0, 0, 0;
            1, 0, 0, 0;
            1, 0, 1, 0;
            0, 0, 1, 0;
            0, 1, 1, 0;
            0, 1, 1, 1;
            0, 0, 1, 1;
            1, 0, 1, 1;
            1, 0, 0, 1;
            0, 0, 0, 1;
            0, 1, 0, 1;
            1, 1, 0, 0;
            1, 1, 1, 0;
            1, 1, 1, 1;
            1, 1, 0, 1
            ];
        bitsValue = makeCircle(12);
        bitsValue = cat(1, bitsValue, makeCircle(4) / 2);
        bitsValue = normilize(bitsValue);
    case 5
        bitsOrder = [
            1, 1, 0, 1;
            0, 1, 0, 1;
            0, 1, 1, 1;
            1, 1, 1, 1;
            1, 0, 0, 1;
            1, 1, 0, 0;
            0, 1, 0, 0;
            0, 0, 0, 1;
            0, 0, 1, 1;
            0, 1, 1, 0;
            1, 1, 1, 0;
            1, 0, 1, 1;
            1, 0, 0, 0;
            0, 0, 0, 0;
            0, 0, 1, 0;
            1, 0, 1, 0
            ];
        bitsValue = makeCircle(4) * sqrt(2);
        innerCircle = [
            3 + 1j; 1 + 3j; 
            -1 + 3j; -3 + 1j; 
            -3 - 1j; -1 - 3j;
            1 - 3j; 3 - 1j
            ];
         bitsValue = cat(1, bitsValue, innerCircle);
         bitsValue = cat(1, bitsValue, sqrt(18) * makeCircle(4));
         bitsValue = normilize(bitsValue);
    otherwise
        disp('Error');
end

if constellation == 5
    constellation = 4;
end

bits = reshape(bits(:,:).', constellation, [])';
[rows, ~] = size(bits);
symbols = zeros(1, rows);
for k = 1:rows
    for t = 1:numberOfPoints
        if bits(k,:) == bitsOrder(t, :)
            symbols(k) = bitsValue(t);
            break;
        end
    end
end

end