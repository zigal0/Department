function cvh = cond_val_entropy(message1, message2, symbol)
if count(message2, symbol) == 0
    ME = MException('MyComponent:impossibleToCalculate', ...
        'There are not %c in message2', symbol);
    throw(ME);
end
cur = char(message1 .* (message2 == symbol));
[~, jointProbabilitiesBySymbol] = alphabet_probabilities(erase(cur, char(0)));
filteredJointProbabilities = jointProbabilitiesBySymbol(jointProbabilitiesBySymbol > 0);
cvh = -dot(filteredJointProbabilities, log2(filteredJointProbabilities));
end