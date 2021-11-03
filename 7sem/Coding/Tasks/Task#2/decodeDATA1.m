function decoded_data = decodeDATA1(encoded_data)
power = 2; % lenth of dictionary equals to 2 ^ power
dict = strings(1, 2 ^ power);
dict_index = 2;
decoded_data = [];
construction_len = 8 + power;
buff_len = 7 * construction_len;

data_len = length(encoded_data);
cur_index = 1;
continue_flag = 1;
while continue_flag
    if (cur_index + buff_len - 1 > data_len)
        buff = encoded_data(cur_index:end);
        buff_len = length(buff);
        continue_flag = 0;
    else 
        buff = encoded_data(cur_index:cur_index + buff_len - 1);
        cur_index = cur_index + construction_len;
    end
    for j = 1:buff_len / construction_len
        end_flag = 0;
        start = j * construction_len - construction_len + 1;
        pos = bin2dec(buff(start:start + power - 1));
        symbol = string(char(bin2dec(buff(start + power : start + power + 7))));
        if (pos == 0) 
            dict(dict_index) = symbol;
            decoded_data = [decoded_data, char(symbol)];
            dict_index = dict_index + 1;
        else
            new_word = dict(pos) + symbol;
            decoded_data = [decoded_data, char(new_word)];
            dict(dict_index) = new_word;
        end
        % Dictionary overflow
        if(dict_index - 1 == 2 ^ power)
            dict = strings(1, 2 ^ power);
            dict_index = 2;
        end
        if (end_flag)
            if (continue_flag)
                break;
            end
        end
    end
end
end