function [answer,reference] = needle(penalty, max_rows, max_cols, input_seq_1, input_seq_2, reference, input_itemsets, blosum62)

for i = 2:max_cols
    for j = 2:max_rows
        reference(i,j) = blosum62(input_seq_2(j), input_seq_1(i));
    end
end

%% OLD
%for i = 2:max_rows
%    input_itemsets(i, 1) = -(i - 1) * penalty;
%end
%% Selected Mc2Mc
i = colon(2,max_rows);
mc_t74 = 1;
input_itemsets(i, mc_t74) = times(uminus(minus(i,1)),penalty);

for j = 2:max_cols
    input_itemsets(1, j) = -(j - 1) * penalty;
end

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
