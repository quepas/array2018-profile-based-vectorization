function [rtnR,rtnI] = fft2D(xR, xI, N)
% rtn -> return value
rtnR = zeros(N, N);
rtnI = zeros(N, N);

if strcmp(version('-release'), '2013a') && N >= 65
    for i=1:N
        [resR,resI] = fftSimple(xR(i,:),xI(i,:),N);
        k = colon(1,N);
        rtnI(i, k) = resI(k);
        rtnR(i, k) = resR(k);
    end
    rtnR = transpose(rtnR);
    rtnI = transpose(rtnI);
    for i=1:N
        [resR,resI] = fftSimple(rtnR(i,:), rtnI(i,:), N);
        k = colon(1,N);
        rtnI(i, k) = resI(k);
        rtnR(i, k) = resR(k);
    end
    rtnR = transpose(rtnR);
    rtnI = transpose(rtnI);
else
    for i=1:N
        [resR,resI] = fftSimple(xR(i,:),xI(i,:),N);
        for k=1:N
            rtnR(i,k) = resR(k);
            rtnI(i,k) = resI(k);
        end
    end

    rtnR = transpose(rtnR);
    rtnI = transpose(rtnI);
    for i=1:N
        [resR,resI] = fftSimple(rtnR(i,:), rtnI(i,:), N);
        for k=1:N
            rtnR(i,k) = resR(k);
            rtnI(i,k) = resI(k);
        end
    end
    rtnR = transpose(rtnR);
    rtnI = transpose(rtnI);
end
end
