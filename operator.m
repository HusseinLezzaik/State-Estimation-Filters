% Jacobian for plus operator
function Jplus=operator(kqj,kqi)

Jplus=[1, 0, -(kqi(2)-kqj(2)), cos(kqj(3)), -sin(kqj(3)), 0; ...
       0, 1, (kqi(1)-kqj(1)), sin(kqj(3)), cos(kqj(3)), 0   ;...
       0, 0, 1, 0, 0, 1];
end