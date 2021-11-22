% ¬остановление несущей
%> @file foff.m
% =========================================================================
%> @brief ¬остановление несущей
%> @param fsymbols символы сигнала с частотным и фазовым сдвигом сдвигов с
%> с пилотами
%> @param step расто€ние между пилотными символами
%> @param pilots пилотные символы
%> @return symbols символы сигнала без частотного, фазового сдвига, пилотов
% =========================================================================
function symbols = foff (fsymbols, step, pilots)
% =========================================================================
len_pilots = numel(pilots);
num_blocks = numel(fsymbols) / (step + len_pilots);
modified_pilots = zeros(num_blocks, len_pilots);
big_step = step + len_pilots;
% частота
for i = 1 : num_blocks
    cur_pos = (i - 1) * (big_step) + 1;
    modified_pilots(i, :) = fsymbols(cur_pos : cur_pos + len_pilots - 1);
end
no_info_pilots = modified_pilots .* conj(pilots);
n = len_pilots / 2;
autocorr = zeros(1, n);
for i = 1 : n
    for j = i + 1 : len_pilots
        autocorr(i) = autocorr(i) + sum(no_info_pilots(: , j) ...
            .* conj(no_info_pilots(: , j - i)));
    end
end

freqoff = 1 / (pi * n * (n + 1)) * sum(angle(autocorr));
fsymbols = fsymbols ./ exp(sqrt(-1) * (2 * pi) ...
    * (1 : numel(fsymbols)) * freqoff);
% фаза
symbols = zeros(1, num_blocks * step);
for i = 1 : num_blocks
    pos_for_pilots = (i - 1) * (big_step) + 1;
    modified_pilots_new = fsymbols(pos_for_pilots : pos_for_pilots ... 
        + len_pilots - 1);
    no_info_pilots_new = modified_pilots_new .* conj(pilots);
    fsymbols = fsymbols ./ exp(sqrt(-1)*(angle(sum(no_info_pilots_new))));
    
    cur_pos = (i - 1) * step + 1;
    symbols(cur_pos : cur_pos + step - 1) = fsymbols(pos_for_pilots ...
        + len_pilots : pos_for_pilots + big_step - 1);
end
end