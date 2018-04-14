function [rtnR,rtnI] = fft2D(xR, xI, N)
% rtn -> return value
rtnR = zeros(N, N);
rtnI = zeros(N, N);

if strcmp(version('-release'), '2013a') && N >= 65 || strcmp(version('-release'), '2015b') && N >= 2753
    for i=1:N
        [resR,resI] = fftSimple(xR(i,:),xI(i,:),N);
        rtnR(i, :) = resR(1:N);
        rtnI(i, :) = resI(1:N);
    end
    rtnR = transpose(rtnR);
    rtnI = transpose(rtnI);
    for i=1:N
        [resR,resI] = fftSimple(rtnR(i,:), rtnI(i,:), N);
        rtnR(i, :) = resR(1:N);
        rtnI(i, :) = resI(1:N);
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
