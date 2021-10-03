function [Power] = PowerSignal(Signal)
    Power = sum(Signal .* conj(Signal)) * (1 / length(Signal));
end

