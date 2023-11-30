function inf_sum(x, t)
    tol = 1e-10
    k = 1
    max_k = 100
    eps = 1.0
    f = 0.0
    f_old = 1.0
    T = 0.0
    
    while eps > tol && k < max_k
        A = 2k - 1
        f = (4 / (A * π)) * sin.(A * π * x) * exp(-(A)^2 * π^2 * t)
        T = T .+ f
        eps = maximum(abs.(T .- f_old))
        k += 1
        f_old = T
    end
    
    return T
end