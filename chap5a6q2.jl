using Convex
using PyPlot
function LPstrategy_P1(n,m,P)
    u = Variable(n)
    t = Variable()
    p = minimize(t)
    p.constraints = [u >= 0,ones(1,n)*u == 1,P'*u <= t*ones(m,1)]
    solve!(p)
    return p.optval
end
function LPstrategy_P2(n,m,P)
    v = Variable(m)
    t = Variable()
    p = maximize(t)
    p.constraints = [v>= 0 , ones(1,m)*v == 1, P*v >= t*ones(n,1)]
    solve!(p)
    return p.optval
end

n = 12
m = 12
times = 20
a = zeros(times)
b = zeros(times)
for i in 1:times
    n = 10+i
    m = 10+i
    P = randn(n,m)
    a[i] = LPstrategy_P1(n,m,P)
    b[i] = LPstrategy_P2(n,m,P)
end
#------------------------------------#
figure(1)
x = linspace(1,times,times)
bar(x,a,0.3,color = "green",label="Opt P1")
bar(x+0.35,b,0.3,color ="red",label="Opt P2")
xlabel("(n,m|n=m)")
ylabel("Optimal value")
legend(loc ="best")
grid("on")
show()


