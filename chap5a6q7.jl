using Convex
using SpecialMatrices
using PyPlot
n = 6
m = 40
u = linspace(-1,1,m)
v = 1./(5+40*u.^2) + 0.1*u.^3 + 0.01*randn(m,1)

A = Vandermode(u')
A = A[:,m-n+[1:n]]
x = A/v
X = Variable(n)
p = minimize(norm(A*X - v,Inf))
solve!(p)

uu  = linspace(-1.1,1.1,1000)
ay = x[1]*ones(1,1000)
ay2 = X[1]*ones(1,1000)
for i in 2:n
    ay = ay*uu' + x[i]
    ay2 = ay2*uu' + X[i]
end

figure(1)
plot(uu,"-")
plot(u,"o-")
plot(uu,"-")
show()
