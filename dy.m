%Residuals Computation
function out=dy(x,lbd,xb,yb)
out= lbd-(atan2(yb-x(2),xb-x(1))-x(3));
end