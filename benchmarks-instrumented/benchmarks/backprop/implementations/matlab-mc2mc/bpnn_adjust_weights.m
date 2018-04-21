function [ly,w,oldw] = bpnn_adjust_weights(delta,ndelta,ly,nly,w,oldw)
ETA      = 0.3;
MOMENTUM = 0.3;
ly(1)    = 1.0;
%fprintf('bpnn_adjust_weights: loop1 = %d, loop2 (v) = %d\n', ndelta-1,nly);
for j = 2:ndelta
    %for k = 1:nly
    %    new_dw = ((ETA * delta(j) * ly(k)) + (MOMENTUM * oldw(k,j)));
    %    w(k,j) = w(k,j) + new_dw;
    %    oldw(k,j) = new_dw;
    %end
    k = colon(1,nly);
    %new_dw = plus(times(times(ETA, delta(j)),ly(k)), times(MOMENTUM, transpose(oldw(k,j))));
    %w(k,j) = w(k,j) + transpose(new_dw);
    %oldw(k,j) = transpose(new_dw);
    new_dw = plus(transpose(times(0.3,oldw(k, j))),times(times(0.3,delta(j)),ly(k)));
    oldw(k, j) = transpose(new_dw);
    w(k, j) = transpose(plus(transpose(w(k, j)),new_dw));
end
end
