function [l1,l2] = bpnn_layerforward(l1,l2,conn,n1,n2)
l1(1) = 1.0;
for j = 2:n2
    s = 0;
    if strcmp(version('-release'), '2013a') && n1 >= 961
        k = colon(1,n1);
        l2(j) = rdivide(1.0,plus(1.0,exp(uminus(plus(s,sum(times(transpose(conn(k, j)),l1(k))))))));
    else
        for k = 1:n1
            s = s + conn(k,j) * l1(k);
        end
        l2(j) = 1.0 / (1.0 + exp(-s));
    end
end
end