% ���������� ��� �� ��������� 1/2
%> @file ConvEcod.m
% =========================================================================
%> @brief ���������� ��� �� ��������� 1/2
%> @param Bits ���������� ����
%> @return codBits �������������� ���� 
% =========================================================================
function codBits = ConvEcod(Bits)
   %> @todo ����� ��� ������ ����
   % g_1(x) = x^2 + x + 1, g_2(x) = x^2 + 1
   codBits = zeros(1, numel(Bits) * 2);     % array for result
   state = [0, 0];                          % state of encoder
   for i = 1 : numel(Bits)
       % calculate new bits
       codBits(2 * i - 1) = mod(Bits(i) + state(1) + state(2), 2);
       codBits(2 * i) = mod(Bits(i) + state(2), 2);
       % update state of encoder
       state(2) = state(1);
       state(1) = Bits(i);
   end
end