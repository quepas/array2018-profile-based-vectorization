function [errsum,delta_h] = bpnn_hidden_error(delta_h,nh,delta_o,no,who,hidden)
errsum = 0.0;
%fprintf('bpnn_hidden_error: loop1 = %d, loop2 (v) = %d\n', nh-1,no-1);
for j=2:nh
    h = hidden(j);
    s = 0.0;
    % old
    %for k = 2:no
    %    s = s + delta_o(k) * who(j,k);
    %end
    %delta_h(j) = h * (1.0 - h) * s;
    % new
    k = colon(2,no);
    delta_h(j) = times(times(h,minus(1.0,h)),plus(s,sum(times(delta_o(k),who(j, k)))));
    %
    errsum = errsum + abs(delta_h(j));
end
end
