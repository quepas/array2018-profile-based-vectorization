Why slowdown?

1. The vectorized code exists in a cold area of code (10%).
%%% LJH - this is important,  we are seeing a slowdown of 10% OVERALL,  from vectorizing only 10% of the code.    This means that the vectorized code is a LOT slower, about 10x slower, than the original loops.

2. The operation of 'sum' is expensive when its input data
   is not large enough (overhead)

Profiling
====

total time: 7.663s         

| Function Name | Time | Percentage |
| --------- | --------| --------- |
| runner    |  0.024s |  0.3% |
| capacitor |  0.181s | 2.4% |
| seidel   |  6.699s | 87.4% |
| **gauss**    |  0.759s | 9.9% |


**Gauss**'s two loops are vectorized

Original two loops:
%%% LJH these loops are perfect for traditional loop optimizers. The array f is only being read, so no need for copies,  the result is being written to a scalar, which can be kept in a register.  The indexing into the arrays is very regular and can be handled well with standard techniques like induction variable elimination.

%LJH - note that the array f is only being read,  no copies are ever needed, and that q is a scalar, that presumably can be put into a register.      These loops are exactly the kind of loops that a standard optimizer could do a good job on.     In this code there is no need to generate any new vectors or arrays. 




--------------------------

      q=0;
      for ii=1:n,
          q=q+(f(ii, m)+f(ii+1, m))*0.5;
      end;
      
      for jj=1:m,
          q=q+(f(n, jj)+f(n, jj+1))*0.5;
      end;
      
      cap=q*4; % Four quadrants.
      cap=cap*8.854187;
   
-----------------------------

Vectorized code: (plus)
%%% On the other hand,  the vectorized version requires a lot of new copies of intermediate vectors.  As below,  there are around 5 copies of size n and 5 copies of size m required.   This means that the memory is being traversed many times,  instead of only once in the original loops.    This may be beneficial in an interpreter, where there is a lot of overhead for every instruction anyway,   but it will not be good when compared to a JIT that can generate tight code for the loops.
% in this code we must create lots of new vectors,  I have estimated below how many.   It looks to me to be around 5 vectors of size n and 5 vectors of size m.     Each of these vectors needs to be created and will not be in registers. 

--------------------------

      q = 0;
      %   vector copy
      ii = colon(1,n);
      %   4 or 5 vector copies
      q = plus(q,sum(times(plus(f(ii, m),f(plus(ii,1),m)),0.5)));
      %  vector copy
      jj = colon(1,m);
      % 4 or 5 vector copies
      cap = times(plus(q,sum(times(plus(f(n, jj),f(n,plus(jj,1))),0.5))),4);
      % Four quadrants.;
      cap = times(cap,8.854187);
---------------------------

Versions
=======

1. Matlab:
  (original code, baseline)
2. Matlab-plus:
  (vectorized code)
3. Matlab-plus:
  (two loops are replaced with with original code) %%% LJH since this is actually a bit faster than the original, this means that it really is the vectorized statements that are slowing things down.
% LJH this shows that the slowdown is
   not due to the conversion to Tamer plus,  it is due to the replacement of the loops with vectors. 
4. Matlab-plus:
  (ii and jj are replaced with colons)


Comparison
==========

1. 2.6026s -> 1x
2. 2.9620s -> 0.88x
3. 2.5317s -> 1.03x
4. 3.1454s -> 0.83x 
