% Jacobian for minus
function Jminus= minus(jqi,iqj)
Jminus=[-cos(jqi(3)), -sin(jqi(3)), iqj(2);...
        sin(jqi(3)), -cos(jqi(3)), -iqj(1);...
        0, 0, -1];
end