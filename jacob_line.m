function line=jacob_line(x,xb,yb)
line=[(yb-x(2)/((xb-x(1))^2+(yb-x(2))^2)),...
    (x(1)-xb)/((xb-x(1))^2+(yb-x(2))^2),-1];
end