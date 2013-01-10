%PRMEM Size of memory and loops for intermediate results
% 
%   [LOOPS,ROWS,LAST] = PRMEM(M,K)
% 
% Assume that an array of the size [M x K] has to be computed. The 
% numbers of LOOPS and ROWS are determined which are needed such that 
% ROWS*K < GLOBALPRMEMORY (a global variable that is initialized in this 
% routine, if necessary). The final number of rows for the last loop 
% is returned in LAST. 
%
% EXAMPLES
% [M,K] = size(A);
% [LOOPS,ROWS,LAST] = prmem(M,K);
% if (LOOPS == 1)
%  RESULT = < compute the result based on A >
% else
%   RESULT = 0;
%   for J =1:LOOPS
%     if (J == LOOPS), N = LAST; else N = ROWS; end
%     NN = (J-1)*ROWS;
%     RESULT = RESULT + < compute a partial result based on A(NN+1:NN+N,:) >
%	  end
% end

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% $Id: prmem.m,v 1.3 2007/03/22 07:46:46 duin Exp $

function [loops,n,n1] = prmem(m,k)

	prtrace(mfilename);

	n = min([floor(prmemory/k),m]);
	if (n == 0)
		error('PRMEMORY too small for the given data size. Decrease size or change PRMEMORY.');
	end
	loops = ceil(m/n);   
	n1 = m - (loops-1)*n; 

return;