using Convex
using PyPlot

function Lagar(n,W)
    nu = Variable(n)
    p = maximize(-sum(nu))
    p.constraints = [ W + diag(nu) >= 0,nu>=0]
    solve!(p)
    return p.optval
end
function SDP(n,W)
    X = Semidefinite(n,n)
    p = minimize(trace(W'*X))
    p.constraints = [diag(X) == 1, X>=0]
    solve!(p)
    return p.optval
end
n = 10

times = 20
result = ones(times)
result2 = ones(times)
for i in 1:times
    W = randn(n)
    W = 0.5*(W+W)
    result[i] = Lagar(n,W)
    result2[i] = SDP(n,W)
    n+=i
end
#------------------------------------plotting-------------------------#

figure(1)
x = linspace(1,times,times)
bar(x,result,0.3,color = "green",label="Opt P1")
bar(x+0.35,result2,0.3,color ="red",label="Opt P2")
xlabel("(n,m)+10")
ylabel("Optimal value")
legend(loc ="best")
grid("on")
show()