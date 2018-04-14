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

%fprintf('gauss1: loop= %d\n', n);
%fprintf('gauss2: loop= %d\n', m);
q=0;
% old
%for ii=1:n,
%    q=q+(f(ii, m)+f(ii+1, m))*0.5;
%end;
%
%for jj=1:m,
%    q=q+(f(n, jj)+f(n, jj+1))*0.5;
%end;
%
%cap=q*4; % Four quadrants.
% new
ii = colon(1,n);
%mc_t189 = q;;
%[q] = plus(mc_t189, mc_t190);;
q = plus(q,sum(times(plus(f(ii, m),f(plus(ii,1),m)),0.5)));
jj = colon(1,m);
%mc_t196 = q;;
%[q] = plus(mc_t196, mc_t197);;
cap = times(plus(q,sum(times(plus(f(n, jj),f(n,plus(jj,1))),0.5))),4);
%

cap=cap*8.854187;

end

