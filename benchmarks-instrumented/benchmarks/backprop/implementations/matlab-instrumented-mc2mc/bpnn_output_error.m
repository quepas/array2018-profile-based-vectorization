function [errsum,delta] = bpnn_output_error(delta,target,output,nj)
errsum = 0.0;
if strcmp(version('-release'), '2013a') && nj >= 689 || strcmp(version('-release'), '2015b') && nj >= 817
    j = colon(2,nj);
    o = output(j);
    if length(delta)==length(j)
    delta=times(times(o,minus(1.0,o)),minus(target(j),o));
    else
    delta(j)=times(times(o,minus(1.0,o)),minus(target(j),o));
    end
    errsum = plus(errsum,sum(abs(delta(j))));
else
    for j = 2:nj
        o = output(j);
        t = target(j);
        delta(j) = o * (1.0 - o) * (t - o);
        errsum = errsum + abs(delta(j));
    end
end
end