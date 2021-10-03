clc;
clear all;

t = linspace(0, 10); % временной диапазон
f = 1000; % частотный диапазон
Signal_clear = sin(5*t);
Signal = sin(5*t)+randn(size(t));
freq = (0:length(t)-1)*(f/length(t));
TransformSig = fft(Signal);
TransformSig(length(t)+1:end) = [];
plot(t, Signal);
xlabel('Time (sec)');
ylabel('Amplitude');
hold on
figure
plot(freq, real(TransformSig));
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on
%hold on
Svertka = conv(Signal_clear, Signal); % свертка
time_svert = linspace(0, 19.9, 199);
figure
plot(time_svert, Svertka);
xlabel('Time (sec)');
ylabel('Amplitude');
grid on
%hold on
BaseSig = ifft(TransformSig);
StartSig = deconv (Svertka, Signal); % обратная свертке операция
Noise = wgn(1, 100, 30, 'dBW');
close all