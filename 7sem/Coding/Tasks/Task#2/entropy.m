function h = entropy(message)
[~, probabilities] = alphabet_probabilities(message);
h = -dot(probabilities, log2(probabilities));
end