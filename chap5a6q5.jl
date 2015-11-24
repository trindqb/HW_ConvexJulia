using Convex
using PyPlot

function QCQP(u)
    x = Variable()
    p = minimize(x^2 + 1)
    p.constraints = [(x^2 - 6*x + 8) <=u]
    solve!(p)
    return p.optval
end
n = 100
u = linspace(-0.9,10,n)
result = zeros(n)
for i in 1:n
    result[i] = QCQP(u[i])
end
print(result)
plot(u,result)
xlabel("u")
ylabel("f(u,x)")
grid("on")
show()
