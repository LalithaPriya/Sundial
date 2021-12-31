function [ sun ,sat ,shadow ] = pathfinder( jdate )
%PATHFINDER Summary of this function goes here
%   Detailed explanation goes here
line1 = '1 25544U 98067A   18092.58230647  .00016717  00000-0  10270-3 0  9002';
line2 = '2 25544  51.6418  35.6273 0001906 298.9621  61.1340 15.54184119 26750';
%disp(jdate)
[sat,start,stop,del] = twoline2rv(84,line1,line2,jdate);
[satrec,sat_ecef,v]=spg4_ecf(sat,start);
[r,d,s,sun_ecef]=sun2(jdate);
earth_radius = 6371;

sun = ecef2lla(1000*sun_ecef);
sat = ecef2lla(1000*sat_ecef);
shadow = (SolveMyeqn(sat_ecef,sun_ecef,earth_radius));
if isempty(shadow)
    shadow = [0 0 0];
else
    shadow  = ecef2lla(1000*shadow);
    %disp('SUN ecef');
    %disp(ecef2lla(1000*sun_ecef))
    %disp('SAT ecef');
    %disp(ecef2lla(1000*sat_ecef))
    %disp('Shadow Loc');
    %disp(shadow)
end
end

