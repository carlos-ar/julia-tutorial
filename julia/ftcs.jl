"""
Solves the 1D Heat diffusion equation
"""

using LinearAlgebra
using SparseArrays
using Plots
using Printf
include("analytical_functions.jl")
include("solvers.jl")


# Problem Parameters
L = 1.0            # Domain length       [n.d.]
T0 = 0.0           # Initial temperature  [n.d.]
T1 = 1.0           # Boundary temperature [n.d.]

# Set-up Mesh
N = 21
x = range(0, stop=L, length=N)
dx = x[2] - x[1]

# discretization
s = 1.0 / 6.0

# Calculate time-step
t_start = 0.0
t_end = 0.1
dt = s * dx^2.0
time = 0.0

# Initial Condition
T = zeros(N)

# Boundary Conditions
T[1] = T1
T[end] = T1

# pre-allocate T_n+1 by copying T values
T_n = copy(T)

# RMS difference
err = 0.0

while time <= t_end
    # Solve system of equations A T_k+1 = T_k
    # where T_k+1 = A^-1 T_k

    for i in 2:N-1
        T_n[i] = s * T[i + 1] + (1 - 2.0 * s) * T[i] + s * T[i - 1]
    end

    # if you want to compare analytical solution
    # uncomment the two lines below
    # Tan = 1. - inf_sum(x, time)
    # err = sqrt(sum((T_n - Tan).^2)) / N^2

    copyto!(T, T_n)

    global time = time + dt
    # println(time)
end

Tan = 1 .- inf_sum(x, time)
err = sqrt(sum((T_n - Tan).^2)) / N^2
@printf("RMS error between numerical and analytical solution: %e", err)

# println("\n Done.")

plot(x,T, 
    linestyle = :dash,
    label="numerical")
plot!(x,Tan,
    markershape = :hexagon,
    label="analytical")