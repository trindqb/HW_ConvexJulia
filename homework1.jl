using Convex
n = 10
m = 10
c = ones(1,n)
P = randn(n,m)
u = Variable(n)
p = minimize(maximum(P*u))
p.constraints = [u >= 0,c*u == 1]
solve!(p)
#------------------------------------#
c2 = ones(1,m)
v = Variable(m)
p2 = maximize( minimum(P'*v) )
p2.constraints = [v>= 0 , c2*v == 1]
solve!(p2)


println([p.optval p2.optval])
println("They are EQUAL as expected!")