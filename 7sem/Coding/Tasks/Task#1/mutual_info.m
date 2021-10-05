function mi = mutual_info(message1, message2)
mi = entropy(message1) - cond_entropy(message1, message2);
end