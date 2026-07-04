#!/usr/bin/env python
# coding: utf-8

# In[1]:


from rounded_step_gen import rounded_step_gen
from numpy import linspace
from matplotlib.pyplot import (figure, plot, grid, show,
   xlabel, ylabel)


# In[2]:


tt  = linspace(0,10,800)

st0  = 0.0
t1   = 0.25
t3   = 2

stepp = [st0,t1,t3]

fa   = []
dfa  = []
ddfa = []


# In[3]:


for t in tt:
    f,df,ddf = rounded_step_gen(t,stepp)
    fa.append(f)
    dfa.append(df)
    ddfa.append(ddf)


# In[4]:


# %matplotlib qt5

figure(1)
plot(tt,fa)
xlabel(r'$t$ (s)')
ylabel(r'rounded step function $f(t)$')
grid(True)
show()

figure(2)
plot(tt,dfa)
grid(True)
xlabel(r'$t$ (s)')
ylabel(r'$\dot{f}(t)$')
show()

figure(3)
plot(tt,ddfa)
grid(True)
xlabel(r'$t$ (s)')
ylabel(r'$\ddot{f}(t)$')
show()

