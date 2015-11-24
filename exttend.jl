using Convex
using PyPlot
function strategy_min(n,P)
    I = ones(1,n)
    u = Variable(n)
    p = minimize(maximum(P*u))
    p.constraints = [u>=0, I*u == 1]
    solve!(p)
    return p.optval
end
function strategy_max(n,P)
    I = ones(1,n)
    u = Variable(n)
    p = maximize(minimum(P'*u))
    p.constraints = [u>=0, I*u == 1]
    solve!(p)
    return p.optval
end

times = 20
a = zeros(times)
b = zeros(times)
for i in 1:times
    n = 10+i
    m = 10+i
    P = randn(n,m)
    a[i] = round(strategy_min(n,P),4)
    b[i] = round(strategy_max(n,P),4)
end
figure(1)
x = linspace(1,times,times)
bar(x,a,0.3,color = "green",label="Opt P1")
bar(x+0.35,b,0.3,color ="red",label="Opt P2")
xlabel("n")
ylabel("Optimal value")
legend(loc ="best")
grid("on")
show()
