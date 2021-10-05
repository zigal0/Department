function [alphabet, probabilities] = alphabet_probabilities(message)
% alphabet = unique(message);
% uniqueNum = length(alphabet);
% probabilities = zeros(1, uniqueNum);
% for i = 1:uniqueNum
%     probabilities(i) = count(message, alphabet(i)) / length(message);
% end
[alphabet, ~, indexInAlphabet] = unique(message);
probabilities = groupcounts(indexInAlphabet);
probabilities = probabilities' / length(message);
end