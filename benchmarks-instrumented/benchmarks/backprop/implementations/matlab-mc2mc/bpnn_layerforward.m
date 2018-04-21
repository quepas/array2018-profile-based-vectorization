function [l1,l2] = bpnn_layerforward(l1,l2,conn,n1,n2)
l1(1) = 1.0;
%fprintf('bpnn_layerforward: loop1 = %d, loop2 (v) = %d\n', n2-1,n1);
for j = 2:n2
    s = 0;
    %for k = 1:n1
    %    s = s + conn(k,j) * l1(k);
    %end
    k = colon(1,n1);
    %s = plus(s,sum(times(transpose(conn(k,j)), l1(k))));
    %l2(j) = 1.0 / (1.0 + exp(-s));
    l2(j) = rdivide(1.0,plus(1.0,exp(uminus(plus(s,sum(times(transpose(conn(k, j)),l1(k))))))));
end
end
