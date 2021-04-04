%Beacons locations
xb=[0;10;10;0]; yb=[0;0;10;10];
%real pose of robot
xr=[6;6;pi/4];
%Measurement generation with noise
lbd=atan2(yb-xr(2),xb-xr(1))-xr(3)+randn(length(xb),1)*1/180*pi;
%Initial guess
x=[4;3;pi/2];
%Newton iteration
for iter=1:6,
    H = jacob(x,xb,yb);
    xnew=x+H\dy(x,lbd,xb,yb);
    if(norm(x-xnew)<1e-10),break,end;
    x=xnew;
    plot(xr(1),xr(2),'*');
    hold on
    plot(xb,yb,'*');
    plot(x(1),x(2),'o');
    hold off
   
  
end;
 



    

