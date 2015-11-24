using Convex
using PyPlot
using Contour
using SCS
# passing in verbose=0 to hide output from SCS
solver = SCSSolver(verbose=0)
set_default_solver(solver);
function Utility(x,y)
    return (1.1 * sqrt(x) + 0.8 * sqrt(y)) / 1.9
end
data= [4.5e-01   9.6e-01
   2.1e-01   3.4e-01
   9.6e-01   3.0e-02
   8.0e-02   9.2e-01
   2.0e-02   2.2e-01
   0.0e+00   3.9e-01
   2.6e-01   6.4e-01
   3.5e-01   9.7e-01
   9.1e-01   7.8e-01
   1.2e-01   1.4e-01
   5.8e-01   8.4e-01
   4.9e-01   2.7e-01
   7.0e-02   8.0e-01
   9.3e-01   8.7e-01
   4.4e-01   8.6e-01
   3.3e-01   4.2e-01
   8.9e-01   9.0e-01
   4.9e-01   7.0e-02
   9.5e-01   3.3e-01
   6.6e-01   2.6e-01
   9.5e-01   7.3e-01
   4.2e-01   9.1e-01
   6.8e-01   2.0e-01
   5.2e-01   6.2e-01
   7.7e-01   6.3e-01
   2.0e-02   2.9e-01
   9.8e-01   2.0e-02
   5.0e-02   7.9e-01
   7.9e-01   1.9e-01
   6.2e-01   6.0e-02
   2.8e-01   8.7e-01
   6.9e-01   1.0e-01
   6.9e-01   3.7e-01
   0.0e+00   7.2e-01
   8.7e-01   1.7e-01
   6.3e-01   4.0e-02
   3.2e-01   7.3e-01
   4.0e-02   4.6e-01
   3.6e-01   9.5e-01
   8.2e-01   6.7e-01 ]
obj = [0.5,0.5]

figure(1)
plot(data[:,1],data[:,2],"o")
#show()
t = 0.01
X = collect(0:t:1)
Y = collect(0:t:1)
Z = [ ((1.1*x.^(1/2)+0.8*y.^(1/2))/1.9)::Float64 for x in X, y in Y]
h = linspace(0.1,1,10)
for i in 1:9
    ctlv = Contour.contour(X,Y,Z, h[i])
    xs,ys = coordinates(ctlv.lines[1])
    plot(xs,ys)
end
xlabel("x1")
ylabel("x2")
show()