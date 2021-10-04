function normilizedValues = normilize(bitsValue)
[numberOfElements, ~] = size(bitsValue);
normilizedValues = bitsValue / sqrt(sum(bitsValue .* conj(bitsValue)) / numberOfElements);
end