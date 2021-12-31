function [A] = SolveMyeqn(sat,sun,R)
A = zeros(0,0);
a = sat(1);b = sat(2);c = sat(3);
p = sun(1);q = sun(2);r = sun(3);
syms Y 
eqn = ((Y-b)*(p-a)/(q-b)+a)^2 + ((Y-b)*(r-c)/(q-b)+c)^2 - R^2 + Y^2 == 0;

y = solve(eqn,Y);
x = (y-b)*(p-a)/(q-b)+a;
z = (y-b)*(r-c)/(q-b)+c;
dr = [x y z];
if isreal(dr)
r1 = dis(dr(1,1),dr(1,2),dr(1,3),p,q,r);
r2 = dis(dr(2,1),dr(2,2),dr(2,3),p,q,r);
rs = dis(a,b,c,p,q,r);
if rs-r1>0
    %disp('SUN ON THE OTHER SIDE')
    1;
else
if r1-r2>0
    A = dr(2,:);
   % disp('Captured1')
else
    A = dr(1,:);
   % disp('Captured2')
end;
A = double(A);
end;

else
   % disp('SATELLITE DONT CAST SHADOW')
end;


