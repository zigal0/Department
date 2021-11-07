function corr = corr_ev0(frame, to_find)
corr = zeros(1, numel(frame) - numel(to_find) + 1);
sigma_to_find = sqrt(to_find * to_find');
for i = 1 : numel(frame) - numel(to_find) + 1
    cur = frame(i : i + numel(to_find) - 1);
    sigma_cur = sqrt(cur * cur');
    corr(i) = cur * to_find' / (sigma_to_find * sigma_cur);
end
end