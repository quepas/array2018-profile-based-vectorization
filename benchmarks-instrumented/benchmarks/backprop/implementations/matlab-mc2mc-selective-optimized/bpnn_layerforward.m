function [l1,l2] = bpnn_layerforward(l1,l2,conn,n1,n2)
l1(1) = 1.0;

if n1 >= 385
    for j = 2:n2
        s = sum(conn(1:n1, j) .* l1(1:n1)');
        l2(j) = 1.0 / (1.0 + exp(-s));
    end
else
    for j = 2:n2
        s = 0;
        for k = 1:n1
            s = s + conn(k,j) * l1(k);
        end
        l2(j) = 1.0 / (1.0 + exp(-s));
    end
end
end