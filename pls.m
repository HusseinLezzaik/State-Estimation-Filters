%Computing the + operator

function kqi = pls(kqj,jqi)

kqi=[kqj(1)+jqi(1)*cos(kqj(3))-jqi(2)*sin(kqj(3)); kqj(2)+jqi(1)*sin(kqj(3))+jqi(2)*cos(kqj(3));kqj(3)+jqi(3)];
end

