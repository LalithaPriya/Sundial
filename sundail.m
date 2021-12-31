tnow = datetime(2019,02,1,00,00,00);
% (2019,02,1,12,18,00);
i=0;
Su = cell(1,2);
Sat = cell(1,2);
Sh = cell(1,2);
for month = 1:1:12
    tnow = datetime(2019,month,1,00,00,00);
    for hr = 6:1:18
        for min = 0:60:59
            for sec = 0 % 0:10:60
                time = tnow+hours(hr)+minutes(min)+seconds(sec);%+minutes(mi);
                X = datevec(time);
                if X(4) < 6 || X(4) >19
                    break
                end
                i = i+1;disp(time);
                [sun, sat, shadow] = pathfinder(juliandate(time));
                str = datestr(datevec(time));
                Su{i,1} = {str }; Su{i,2}={sun(1),sun(2)};
                Sat{i,1} = {str}; Sat{i,2}= {sat(1),sat(2)};
                Sh{i,1} = {str }; Sh{i,2} ={shadow(1),shadow(2)};
            end
        end
    end
end
writetable(cell2table(Su),'satellite_sun_data.csv');
writetable(cell2table(Sat),'satellite_sat_data.csv');
writetable(cell2table(Sh),'satellite_shadow_data.csv');