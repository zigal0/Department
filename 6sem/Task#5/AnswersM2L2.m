%% start main script

clc;
clear all;
close all;

%% Detect main harmonic

[signal, fs] = audioread('Voice.wav');
signal = signal(:, 1);

figure;
subplot(2, 2, 1), spectrogram(signal, [], [], [], fs, 'yaxis');
set(gca, 'YScale','log');
title('Spectrogram of original signal');

n = length(signal);
tRange = (0 : n - 1) / fs;
period = n / fs;
df = 1 / period;
fRange = df * (0 : n / 2 - 1);

% subplot(2, 2, 1), plot(tRange, signal);
% xlabel("Time, s");
% ylabel("Amplitude");
% title("Original signal");

spectrumSignal = GetSpectrum(signal);
subplot(2, 2, 2), plot(fRange, abs(spectrumSignal));
xlabel("frequency , Hz");
ylabel("Amplitude");
title("Spectrum of original signal");
set(gca, 'XScale','log');

% Useful harmonics - 100 * n and main harmonic is 100 Hz

%% Filtering

filteredSignal = zeros(n, 1);
for i = 1:10
    [b, a] = butter(3, [(100 * i - 10), (100 * i + 10)]  / (fs / 2), 'bandpass');
    curHarmonic = filter(b, a, signal);
    filteredSignal = filteredSignal + curHarmonic / (i * i);
end

% subplot(2, 2, 3), plot(tRange, filteredSignal);
% xlabel("Time, s");
% ylabel("Amplitude");
% title("Signal");

subplot(2, 2, 3), spectrogram(filteredSignal, [], [], [], fs, 'yaxis');
set(gca, 'YScale','log');
title('Spectogram of filtered signal');

spectrumFilteredSignal = GetSpectrum(filteredSignal);
subplot(2, 2, 4), plot(fRange, abs(spectrumFilteredSignal));
xlabel("frequency , Hz");
ylabel("Amplitude");
title("Spectrum of filtered signal");
set(gca, 'XScale','log');

audiowrite('FilteredVoice.wav', filteredSignal, fs);

%% Functions 

function [spectrum] = GetSpectrum (signal)
n = length(signal);
spectrumWithNegative = fft(signal) / n;
spectrum = spectrumWithNegative(1 : floor(n / 2));
spectrum(2 : length(spectrum)) = spectrum(2 : length(spectrum)) .* 2;
end