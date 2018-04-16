function cap=gauss(n, m, h, f)
%-----------------------------------------------------------------------
%
%	This function M-file computes capacitance from the
%	potential.
%
%	Invocation:
%		>> cap=gauss(n, m, h, f)
%
%		where
%
%		i. n is the number of points along the x-axis,
%
%		i. m is the number of points along the height of
%		   the outer conductor,
%
%		i. f is the potential array,
%
%		i. h is the grid size,
%
%		o. cap is the capacitance.
%
%	Requirements:
%		None.
%
%	Source:
%		Computational Electromagnetics - EEK 170 course at
%		http://www.elmagn.chalmers.se/courses/CEM/.
%
%-----------------------------------------------------------------------

q=0;
if strcmp(version('-release'), '2013a') && n >= 705 || strcmp(version('-release'), '2015b') && n >= 1937
    ii = colon(1,n);
    q = plus(q,sum(times(plus(f(ii, m),f(plus(ii,1),m)),0.5)));
else
    for ii=1:n,
        q=q+(f(ii, m)+f(ii+1, m))*0.5;
    end;
end

if strcmp(version('-release'), '2013a') && m >= 961
    jj = colon(1,m);
    cap = times(plus(q,sum(times(plus(f(n, jj),f(n,plus(jj,1))),0.5))),4);
else
    for jj=1:m,
        q=q+(f(n, jj)+f(n, jj+1))*0.5;
    end;
    cap=q*4; % Four quadrants.
    cap=cap*8.854187;
end

end

