#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 29 13:39:54 2023

@author: carlosar
"""

import numpy as np
import matplotlib.pyplot as plt
import scipy as sp
import scipy.sparse
import copy

from analytical_functions import inf_sum
from solvers import trid
# Problem Parameters
L         = 1.           # Domain lenghth       [n.d.]
T0        = 0.           # Initial temperature  [n.d.]
T1        = 1.           # Boundary temperature [n.d.]
t_start   = 0.
t_end     = 0.1
s         = 1. / 6.
N         = 21


# Set-up Mesh
x         = np.linspace(0,L,N)
dx        = x[1]-x[0]
 
# Calculate time-step
dt        = s*dx**2.0   
time      = 0.

# Initial Condition
T         = np.zeros(np.shape(x))

# Boundary Conditions
T[0]      = T1
T[-1]     = T1

# pre-allocate T_n+1 by deepcopy-ing T values
T_n       = copy.deepcopy(T)

#Tridiagonal matrix values
a = np.zeros(N)-s
b = np.zeros(N)+(1.+2.*s)
c = np.zeros(N)-s

#sparse matrix composition
positions = [-1, 0, 1]
A= sp.sparse.dia_matrix(([a,b,c], positions), (N, N)).todense()

#Boundary conditions on the matrix
A[N-1,N-2] = 0
A[0,0] = 1
A[N-1,N-1] = 1
A[0,1] = 0

#Boundary Conditions on the a,b,c vectors
a[N-1] = 0
b[0] = 1
b[N-1] = 1
c[0] = 0

#RMS difference
err = 0.

while time <= t_end:

    # Solve system of equations A T_k+1 = T_k
    # where T_k+1 = A^-1 T_k
    
    # --- Using numpy linalg matrix solver
    #  and numpy.linalg.solve(A,T_k) = T_k+1
    T_n = np.linalg.solve(A,T)

    # --- Using home-made Thomas tri-diagonal solver
    # T_n = trid(a,b,c,T,N)

    # if you want to compare analytical solution
    # uncomment the two lines below
    Tan = 1-inf_sum(x,time)
    # err = np.sqrt(np.sum((T_n-Tan)**2))/N**2

    T = copy.deepcopy(T_n)

    time = time + dt    
    

plt.plot(x,T)
plt.plot(x,Tan, '--')
plt.show()
print('\n Done.\n')