#!/usr/bin/env python 

import matplotlib.pyplot as plt
import numpy as np

x = [0,1,2,3,4,5,6]
y = [0,1,2,3,4,6,6]

plt.plot(x, y)


t = np.arange(0.0, 2.0, 0.01)
s = np.sin(2*np.pi*t)
plt.plot(t, s)

plt.xlabel('time (s)')
plt.ylabel('voltage (mV)')
plt.grid(True)
plt.savefig("test.png")
plt.show()

