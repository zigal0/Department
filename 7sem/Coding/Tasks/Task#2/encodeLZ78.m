%% LZ78 encoding

function encoded_data = encodeLZ78(data, power)
dict = strings(1, 2 ^ power);   % dictionary
dict_index = 1;                 % current index of dictionary for update
cur_str = "";                   % current string for analysis 
encoded_data = [];              % encoding result
data_len = numel(data);         % data lentgh

for i = 1 : data_len
    cur_str = strcat(cur_str, string(data(i)));
    cur_arr = char(cur_str);
    
    % either dict contains cur_str or i is the last index
    if (~ismember(cur_str, dict) || i == data_len)
        if (numel(cur_arr) == 1)
            % cur_str is a single symbol -> (0, cur_str)
            encoded_result = strcat(dec2bin(0, power), dec2bin(cur_arr, 8));
        else
            % cur_str is array of symbols -> (pos - 1, cur_str - last
            % symbol of cur-str), where pos - position of cur_str - last
            % symbol in dictionary
            pos = find(ismember(dict, cur_arr(1:numel(cur_arr) - 1)));
            encoded_result = strcat(dec2bin(pos, power), ...
                dec2bin(cur_arr(numel(cur_arr)), 8));
        end
        encoded_data = cat(2, encoded_data, encoded_result);
        
        % dictionry update 
        if (dict_index == 2 ^ power)
            dict = strings(1, 2 ^ power);
            dict_index = 1;
        else 
            dict(dict_index) = cur_str;
            dict_index = dict_index + 1;
        end
        cur_str = "";
    end
end
end