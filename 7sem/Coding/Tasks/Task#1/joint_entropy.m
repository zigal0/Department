function jh = joint_entropy(message1, message2)
%jh = entropy(message1) + cond_entropy(message2, message1);
union = (string(message1') + string(message2'))';
jh = entropy(union);
end