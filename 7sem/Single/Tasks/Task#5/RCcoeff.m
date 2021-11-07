% Генерация коэффицентов (импульсной характеристики)для фильтра
% приподнятого косинуса
%> @file RCcoeff.m
% =========================================================================
%> @brief Генерация коэффицентов (импульсной характеристики)для фильтра
%> приподнятого косинуса
%> @param span Длина фильтра в символах (число боковых лепестков sinc, сумма
%> с двух сторон)
%> @param nsamp Число выборок на символ
%> @param rolloff Коэффицент сглаживания (alfa)
%> @return coeff коэффиценты для фильтра корень из приподнятого косинуса
% =========================================================================
function coeff = RCcoeff (span, nsamp, rolloff)
%> @todo Место для вашего кода
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