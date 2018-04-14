Why slowdown?

1. The two patterns are shown below after the profiling data.
   The pattern 1 currently exists in the code which is slower
   the pattern 2 (about 11.6% slowdown).
2. Given the medium input, the length of the two vectorized
   loops is 2300 which is quite small.
%%%% LJH lots of extra copies made in the vectorized version of this also
%%%% LJH check the vectorization, especially in tridiagonal.


profiling: (original code)
====


total time: 28.925s

| Function Name         | Time    | Percentage |
| ---------             | --------| ---------  |
| runner                |  0.121s | 0.4%       |
| **crnich** (1)        |  7.734s | 26.7%      | 
| **tridiagonal** (2)   | 21.073s | 72.9%      | 

(1): One loop is vectorized (15%)
(2): One loop is vectorized (20%)

--------------------------
Pattern 1
====

    mc_t128 = colon(1,n);
    mc_t129 = j1;
    U(mc_t128, mc_t129) = ...
--------------------------

--------------------------
Pattern 2
====

    U(colon(1,n), j1) = ...
--------------------------


Original code
==========================

    % (crnich)
    for j1=2:m,
        for i1=2:(n-1),
            Vb(i1)=U(i1-1, j1-1)+U(i1+1, j1-1)+s2*U(i1, j1-1);
        end;
        X=tridiagonal(Va, Vd, Vc, Vb, n);
        U(1:n, j1)=X';
    end;
    
    (tridiagonal)
    for k=(n-1):-1:1,
        X(k)=(B(k)-C(k)*X(k+1))./D(k);
    end;

--------------------------

Vectorized code: (plus)
==========================

    (crnich)
    mc_t208 = 2;
    for j1 = (mc_t208 : m);
    i1 = colon(2,minus(n,1));
    if length(Vb)==length(i1)
    Vb=plus(plus(U(minus(i1,1),minus(j1,1)),U(plus(i1,1),minus(j1,1))),times(minus(rdivide(2,r),2),U(i1,minus(j1,1))));
    else
    Vb(i1)=plus(plus(U(minus(i1,1),minus(j1,1)),U(plus(i1,1),minus(j1,1))),times(minus(rdivide(2,r),2),U(i1,minus(j1,1))));
    end
    mc_t128 = colon(1,n);
    mc_t129 = j1;
    U(mc_t128, mc_t129) = transpose(tridiagonal(Va, Vd, Vc, Vb, n));
    end
    
    (tridiagonal)
    k = colon(minus(n,1),uminus(1),1);
    if length(X)==length(k) %%% LJH not enough of a check,  note that k is not 1..n  but n-1 to 1.
    X=rdivide(minus(B(k),times(C(k),X(plus(k,1)))),D(k));
    else
    X(k)=rdivide(minus(B(k),times(C(k),X(plus(k,1)))),D(k));
    end
-----------------------------
