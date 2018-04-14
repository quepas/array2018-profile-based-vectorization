function [m] = createMatrixRandi2(max_value, dim0, dim1)
% Create a dim0-by-dim1 integer matrix
% Value range is [1 max_value]

m = zeros(dim0,dim1);
for col = 1:dim1
    for row = 1:dim0
        m(row, col) = commonRandom();
    end
end

m = mod(abs(m), max_value) .* (-1 .* (m < 0) + 1 .* (m > 0)) + 1;

end