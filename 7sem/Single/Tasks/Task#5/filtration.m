% ����������
%> @file filtration.m
% =========================================================================
%> @brief ����������
%> @param sign ������� ������ ������
%> @param coeff ����������� �������
%> @param nsamp ����� ������� �� ������
%> @param UpSempFlag [1] -  ������ � ������������������,[0] - ������ ��� �����������������
%> @return filtsign ��������������� ������
% =========================================================================
function filtsign = filtration(sign, coeff, nsamp, UpSempFlag)
%> @todo ����� ��� ������ ����
if UpSempFlag  == true(1)
    sign = reshape([sign.', zeros(numel(sign), nsamp - 1)].', 1, []);
end
coeff_size = numel(coeff);
filtsign = zeros(1, numel(sign));
buff = zeros(1, coeff_size);

for i = 1 : numel(sign)
    buff = [buff(2 : coeff_size), sign(i)];
    filtsign(i) = sum (buff .* coeff);
end

end