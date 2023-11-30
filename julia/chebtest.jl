using LinearAlgebra
using Printf

# cheb -- return the chebyshev points on [-1,1] and differentiation matrix 
#  input N -- order of chebyshev polynomial
#
#  output x -- N+1 chebyshev points ordered from 1 down to -1
#         D -- (N+1)x(N+1) chebyshev differentiaion matrix
# 
#  adapted from cheb.m from Trefethen, Spectral Methods in MATLAB, 2000
#
function cheb(N)
  t=0:N;

# run with extended precision 
  x=cos.(BigFloat(pi)*t/N);
# run with double
  x=cos.(pi*t/N);

  c = [2; ones(N-1,1); 2].*(-1).^(0:N);
  X = repeat(x,1,N+1);
  dX = X-X';                
  D=(c.*(c.^(-1))').*(dX+I).^(-1);
  D = D - Diagonal(vec(sum(D,dims=2)));
  
  return D, x
end

Nmax=250;               # max number of points 
Nv = 1:4:Nmax;          # array of numbers of points
E=zeros(length(Nv),2);  # array to store the errors

# loop over increasing numbers of points
#
for k=1:length(Nv)
 N = Nv[k]
 @printf("N=%i \n",N)
 
 # create differentiation matrix and 4th differentiation matrix
 #
 (D,x)=cheb(N);
 D4 = D^4;

 # v is function to differentiate
 # vp is first derivative
 # vp4 is fourth derivative
 #
 v = (1 .+ x.^2).^(-1);
 vp = -2*x.*v.^2;
 vp4 = (120*x.^4  - 240*x.^2  .+ 24).*v.^5;
 
 # compute the max errors in the two derivatives
 #
 E[k,1] = norm(D*v-vp,Inf);
 E[k,2] = norm(D4*v-vp4,Inf);
 
end

# plot the results
#
using Plots
display(plot(Nv,E,yscale=:log10,label=["first" "fourth"],lw=3));
scatter!(Nv,E,label="",mc=[:blue :red])
plot!(xlabel="N");
plot!(ylabel="error")

