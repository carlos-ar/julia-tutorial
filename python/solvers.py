#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 29 14:16:50 2023

@author: carlosar
"""

def trid(a,b,c,Told,N):
    Tnew = [0.]*N
    beta = [0.]*N
    gamma = [0.]*N
    beta[0] = b[0]
    gamma[0] = Told[0]/beta[0]

    for k in range(1,N):
        beta[k] = b[k] - a[k]*c[k-1]/beta[k-1]
        gamma[k] = (-a[k]*gamma[k-1]+Told[k])/beta[k]

    Tnew[N-1] = gamma[N-1]
    for kk in range(N-2,-1,-1):
        Tnew[kk] = gamma[kk] - Tnew[kk+1]*c[kk]/beta[kk]
        
    return Tnew
            
            