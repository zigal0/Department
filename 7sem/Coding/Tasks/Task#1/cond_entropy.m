function ch = cond_entropy(message1, message2)
[aplhabet2, probabilities2] = alphabet_probabilities(message2);
dimAlphabet2 = length(aplhabet2);
cvhs = zeros(1, dimAlphabet2);
for i = 1:dimAlphabet2
    cvhs(1, i) = cond_val_entropy(message1, message2, aplhabet2(i));
end
ch = dot(probabilities2, cvhs);
end