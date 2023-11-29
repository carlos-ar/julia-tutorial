import numpy as np
import matplotlib.pyplot as plt

n_points = 101

x = np.linspace(-2*np.pi,2*np.pi, n_points)
# y = [sin(i) for i in x]
y = np.sin(x)

fig, ax = plt.subplots(1,1, dpi=300)
ax.plot(x,y)

plt.show()