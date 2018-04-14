SPMV (Sparse Matrix-Vector Multiplication)
===========================================

Compressed Sparse Row, or CSR, is a format for storing sparse matrices by storing only non-zero values and their positions. CSR uses three different
arrays to accomplish this. The first stores only the non-zero values from the matrix, from left to right then top to bottom.  The second array hold holds the column position for each value in the first array. The third array holds the locations within the first array that correspond to the start of a new row. CSR allows for a large amount of space saving, but using one in an algorithm requires a step to process the data.

Analysis
=======

The SPMV has a nested loop.  The innermost loop is vectorized by a
idiom (reduction).  However, the number of the iteration of the
innermost loop is just 2 at runtime with the medium size input.

The original code:
=======

    for row = 1:csr_num_rows
        row_start = csr_Ap(row);
        row_end   = csr_Ap(row + 1);
        %res(row)  = sum(csr_Ax(row_start:row_end) .*
    vec(csr_Aj(row_start:row_end)));
        temp = 0;
        for jj = row_start:row_end
            temp = temp + csr_Ax(jj) * vec(csr_Aj(jj));
        end
        res(row) = temp;
    end


The vectorized code:
======

    mc_t19 = 1;
    for row = (mc_t19 : csr_num_rows);
    temp = 0;
    jj = colon(csr_Ap(row),csr_Ap(plus(row,1)));
    res(row) = plus(temp,sum(times(csr_Ax(jj),vec(csr_Aj(jj)))));
    end

