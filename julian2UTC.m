function [ t ] = julian2UTC( jdate, timeZoneCompensation )
%JULIAN2UTC Summary of this function goes here
%   Detailed explanation goes here
t = datetime(jdate,'convertfrom','juliandate');
t.TimeZone = '+00:00';
t.TimeZone = timeZoneCompensation;
t = datevec(t);
end

