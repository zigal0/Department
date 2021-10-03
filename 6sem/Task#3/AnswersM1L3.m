%% start main script
clc;
clear all;

%% task №1 Fourier transform

dim = 128;
Harmonics = zeros(1, dim);
Harmonics(5) = 1;
Harmonics(10) = 2;
Harmonics(60) = 3;

Signal = ifft(Harmonics, dim);
t = linspace(0, 10, dim);
subplot(3, 1, 1), plot(t, abs(Signal));
title("Signal");
xlabel("Time");
ylabel("Amplitude");
hold on;

%% task №2 Noise generation

SNR = 37;
NoisedSignal = NoiseGenerator(SNR, Signal);
subplot(3, 1, 2), plot(t, abs(NoisedSignal));
Noise = NoisedSignal - Signal;
SNR_RES = snr(Signal, Noise);
title("NoisedSignal & SNR = " + SNR_RES);
xlabel("Time");
ylabel("Amplitude");

%% task №3 Powers of signals

Noise = NoisedSignal - Signal;
P_Signal = PowerSignal(Signal);
P_Noise = PowerSignal(Noise);
P_NoisedSignal = PowerSignal(NoisedSignal);

%% task №4 Parseval theorem

e = 0.001;

SignalSpec = fft(Signal);
NoiseSpec = fft(Noise);
NoisedSignalSpec = fft(NoisedSignal);

P_SignalSpec = PowerSignal(SignalSpec);
P_NoiseSpec = PowerSignal(NoiseSpec);
P_NoisedSignalSpec = PowerSignal(NoisedSignalSpec);

% power comparison
fprintf("Avarage Power comparison:\n");
if (abs(P_Signal - P_SignalSpec) < e)
    fprintf("Signal - true\n");
else
    fprintf("Signal - false\n");
end
if (abs(P_Noise - P_NoiseSpec) < e)
    fprintf("Noise - true\n");
else
    fprintf("Noise - false\n");
end
if (abs(P_NoisedSignal - P_NoisedSignalSpec) < e)
    fprintf("NoisedSignal - true\n");
else
    fprintf("NoisedSignal - false\n");
end

% Parseval theorem 
fprintf("Parseval theorem check:\n");
if (abs(dim * P_Signal - P_SignalSpec) < e)
    fprintf("Signal - true\n");
else
    fprintf("Signal - false\n");
end
if (abs(dim * P_Noise - P_NoiseSpec) < e)
    fprintf("Noise - true\n");
else
    fprintf("Noise - false\n");
end
if (abs(dim * P_NoisedSignal - P_NoisedSignalSpec) < e)
    fprintf("NoisedSignal - true\n");
else
    fprintf("NoisedSignal - false\n");
end

%% task №5 Signal filtering

FilteredNoisedSignal = FilterSignal(NoisedSignal);
subplot(3, 1, 3), plot(t, abs(FilteredNoisedSignal));
FilteredNoise = FilteredNoisedSignal - Signal;
SNR_RES = snr(FilteredNoisedSignal, FilteredNoise);
title("FilteredNoisedSignal & SNR = " + SNR_RES);
xlabel("Time");
ylabel("Amplitude");
hold off;

%% task №6 SNR comparison

%SNR_NS = snr(Signal, Noise)
SNR_NS = 10 * log10(PowerSignal(Signal) / PowerSignal(Noise));

%SNR_FNS = snr(Signal, FilteredNoise)
SNR_FNS = 10 * log10(PowerSignal(Signal) / PowerSignal(FilteredNoise));
if (SNR_FNS > SNR_NS)
    fprintf("Filtering range includes only harmonics of noise so FNS is better.\n")
else
    fprintf("Filtering range can include harmonics of signal so NS is better.\n")
end