function [res] = spmv_core(dim,csr_num_rows,csr_Ap,csr_Ax,csr_Aj,vec)
tot = zeros(1,dim);
res = zeros(1,dim);
%fprintf('spmv_core: loop1 = %d, loop2(v) = %d\n', csr_num_rows, max(csr_Ap(1+(1:csr_num_rows))-csr_Ap(1:csr_num_rows)));
for row = 1:csr_num_rows
    row_start = csr_Ap(row);
    row_end   = csr_Ap(row + 1);
    %res(row)  = sum(csr_Ax(row_start:row_end) .* vec(csr_Aj(row_start:row_end)));
    temp = 0;
    % old
    %for jj = row_start:row_end
    %    temp = temp + csr_Ax(jj) * vec(csr_Aj(jj));
    %end
    %res(row) = temp;
    % new
    jj = colon(csr_Ap(row),csr_Ap(plus(row,1)));
    res(row) = plus(temp,sum(times(csr_Ax(jj),vec(csr_Aj(jj)))));
    %
end
end
