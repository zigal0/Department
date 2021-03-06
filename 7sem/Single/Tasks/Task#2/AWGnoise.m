% ?????????? ??????????? ?????? ???????????? ????
%> @file AWGnoise.m
% =========================================================================
%> @brief ?????????? ??????????? ?????? ???????????? ????
%> @param signal ??????? ??????
%> @param SNR ????????? ?????? ???
%> @param nsamp ??????????? ??????? ?? ???? ?????? ????????
%> @return nsignal ??????????? ??????
%> @warning ???????? ???????? ?? ??, ??? ?????? ?????????????? ? ??????????? ????,
% ??? ????????????? ?? I ? Q ??????????. ???????? ????, ??? ? ????????
% ??????? ???????????? ????????? ????????? I ? Q ?????????.
% =========================================================================
% ??????????? ????????? ??????????? ????????????? normrnd(mu,sigma,[???????]),
% ??? mu ? ???????????, sigma ? ??????????? ??????????.
% =========================================================================
function nsignal = AWGnoise (signal, SNR, nsamp)
%>todo ????? ??? ?????? ????
signalP = sum(signal .* conj(signal)) / length(signal);
noiseN0 = nsamp * signalP / (10^(SNR / 10));
averageAmplWhiteNoise = sqrt(noiseN0 / 2);
noise = averageAmplWhiteNoise * (normrnd(0, 1, size(signal)) + 1j * normrnd(0, 1, size(signal)));;
nsignal = signal + noise;
end
