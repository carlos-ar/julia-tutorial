#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 29 13:39:54 2023

@author: carlosar
"""

import numpy as np
import matplotlib.pyplot as plt
import copy

from analytical_functions import inf_sum


# Problem Parameters
L         = 1.           # Domain lenghth       [n.d.]
T0        = 0.           # Initial temperature  [n.d.]
T1        = 1.           # Boundary temperature [n.d.]

# Set-up Mesh
N         = 21
x         = np.linspace(0,L,N)
dx        = x[1]-x[0]
 
# Calculate time-step
t_start   = 0.
t_end     = 0.1
dt        = s*dx**2.0   
time      = 0.

# discretization
s         = 1. / 6.


# Initial Condition
T         = np.zeros(np.shape(x))

# Boundary Conditions
T[0]      = T1
T[-1]     = T1

# pre-allocate T_n+1 by deepcopy-ing T values
T_n       = copy.deepcopy(T)


while time <= t_end:
    for i in range(1,N-1):
        T_n[i]= s*T[i + 1] + (1-2.0*s)*T[i] + s*T[i - 1]
  
    time = time + dt        

    T_analytical = 1-inf_sum(x,time)
    err = np.sqrt(np.sum((T_n-T_analytical)**2))/N**2

    # copy current new temp value to use next time iteration, as previous value
    T = copy.deepcopy(T_n)

    
fig, ax = plt.subplots(1,1, dpi=300)
ax.plot(x,T_n)
ax.plot(x,T_analytical, 'x')
plt.show()
print('\n Done.\n')