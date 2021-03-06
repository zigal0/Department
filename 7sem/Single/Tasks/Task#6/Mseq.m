% ????????? ?-??????????????????
%> @file Mseq.m
% =========================================================================
%> @brief ????????? ?-??????????????????
%> @return seq ?-?????????????????? (????)
% =========================================================================
function [seq] = Mseq()
% ???????? ????????? m-?????????????????? 63 (6, 5). ????????? ????????? ?????? {1, 0, 0, 0, 0,0}.
seq = zeros(1, 63);
buff = [1 0 0 0 0 0];
for i = 1 : 63
    new_value = mod(buff(5) + buff(6), 2);
    seq(i) = new_value;
    buff = [new_value, buff(1 : end - 1)];
end
end