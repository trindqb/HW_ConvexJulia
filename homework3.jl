using Convex
using PyPlot
n = [i+10 for i in 1:10]
rs1 = rs2 = rs3 = rs4 = rs5 = zeros(length(n))
for i in 1:length(n)
    m =2*n[i]
    A = randn(m,n[i])
    b = randn(m,1)
    p = 2
    q = p/(p-1)

    x = Variable(n[i])
    p1 = minimize(norm(A*x - b, p))
    p1.constraints = []
    solve!(p1)
    rs1[i] = p1.optval

    x2 = Variable(n[i])
    y2 = Variable(m)
    p2 = minimize(norm(y2,p))
    p2.constraints = [A*x2 - b == y2 ]
    solve!(p2)
    rs2[i] = p2.optval

    nu = Variable(m)
    p3 = maximize(b'*nu)
    p3.constraints = [norm( nu, q) <= 1, A'*nu == 0]
    solve!(p3)
    rs3[i] = p3.optval

    x4 = Variable(n[i])
    y4 = Variable(m)
    p4 = minimize(0.5*square( norm(y4, p)))
    p4.constraints = [A*x4 - b == y4]
    solve!(p4)
    rs4[i] = p4.optval

    nu2 = Variable(m)
    p5 = maximize(-0.5*square( norm(nu2,q) ) + b'*nu2 )
    p5.constraints = [ A'*nu2==0]
    solve!(p5)
    rs5[i] = p5.optval
end
#barchart
figure(1)
bar(n,rs1,0.05,color="red",label = "Original problem")
bar(n+0.15,rs2,0.05,color="green",label = "Ref1")
bar(n+0.25,rs3,0.05,color="yellow",label = "Dual_ref1")
bar(n+0.35,rs4,0.05,color="blue",label = "Ref2")
bar(n+0.45,rs5,0.05,color="cyan",label = "Dual_ref2")
xlabel("n")
ylabel("optimal value")
grid("on")
legend(loc = "best", fontsize = 8)
#linechart
figure(2)
plot(n, rs1,"ro-",label = "Original problem")
plot(n+0.08,rs2,"go-",label = "Ref1")
plot(n+0.16,rs3,"yo-",label = "Dual_ref1")
plot(n+0.24,rs4,"bo-",label = "Ref2")
plot(n+0.30,rs5,"co-",label = "Dual_ref2")
xlabel("n")
ylabel("optimal value")
grid("on")
legend(loc = "best", fontsize = 8)
show()