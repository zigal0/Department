function [FilteredNoisedSignal] = FilterSignal(NoisedSignal)
    NoisedSignalSpec = fft(NoisedSignal);
    NoisedSignalSpec(15 : 55) = 0;
    FilteredNoisedSignal = ifft(NoisedSignalSpec);
end

