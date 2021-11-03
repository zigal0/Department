% LZ78 testing

clc;
clear;
load('data/7.mat');     % writes to variable 'data'
power = 4;              % lenth of dictionary equals to 2 ^ power

encoded_data = encodeLZ78(data, power);
decoded_data = decodeLZ78(encoded_data, power);

[alphabet, probabilities] = alphabet_probabilities(data); 

fprintf("Zero order symbol entropy: %g bits\n", log2(numel(alphabet)));
fprintf("Symbol entropy: %g bits\n", entropy(data));

fprintf("Input stream bit volume: %d bit\n", 8 * numel(data));

fprintf("Code length: %d bits\n", numel(encoded_data));

fprintf("Average code length per symbol: %g bits\n", numel(encoded_data) / numel(data));

if (numel(data)~=numel(decoded_data))
    fprintf("Length mismatch\n");
elseif (any(data~=decoded_data))
    fprintf("Wrong symbol\n");
else
    fprintf("Correct decoding!\n");
end