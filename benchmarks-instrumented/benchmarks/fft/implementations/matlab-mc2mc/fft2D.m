function [rtnR,rtnI] = fft2D(xR, xI, N)
% rtn -> return value
rtnR = zeros(N, N);
rtnI = zeros(N, N);

%fprintf('fft1: loop1 = %d, loop2(v) = %d\n',N,N);
%fprintf('fft2: loop1 = %d, loop2(v) = %d\n',N,N);

for i=1:N
    [resR,resI] = fftSimple(xR(i,:),xI(i,:),N);
    % old
    %for k=1:N
    %    rtnR(i,k) = resR(k);
    %    rtnI(i,k) = resI(k);
    %end
    % new
    k = colon(1,N);
    rtnI(i, k) = resI(k);
    rtnR(i, k) = resR(k);
    %
end

rtnR = transpose(rtnR);
rtnI = transpose(rtnI);
for i=1:N
    [resR,resI] = fftSimple(rtnR(i,:), rtnI(i,:), N);
    % old
    %for k=1:N
    %    rtnR(i,k) = resR(k);
    %    rtnI(i,k) = resI(k);
    %end
    % new
    k = colon(1,N);
    rtnI(i, k) = resI(k);
    rtnR(i, k) = resR(k);
    %
end
rtnR = transpose(rtnR);
rtnI = transpose(rtnI);
end
