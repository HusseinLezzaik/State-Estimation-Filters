function H = jacob(x,xb,yb)
    for i=1:length(xb),
    H(i,:)=jacob_line(x,xb(i),yb(i));
    end;
end