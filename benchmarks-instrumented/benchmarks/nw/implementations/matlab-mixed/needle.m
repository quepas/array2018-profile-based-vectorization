function [answer,reference] = needle(penalty, max_rows, max_cols, input_seq_1, input_seq_2, reference, input_itemsets, blosum62)

%fprintf('needle1: loop1 = %d, loop2(v) = %d\n', max_cols-1,max_rows-1);
%fprintf('needle2: loop1(v) = %d\n', max_cols-1);
%fprintf('needle3: loop1(v) = %d\n', max_rows-1);
for i = 2:max_cols
    % old
    %for j = 2:max_rows
    %    reference(i,j) = blosum62(input_seq_2(j), input_seq_1(i));
    %end
    % new
    j = colon(2,max_rows);
    reference(i, j) = blosum62(input_seq_2(j),input_seq_1(i));
    %
end

% old
%for i = 2:max_rows
%    input_itemsets(i, 1) = -(i - 1) * penalty;
%end
%for j = 2:max_cols
%    input_itemsets(1, j) = -(j - 1) * penalty;
%end
% new
i = colon(2,max_rows);
mc_t74 = 1;
input_itemsets(i, mc_t74) = times(uminus(minus(i,1)),penalty);
j = colon(2,max_cols);
mc_t77 = 1;
input_itemsets(mc_t77, j) = times(uminus(minus(j,1)),penalty);
%

for i = 2:max_rows
    for j = 2:max_cols
        input_itemsets(i, j) = max(max( ...
            input_itemsets(i-1, j-1) + reference(i, j), ...
            input_itemsets(i, j-1) - penalty), ...
            input_itemsets(i-1, j) - penalty);
    end
end

answer = input_itemsets + 1;
end
