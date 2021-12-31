tnow = datetime(2018,04,6,14,6,0);
i=0;
Su = cell(1,2);
Sat = cell(1,2);
Sh = cell(1,2);

for ite = 0:90
    time = tnow+seconds(ite);
    i = i+1;disp(time);
    [sun, sat, shadow] = pathfinder(juliandate(time));
    str = datestr(datevec(time));
    Su{i,1} = {str };Su{i,2}={sun(1),sun(2)};
    Sat{i,1} = {str}; Sat{i,2}= {sat(1),sat(2)};
    Sh{i,1} = {str }; Sh{i,2} ={shadow(1),shadow(2)};
end
writetable(cell2table(Su),'satellite_sun_data.csv');
writetable(cell2table(Sat),'satellite_sat_data.csv');
writetable(cell2table(Sh),'satellite_shadow_data.csv');