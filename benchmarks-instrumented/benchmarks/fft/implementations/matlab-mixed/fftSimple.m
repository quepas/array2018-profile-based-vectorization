function [rtnR, rtnI] = fftSimple(xR, xI, N)
rtnR = zeros(1,N);
rtnI = zeros(1,N);

%fprintf('fftSimple: loop(v) = %d\n',floor(N/2));

if N == 1
    rtnR(1) = xR(1);
    rtnI(1) = xI(1);
else
    half = floor(N/2);
    eR = zeros(1,half);
    eI = zeros(1,half);
    dR = zeros(1,half);
    dI = zeros(1,half);
    % old
    %for k=1:half
    %    eR(k) = xR(2*k - 1);
    %    eI(k) = xI(2*k - 1);
    %    dR(k) = xR(2*k);
    %    dI(k) = xI(2*k);
    %end
    % new
    k = colon(1,half);
    dR(k) = xR(times(2,k));
    dI(k) = xI(times(2,k));
    eI(k) = xI(minus(times(2,k),1));
    eR(k) = xR(minus(times(2,k),1));
    %
    [VecER,VecEI] = fftSimple(eR, eI, half);
    [VecDR,VecDI] = fftSimple(dR, dI, half);
    for k=1:half
        r = 1; rad = -2.0*pi*(k-1)/N;
        cR = r*cos(rad);
        cI = r*sin(rad);
        tmpR = VecDR(k) * cR - VecDI(k)*cI;
        tmpI = VecDR(k) * cI + VecDI(k)*cR;
        VecDR(k) = tmpR;
        VecDI(k) = tmpI;
    end
    for k=1:half
        rtnR(k) = VecER(k) + VecDR(k);
        rtnI(k) = VecEI(k) + VecDI(k);
        rtnR(k + half) = VecER(k) - VecDR(k);
        rtnI(k + half) = VecEI(k) - VecDI(k);
    end
end
end
