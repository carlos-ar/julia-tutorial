using Plots
n_points = 101;

x = range(-2*pi,2*pi, n_points);
# y = [sin(i) for i in x]
y = sin.(x);

plot(x,y)