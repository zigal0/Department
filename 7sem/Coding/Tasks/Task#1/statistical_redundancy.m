function r = statistical_redundancy(message)
[alphabet, ~, ~] = unique(message);
r = 1 - (entropy(message)) / (log2(length(alphabet)));
end