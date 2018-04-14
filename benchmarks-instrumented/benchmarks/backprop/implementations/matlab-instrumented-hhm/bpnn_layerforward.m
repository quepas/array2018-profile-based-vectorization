function [l1,l2] = bpnn_layerforward(l1,l2,conn,n1,n2)
l1(1) = 1.0;
for j = 2:n2
    s = 0;
    if strcmp(version('-release'), '2013a') && n1 >= 449 || strcmp(version('-release'), '2015b') && n1 >= 321
        s = sum(conn(1:n1, j) .* l1(1:n1)');
    else
        for k = 1:n1
            s = s + conn(k,j) * l1(k);
        end
    end
    l2(j) = 1.0 / (1.0 + exp(-s));
end
end