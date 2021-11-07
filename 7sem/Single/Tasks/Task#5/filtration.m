% Фильтрация
%> @file filtration.m
% =========================================================================
%> @brief Фильтрация
%> @param sign входной сигнал сигнал
%> @param coeff коэффиценты фильтра
%> @param nsamp число выборок на символ
%> @param UpSempFlag [1] -  фильтр с передескретезацией,[0] - фильтр без передескретизации
%> @return filtsign отфильтрованный сигнал
% =========================================================================
function filtsign = filtration(sign, coeff, nsamp, UpSempFlag)
%> @todo место для вашего кода
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