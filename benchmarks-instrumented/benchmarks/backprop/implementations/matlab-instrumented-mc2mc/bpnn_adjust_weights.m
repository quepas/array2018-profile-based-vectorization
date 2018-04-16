function [ly,w,oldw] = bpnn_adjust_weights(delta,ndelta,ly,nly,w,oldw)
ETA      = 0.3;
MOMENTUM = 0.3;
ly(1)    = 1.0;
for j = 2:ndelta
    if strcmp(version('-release'), '2013a') && nly >= 17 || strcmp(version('-release'), '2015b') && nly >= 929
        k = colon(1,nly);
        new_dw = plus(transpose(times(MOMENTUM,oldw(k, j))),times(times(ETA,delta(j)),ly(k)));
        oldw(k, j) = transpose(new_dw);
        w(k, j) = transpose(plus(transpose(w(k, j)),new_dw));
    else
        for k = 1:nly
            new_dw = ((ETA * delta(j) * ly(k)) + (MOMENTUM * oldw(k,j)));
            w(k,j) = w(k,j) + new_dw;
            oldw(k,j) = new_dw;
        end
    end
end
end