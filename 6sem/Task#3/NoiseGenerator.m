function [NoisedSignal] = NoiseGenerator(SNR, Signal)
    dim = length(Signal);
    P_Signal = PowerSignal(Signal);
    P_Noise = P_Signal / (10 ^ (SNR / 10));
    Noise = sqrt(P_Noise) * complex(normrnd(0, 0.7, [1, dim]), normrnd(0, 0.7, [1, dim]));
    NoisedSignal = Signal + Noise;
end
