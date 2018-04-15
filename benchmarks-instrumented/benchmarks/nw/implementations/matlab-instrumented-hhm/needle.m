function [answer,reference] = needle(penalty, max_rows, max_cols, input_seq_1, input_seq_2, reference, input_itemsets, blosum62)

if strcmp(version('-release'), '2015b') && N >= 129
    for i = 2:max_cols
        reference(i, 2:max_rows) = blosum62(input_seq_2(2:max_rows), input_seq_1(i));
    end
else
    for i = 2:max_cols
        for j = 2:max_rows
            reference(i,j) = blosum62(input_seq_2(j), input_seq_1(i));
        end
    end
end

if strcmp(version('-release'), '2013a') && N >= 9 || strcmp(version('-release'), '2015b') && N >= 393
    input_itemsets(2:max_rows, 1) = -(1:(max_rows-1)) .* penalty;
else
    for i = 2:max_rows
        input_itemsets(i, 1) = -(i - 1) * penalty;
    end
end

if strcmp(version('-release'), '2013a') && N >= 17 || strcmp(version('-release'), '2015b') && N >= 225
    input_itemsets(1, 2:max_cols) = -(1:(max_cols-1)) * penalty;
else
    for j = 2:max_cols
        input_itemsets(1, j) = -(j - 1) * penalty;
    end
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
