tnow = datetime(2018,03,30,06,00,0);
i=0;j=0;
lat = 22.5390;
lon = 75.9114;
Su = cell(1,2);
Sat = cell(1,2);
Sh = cell(1,2);
isFound = 0;
for day = 0:5
    for ite = 60*0:1:60*12
        i = i+1;
        
        [sun, sat, shadow] = pathfinder(juliandate(tnow+hours(24*day)+minutes(ite)));
        if abs(shadow(1)-lat)<= 2 && abs(shadow(2)-lon)<= 5
        %if 1<2 
            j = j+1;
            disp('FOUND SOLUTION');
            isFound = 1;
            str = datestr(datevec(tnow+hours(24*day)+minutes(ite)));
            Su{j,1} = {str };Su{j,2}={sun(1),sun(2)};
            Sat{j,1} = {str}; Sat{j,2}= {sat(1),sat(2)};
            Sh{j,1} = {str }; Sh{j,2} ={shadow(1),shadow(2)};
            %disp([shadow(1)-lat;shadow(2)-lon]);
            %disp(str)
            %disp([sun, sat, shadow])

        end
        if(mod(i,10)==0)
        disp(i);
        end

    end
end
if(isFound==1)
    disp('HURRAY FOUND')
end
if(isFound==0)
    disp('NO LUCK')
end
writetable(cell2table(Su),'satellite_sun_data.csv');
writetable(cell2table(Sat),'satellite_sat_data.csv');
writetable(cell2table(Sh),'satellite_shadow_data.csv');