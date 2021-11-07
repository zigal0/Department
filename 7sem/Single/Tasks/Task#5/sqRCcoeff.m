% Генерация коэффицентов (импульсной характеристики)для фильтра корень
% из приподнятого косинуса
%> @file sqRCcoeff.m
% =========================================================================
%> @brief Генерация коэффицентов (импульсной характеристики)для фильтра корень
%> из приподнятого косинуса
%> @param span Длина фильтра в символах (число боковых лепестков sinc, сумма
%> с двух сторон)
%> @param nsamp Число выборок на символ
%> @param rolloff Коэффицент сглаживания (alfa)
%> @return coeff коэффиценты для фильтра корень из приподнятого косинуса
% =========================================================================
function coeff = sqRCcoeff (span, nsamp, rolloff)
%> @todo Место для вашего кода
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