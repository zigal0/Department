function [alphabet, probabilities] = alphabet_probabilities(message)
[alphabet, ~, indexInAlphabet] = unique(message);
probabilities = groupcounts(indexInAlphabet);
probabilities = probabilities' / length(message);
end