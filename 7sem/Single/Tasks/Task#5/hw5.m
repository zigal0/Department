% ???????? ??????? ?5. ??????????.
%> @file hw5.m
% =========================================================================
%> ?????????? ???????? ?????
% =========================================================================
    %> ???????? workspace
    clear all;
    %> ???????? ????????
    close all;
    %> ???????? Command Window
    clc;
% =========================================================================
%> ??????? sinc. ?????? ?? ??????.
% =========================================================================
    %> ??????? ??????
    x = -10:0.1:10;
    %> ??????? sinc
    y = sinc(x);
    % =====================================================================
    %> ?????? ?????????? ??????????????
    % =====================================================================
    figure 
    plot(x,y)
    title('sinc(x)')
    % =====================================================================
    %> ?????? ???????
    % =====================================================================
    %> ????? + ?????? ? ??
    spector = 10*log10(abs(fft(y)));

    %> ?????? ?? ??????
    spector = [spector(102:201), spector(1:101)];
    %> ?????? ? ?????? T = 2 (??. ???????? sinc)
    figure 
    plot(x / 2, spector)
    title('spector sinc(x)')
% =========================================================================
%> ?????? 1: ???????? ???????, ??????? ?????????? ??????????? (?????????? 
%> ??????????????)??? ??????? ?????? ?? ???????????? ????????.
%> ????????? ?????????? ? ????????? ?????????????? ???????.
% =========================================================================
    %> ????? ??????? ? ???????? (????? ??????? ????????? sinc, ????? ? ???? ??????)
    span = 20;
    %> ????? ??????? ?? ??????
    nsamp  = 4;
    %> ?????????? ??????????? (alfa)
    rolloff = 0.2;
    % =====================================================================
    %> @todo ????????? ???????
    sqimpuls = sqRCcoeff (span, nsamp, rolloff);
    %> @todo ????????? ?????????? ? ????????? ?????????????? ???????
    % .........
    n = span * nsamp + 1;
    figure 
    t = (1 : n) - (n + 1) / 2;
    plot(t, sqimpuls)
    title('sqcos')
    
    spector_sqimpuls = 10 * log10(abs(fft(sqimpuls)));
    spector_sqimpuls = [spector_sqimpuls((n + 1) / 2 + 1 : end), ....
        spector_sqimpuls(1 : (n + 1) / 2)];
    figure 
    plot(t / span, spector_sqimpuls);
    title('spector sqcos')
% =========================================================================
%> ???????? 1.
%> ????????? ?? ??????????? ????????
% =========================================================================
txfilter1 = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
                                           'FilterSpanInSymbols',span,...
                                           'OutputSamplesPerSymbol', nsamp);
chack1 = coeffs(txfilter1);
if sum(abs(chack1.Numerator-sqimpuls))< 0.001 % ???????? ??????????? ???????
                                              % ????? ??????????? ?? ????????
    ans = '???????? ?????? 1 ???????? ???????'
else 
    err = '?????? ? ?????? 1. ????????? ???????????'
    ans = sum(abs(chack1.Numerator-sqimpuls))
end
% =========================================================================
%> ?????? 2: ???????? ???????, ??????? ?????????? ??????????? (?????????? 
%> ??????????????)??? ??????? ???????????? ????????.
%> ????????? ?????????? ? ????????? ?????????????? ???????.
%> ????????? ?????????? ?????????????? ??? ?????, ??? ????? ? ?????????????? sinc 
%> ?? ????? ???????
% =========================================================================
    %> ????? ??????? ? ???????? (????? ??????? ????????? sinc, ????? ? ???? ??????)
    span = 20;
    %> ????? ??????? ?? ??????
    nsamp  = 4;
    %> ?????????? ??????????? (alfa)
    rolloff = 0.2;
    % =====================================================================
    %> @todo ????????? ???????
    impuls = RCcoeff (span, nsamp, rolloff);
    %> @todo g???????? ?????????? ? ????????? ?????????????? ???????
    % ........
    n = span * nsamp + 1;
    figure 
    t = (1 : n) - (n + 1) / 2;
    plot(t, impuls)
    title('cos')
    
    figure
    spector_sqimpuls = 10 * log10(abs(fft(sqimpuls)));
    spector_sqimpuls = [spector_sqimpuls((n + 1) / 2 + 1 : end), ....
        spector_sqimpuls(1 : (n + 1) / 2)];
    plot(t / span, spector_sqimpuls);
    title('spector cos')
    %> ?????????? ?????????????? ??? ?????, ??? ????? ? ?????????????? sinc 
    %> ?? ????? ???????
    figure
    sp_sinc = sinc(t / nsamp) / 2;
    for_t = zeros(1, numel(t));
    plot (t, sp_sinc, t, sqimpuls, t, impuls, t , for_t)
    legend('sinc', 'sqcos', 'cos')
    title('All impulse characteristics')
% =========================================================================
%> ???????? 2.
%> ????????? ?? ??????????? ????????
% =========================================================================
txfilter2 = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
                                            'FilterSpanInSymbols',span,...
                                            'OutputSamplesPerSymbol', nsamp,...
                                            'Shape', 'Normal');
chack2 = coeffs(txfilter2);
if sum(abs(chack2.Numerator-impuls))< 0.1 % ???????? ??????????? ???????
                                          % ????? ??????????? ?? ????????
    ans = '???????? ?????? 2 ???????? ???????'
else 
    err = '?????? ? ?????? 2. ????????? ???????????'
    ans = sum(abs(chack2.Numerator-impuls))
end
% =========================================================================
%> ??????? 3. 
%> ???????? ??????? ??????????, ??????? ???????? ? ???? ???????: ?
%> ??????????? ??????????? ??????? ?? ?????? ? ??? (????????? ??????????)
%> @warning ???????????? ??????? mapping ?? 1 ???????
% =========================================================================
    UpSempFlag = true(1);
    bits = randi([0 1], 1, 1000); % ????????? ???
    sign = mapping (bits, 2);       %QPSK 500 ???????? 
    filtsign = filtration(sign, sqimpuls, nsamp, UpSempFlag);
    % =====================================================================
    %> ???????? 3.1
    %> ????????? ???????????? ?????? ?-?? ? ?????????????????? ?? ???????????? ????????.
    % =====================================================================
    chack3 = txfilter1(sign.').';
    if sum(abs(chack3-filtsign))< 0.1 % ???????? ??????????? ???????
                                      % ????? ??????????? ?? ????????
        ans = '???????? ?????? 3.1 ???????? ???????'
    else 
        err = '?????? ? ?????? 3.1. ????????? ??????'
        ans = sum(abs(chack3-filtsign))
    end
    % =====================================================================
    %> ???????? 3.2
    %> ????????? ???????????? ?????? ?-?? ??? ????????????????? ?? ???????????? ????????.
    % =====================================================================
    UpSempFlag = false(1);
    filtsign2 = filtration(filtsign, sqimpuls, nsamp, UpSempFlag);
    rxfilter = comm.RaisedCosineReceiveFilter('RolloffFactor', rolloff, ...
                                              'FilterSpanInSymbols',span,...
                                              'InputSamplesPerSymbol', nsamp,...
                                              'DecimationFactor', 1);
    chack4 = rxfilter(filtsign.').';
    if sum(abs(chack4-filtsign2))< 0.1 % ???????? ??????????? ???????
                                      % ????? ??????????? ?? ????????
        ans = '???????? ?????? 3.2 ???????? ???????'
    else 
        err = '?????? ? ?????? 3.2. ????????? ??????'
        ans = sum(abs(chack4-filtsign2))
    end