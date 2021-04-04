% Computing the inverse
function iqj=inverse(jqi)
iqj=[-jqi(1)*cos(jqi(3))-jqi(2)*sin(jqi(3));jqi(1)*sin(jqi(3))-jqi(2)*cos(jqi(3));-jqi(3)];
end