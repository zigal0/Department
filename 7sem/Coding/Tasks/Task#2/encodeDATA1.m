function encoded_data = encodeDATA1(data)
power = 2; % lenth of dictionary equals to 2 ^ power
dict = strings(1, 2 ^ power);
dict_index = 2;
buff_len = 2;
cur_str = "";
encoded_data = [];
% construction_len = 8 + power;

data_len = length(data);
cur_index = 1;
continue_flag = 1;

while continue_flag
    if (cur_index + buff_len - 1 > data_len)
        buff = data(cur_index:end);
        buff_len = length(buff);
        continue_flag = 0;
    else 
        buff = data(cur_index:cur_index + buff_len - 1);
        cur_index = cur_index + 1;
    end
    for j = 1:buff_len
        end_flag = 0;
        cur_str = strcat(cur_str, string(buff(j)));
        cur_arr = char(cur_str);
        if (~ismember(cur_str, dict))
            
            if (length(cur_arr) == 1)
                encoded_result = strcat(dec2bin(0, power), dec2bin(cur_arr, 8));
            else
                pos = find(ismember(dict, cur_arr(1:length(cur_arr) - 1)));
                encoded_result = strcat(dec2bin(pos - 1, power), dec2bin(cur_arr(length(cur_arr)), 8));
            end
%         encoded_data = cat(2, encoded_data, encoded_result);
            end_flag = 1;
            encoded_data = [encoded_data, encoded_result];
        
            % dictionry update 
            if (dict_index - 1 == 2 ^ power)
                dict = strings(1, 2 ^ power);
                dict_index = 2;
            else 
                dict(dict_index) = cur_str;
                dict_index = dict_index + 1;
            end
        else
            cur_index = cur_index + 1;
        end
        if (end_flag)
            cur_str = "";
            if (continue_flag)
                break;
            end
        end
    end
    if (cur_str ~= "")
        if (length(cur_arr) == 1)
            encoded_result = strcat(dec2bin(0, power), dec2bin(cur_arr, 8));
        else
            pos = find(ismember(dict, cur_arr(1:length(cur_arr) - 1)));
            encoded_result = strcat(dec2bin(pos - 1, power), dec2bin(cur_arr(length(cur_arr)), 8));
        end
        encoded_data = [encoded_data, encoded_result];
        cur_str = "";
    end
end