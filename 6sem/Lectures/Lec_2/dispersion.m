function [numberelems, disp] = dispersion(array)
disp = sum(array)/(numel(array))^2;
numberelems = nummore5(array);
    function [numberelems5] = nummore5 (array)
        numberelems5 = numel(array(array>5));
    end
end
%    function [numberelems5] = nummore5 (array)
        %numberelems5 = numel(array(array>5));
%   end