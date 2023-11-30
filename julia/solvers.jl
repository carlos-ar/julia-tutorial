function trid(a, b, c, Told)
    N = length(Told)
    Tnew = zeros(N)
    beta = zeros(N)
    gamma = zeros(N)
    
    beta[1] = b[1]
    gamma[1] = Told[1] / beta[1]

    for k in 2:N
        beta[k] = b[k] - a[k] * c[k-1] / beta[k-1]
        gamma[k] = (-a[k] * gamma[k-1] + Told[k]) / beta[k]
    end

    Tnew[N] = gamma[N]
    for kk in (N-1):-1:1
        Tnew[kk] = gamma[kk] - Tnew[kk+1] * c[kk] / beta[kk]
    end
    
    return Tnew
end