# explicit FTCS numerical scheme
# Vectorized version by Kelli
# 
using Plots
using LinearAlgebra
using SparseArrays

# Problem Parameters 
L = 1;          # length of rod
T0 = 0;         # initial temp  
T1 = 1;         # final temp

# Set up mesh
N = 51;
x = range(0,L,N);
dx = x[2] - x[1];

# discretization
s = 1/6;

# Set up time step
t_start = 0;
t_end = 0.1;
dt = s*dx^2;
tns = range(0,240)
t = [t_start + dt*t for t in tns ]

# Initial Condition
Tnew = T0*ones(N,1);
Tnew[1] = T1;
Tnew[end] = T1;

# Pre-Allocate 
Told = zeros(N,1);

# construct explicit Toeplitz matrix
off_diag = s*ones(N-1);
diag = (1-2*s)*ones(N);
Ae = spdiagm(-1 => off_diag, 0 => diag, 1 => off_diag);
Ae[1,1] = 1;
Ae[1,2] = 0;
Ae[end,end-1] = 0;
Ae[end,end] = 1;

for i = 1:length(t)
    Told = Tnew;
    Tnew = Ae*Told;
end

plot(x,Tnew,linewidth=3,color="mediumpurple3")



