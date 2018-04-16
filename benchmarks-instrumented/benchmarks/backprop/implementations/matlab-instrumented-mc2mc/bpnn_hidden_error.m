function [errsum,delta_h] = bpnn_hidden_error(delta_h,nh,delta_o,no,who,hidden)
errsum = 0.0;
for j=2:nh
    h = hidden(j);
    s = 0.0;
    if strcmp(version('-release'), '2013a') && no >= 1217
        k = colon(2,no);
        delta_h(j) = times(times(h,minus(1.0,h)),plus(s,sum(times(delta_o(k),who(j, k)))));
    else
        for k = 2:no
            s = s + delta_o(k) * who(j,k);
        end
        delta_h(j) = h * (1.0 - h) * s;
    end
    errsum = errsum + abs(delta_h(j));
end
end