function [errsum,delta_h] = bpnn_hidden_error(delta_h,nh,delta_o,no,who,hidden)
errsum = 0.0;
for j=2:nh
    h = hidden(j);
    s = 0.0;
    if strcmp(version('-release'), '2013a') && no >= 545 || strcmp(version('-release'), '2015b') && no >= 321
        s = sum(delta_o(2:no) .* who(j, 2:no));
    else
        for k = 2:no
            s = s + delta_o(k) * who(j,k);
        end
    end
    delta_h(j) = h * (1.0 - h) * s;
    errsum = errsum + abs(delta_h(j));
end
end