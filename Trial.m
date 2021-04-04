% Trial Of our Functions

%kqj=[kxj;kyj;kthetaj];
%jqi=[jxi;jyi;jthetai];
kqj=[2;3;pi/3];
jqi=[4;3;pi/4];

kqi= pls(kqj,jqi);
iqj=inverse(jqi);

A=operator(kqj,kqi);
B=minsoperat(jqi,iqj);
Ckqj=[3, 1, 6;...
      1, 5, 4;...
      6, 4, 8];
  Cjqi=[5, 3, 4;...
        3, 1, 7;...
        4, 7, 6];
    Ckj=zeros(3,3);
    C=[Ckqj Ckj;...
        Ckj  Cjqi];
    Cki=A*C*A';
    Cij=B*Cjqi*B';
    Cji=B*Cij*B';
   