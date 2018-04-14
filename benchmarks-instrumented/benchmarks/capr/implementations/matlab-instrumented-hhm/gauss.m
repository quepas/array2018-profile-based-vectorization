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
if strcmp(version('-release'), '2013a') && n >= 369 || strcmp(version('-release'), '2015b') && n >= 321
    q = sum(0.5*(f(1:n, m) + f(2:(n+1), m)));
else
    for ii=1:n,
        q=q+(f(ii, m)+f(ii+1, m))*0.5;
    end;
end

if strcmp(version('-release'), '2013a') && m >= 337 || strcmp(version('-release'), '2015b') && m >= 289
    q = q+sum(f(n, 1:m) + f(n, 2:(m+1)))*0.5;
else
    for jj=1:m,
        q=q+(f(n, jj)+f(n, jj+1))*0.5;
    end;
end

cap=q*4; % Four quadrants.
cap=cap*8.854187;

end

