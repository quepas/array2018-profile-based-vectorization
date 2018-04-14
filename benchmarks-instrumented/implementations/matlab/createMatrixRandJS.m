function [m] = createMatrixRandJS(dim0, dim1)
% Create a dim0-by-dim1 integer matrix

m = zeros(dim0,dim1);
for col = 1:dim1
    for row = 1:dim0
        m(row, col) = commonRandomJS();
    end
end

end