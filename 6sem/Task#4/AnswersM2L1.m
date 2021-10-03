%% task №1 Analysis of a noised audio file

clc;
clear all;
close all;

[signal, fs] = audioread("file.wav");
signal = signal(:, 1);
n = length(signal);
tRange = (0 : n - 1) / fs;
period = n / fs;
df = 1 / period;
fRange = df * (0 : n / 2 - 1);
subplot(4, 1, 1), plot(tRange, signal);
xlabel("Time, s");
ylabel("Amplitude");
title("Signal");

spectrumSignal = GetSpectrum(signal);
subplot(4, 1, 2), plot(fRange, abs(spectrumSignal));
xlabel("frequency , Hz");
ylabel("Amplitude");
title("Spectrum");
% Useful harmonics: 150, 250, 350 Hz

% w = hanning(n, "periodic");
% periodogram(signal, w, n, fs, "power");
% histogram(signal);

% Filtering
[b, a] = butter(4, [149, 151] / (fs/2), "bandpass");
harmonic1 = filter(b, a, signal);
[b, a] = butter(4, [249, 251] / (fs/2), "bandpass");
harmonic2 = filter(b, a, signal);
[b, a] = butter(4, [349, 351] / (fs/2), "bandpass");
harmonic3 = filter(b, a, signal);

filteredSignal = harmonic1 + harmonic2 + harmonic3;
subplot(4, 1, 3), plot(tRange, filteredSignal);
xlabel("Time, s");
ylabel("Amplitude");
title("Filtered Signal");

filteredSpectrum = GetSpectrum(filteredSignal);
subplot(4, 1, 4), plot(fRange, abs(filteredSpectrum));
xlabel("frequency , Hz");
ylabel("Amplitude");
title("Spectrum");

% Spectograms;
figure;
subplot(1,2,1), spectrogram(signal, [], [], [], fs, "yaxis");
subplot(1,2,2), spectrogram(filteredSignal, [], [], [], fs, "yaxis");

%% task №2 Clipping analysis 

close all;
clear all;
clc;

fs = 2500;
f = 1000;
period = 3;
tRange = (0 : period * fs - 1) / fs;
signalSin = 3 * sin(2 * pi * f * tRange);

n = length(signalSin);

df = 1 / period;
fRange = df * (0 : n / 2 - 1);
audiowrite('task2.wav', signalSin, fs);

% Clipping
clippingSin = signalSin;
clippingSin(clippingSin > 2) = 2;
clippingSin(clippingSin < -2) = -2;
audiowrite('task2Clipping.wav', clippingSin, fs);

% Spectrums
figure;
subplot(1,2,1), plot (fRange, abs(GetSpectrum(signalSin)));
xlabel("frequency , Hz");
ylabel("Ampl");
title("Initial Sin");
subplot(1,2,2), plot (fRange, abs(GetSpectrum(clippingSin)));
xlabel("frequency , Hz");
ylabel("Ampl");
title("Clipping");

% Spectograms
% subplot(1,2,1), spectrogram(signalSin,[],[],[],fs,'yaxis');
% subplot(1,2,2), spectrogram(signalSin,[],[],[],fs,'yaxis');

%% task №3 Analysis of the impact of sampling frequency 

close all;
clear all;
clc;

% Initial signal
[signal, fs] = audioread("task3.wav");
signal = signal(:, 1);
n = length(signal);
wInit = hanning(n, "periodic");
subplot(3, 1, 1), periodogram(signal, wInit, n, fs, "power");
title("Signal fs = " + fs);

% Reduction of the sampling frequency by 2 times 
signalHalf = signal(1 : 2 : length(signal));
wHalf = hanning(length(signalHalf), "periodic");
subplot(3, 1, 2), periodogram(signalHalf, wHalf, length(signalHalf), floor(fs / 2), "power");
title("Signal fs = " + floor(fs / 2));
audiowrite("signalHalf.wav", signalHalf, fs / 2);

% Increase of the sampling frequency by 2 times 
signalDouble = zeros(2 * n, 1);
signalDouble(1 : 2 : length(signalDouble)) = signal;
for j = 2 : 2 : (length(signalDouble) - 1)
    signalDouble(j) = (signalDouble(j - 1) + signalDouble(j + 1)) / 2;
end
signalDouble(length(signalDouble)) = signalDouble(length(signalDouble) - 1);
wDouble = hanning(length(signalDouble), "periodic");
subplot(3, 1, 3), periodogram(signalDouble, signalDouble, length(signalDouble), fs * 2, "power");
title("Signal fs = " + fs * 2);
audiowrite("signalDouble.wav", signalDouble, fs * 2);

%% Functions 

function [spectrum] = GetSpectrum (signal)
n = length(signal);
spectrumWithNegative = fft(signal) / n;
spectrum = spectrumWithNegative(1 : floor(n / 2));
spectrum(2 : length(spectrum)) = spectrum(2 : length(spectrum)) .* 2;
end