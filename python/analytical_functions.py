#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 29 13:41:52 2023

@author: carlosar
"""

import numpy as np

def inf_sum(x,t):
    '''
    Infinite sum in analytical solution approximated with max k sum
    terms or if the term is below some tolerance 
    '''
    tol = 10.**(-10.)
    k = 1
    max_k = 100
    eps = 1.
    f = 0.
    f_old = 1.0
    T = 0.
    while (eps > tol) and (k<max_k):
        A = ((2*k)-1)
        f = (4/(A*np.pi))*(np.sin(A*np.pi*x))*np.exp(-(A)**2*np.pi**2*t)        
        T = T+f
        eps = np.max(np.abs(T-f_old))
        k = k+1
        f_old = T
    return T