function [errsum,delta] = bpnn_output_error(delta,target,output,nj)
errsum = 0.0;
if strcmp(version('-release'), '2013a') && nj >= 321 || strcmp(version('-release'), '2015b') && nj >= 161
    o = output(2:nj);
    t = target(2:nj);
    delta(2:nj) = o .* (1.0 - o) .* (t - o);
    errsum = sum(abs(delta(2:nj)));
else
    for j = 2:nj
        o = output(j);
        t = target(j);
        delta(j) = o * (1.0 - o) * (t - o);
        errsum = errsum + abs(delta(j));
    end
end
end