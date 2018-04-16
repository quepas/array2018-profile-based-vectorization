function [res] = spmv_core(dim,csr_num_rows,csr_Ap,csr_Ax,csr_Aj,vec)
tot = zeros(1,dim);
res = zeros(1,dim);
for row = 1:csr_num_rows
    row_start = csr_Ap(row);
    row_end   = csr_Ap(row + 1);
    %res(row)  = sum(csr_Ax(row_start:row_end) .* vec(csr_Aj(row_start:row_end)));
    N = row_end - row_start;
    if strcmp(version('-release'), '2013a') && N >= 1025 || strcmp(version('-release'), '2015b') && N >= 6785
        jj = colon(csr_Ap(row),csr_Ap(plus(row,1)));
        res(row) = plus(temp,sum(times(csr_Ax(jj),vec(csr_Aj(jj)))));
    else
        temp = 0;
        for jj = row_start:row_end
            temp = temp + csr_Ax(jj) * vec(csr_Aj(jj));
        end
        res(row) = temp;
    end
end
end