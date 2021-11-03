%% LZ78 decoding

function decoded_data = decodeLZ78(encoded_data, power)
dict = strings(1, 2 ^ power);       % dictionary
dict_index = 1;                     % current index of dictionary for update
decoded_data = [];                  % decoding result
construction_len = 8 + power;       % len of 1 construction

data_len = numel(encoded_data);     % data lentgh

for i = 1 : data_len / construction_len
    % get new construction and decompose it
    cur_str = encoded_data(construction_len * (i - 1) + 1 : i * construction_len);
    pos = bin2dec(cur_str(1 : power));
    symbol = string(char(bin2dec(cur_str(power + 1 : end))));
    
    if (pos == 0) 
        to_dict = symbol;
        decoded_data = cat(2, decoded_data, char(symbol));
    else
        to_dict = dict(pos) + symbol;
        decoded_data = cat(2, decoded_data, char(to_dict));
    end
    
    % dictionary update
    if (dict_index == 2 ^ power)
        dict = strings(1, 2 ^ power);
        dict_index = 1;
    else
        dict(dict_index) = to_dict;
        dict_index = dict_index + 1;
    end
end
end