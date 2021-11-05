% ќбратное отображение точек созвезди€
%> @file demapping.m
% =========================================================================
%> @brief ќтображение бит на созвездие
%> @param symbols точки в IQ пространстве
%> @param constellation условное обозначение дл€ типа модул€ции:
%> [1] - BPSK, [2] - QPSK, [3] - 8PSK, [4] - 16APSK, [5] - 16QAM
%> @param softFlag [0] - жесткое решение, [1] - м€гкое решение
%> @param SNR отношение сигнал/шум (необходимо дл€ м€гкого решени€)
%> @return out биты при жестком решении, LLR при м€гком решении
% =========================================================================
function out = demapping (symbols, constellation, softFlag, SNR)
%>todo ћесто дл€ вашего кода
if constellation < 5
    bitInSym = constellation;
else
    bitInSym = 4;
end
data = (0:2 ^ bitInSym - 1);
bitStandard = de2bi(data, bitInSym);
bitStandard = reshape(bitStandard(:, end:-1:1).', 1, []);
valueStandard = mapping(bitStandard, constellation);
if softFlag == 0
    [~, colsIndex] = min(abs(symbols - valueStandard.'), [], 1);
    out = zeros(1, length(symbols) * bitInSym);
    for i = 1:length(symbols)
        start = ((i - 1) * bitInSym) + 1;
        startStandard = ((colsIndex(i) - 1) * bitInSym) + 1;
        out(1, start : (start + bitInSym - 1)) = ...
            bitStandard(startStandard : (startStandard + bitInSym - 1));
    end
else
    signalP = sum(symbols .* conj(symbols)) / length(symbols);
    noiseN0 = signalP / (10^(SNR / 10));
    res = zeros(length(symbols), 4);
    for i = 1:4
        switch i
            case 1
                upValue = valueStandard(real(valueStandard) < 0);
                downValue = valueStandard(real(valueStandard) > 0);
            case 2
                maxReal = max(abs(real(valueStandard)));
                upValue = valueStandard(abs(real(valueStandard)) > maxReal / 2);
                downValue = valueStandard(abs(real(valueStandard)) < maxReal / 2);
            case 3
                upValue = valueStandard(imag(valueStandard) > 0);
                downValue = valueStandard(imag(valueStandard) < 0);
            case 4
                maxImag = max(abs(imag(valueStandard)));
                upValue = valueStandard(abs(imag(valueStandard)) > maxImag / 2);
                downValue = valueStandard(abs(imag(valueStandard)) < maxImag / 2);
        end
        sumUp = sum(exp(-(abs(symbols - upValue.') .^ 2 / noiseN0)));
        sumDown = sum(exp(-(abs(symbols - downValue.') .^ 2 / noiseN0)));
        res(:, i) = log(sumUp ./ sumDown)';
    end
    out = reshape(res', bitInSym * length(symbols), 1);
end
end
