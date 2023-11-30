%
% chebtest.m -- test the accruacy of chebyshev differentiation for first and fourth 
%               derivatives 
%
function chebtest

Nmax = 80;                % max number of points to test
Nv = 1:4:Nmax;            % array of numbers of points
E = zeros(length(Nv),2);  % array to store the errors


% loop over increasing numbers of points
%
for k=1:length(Nv)
  N = Nv(k);
  
  % create differentiation matrix and 4th differentiation matrix
  %
  [D,x]=cheb(N);
  D4 = D^4;
  
  % v is function to differentiate
  % vp is first derivative
  % vp4 is fourth derivative
  %
  v = 1./(1+x.^2);
  vp = -2*x.*v.^2;
  vp4 = (120*x.^4  - 240*x.^2  + 24).*v.^5;
  
  % compute the max errors in the two derivatives
  %
  E(k,1) = norm(D*v-vp,inf);
  E(k,2) = norm(D4*v-vp4,inf);
  
end


% now plot
%
semilogy(Nv,E,'.-');
legend('first','fourth');
end

% CHEB  compute D = differentiation matrix, x = Chebyshev grid
%  input N -- order of chebyshev polynomial
%
%  output x -- N+1 chebyshev points ordered from 1 down to -1
%         D -- (N+1)x(N+1) chebyshev differentiaion matrix
% 
%  from cheb.m from Trefethen, Spectral Methods in MATLAB, 2000
%
function [D,x] = cheb(N)
if N==0, D=0; x=1; return, end
x = cos(pi*(0:N)/N)'; 
c = [2; ones(N-1,1); 2].*(-1).^(0:N)';
X = repmat(x,1,N+1);
dX = X-X';                  
D  = (c*(1./c)')./(dX+(eye(N+1)));      % off-diagonal entries
D  = D - diag(sum(D'));                 % diagonal entries
end

