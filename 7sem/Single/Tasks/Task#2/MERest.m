% Вычисление MER 
%> @file MERest.m
% =========================================================================
%> @brief Вычисление MER
%> @param signal идеальный сигнал
%> @param Nsignal зашемленные сигнал
%> @return MER ошибка модуляции в дБ
% =========================================================================
function MER = MERest (signal, Nsignal)
    %>todo Место для вашего кода
    MER = 10 * log10(sum(signal .* conj(signal)) / ...
    sum((signal - Nsignal) .* conj(signal - Nsignal)));
end