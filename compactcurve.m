tnow = datetime(2019,02,2,00,00,00);
% (2019,02,1,12,18,00);
blr_lla = [17.513570, 78.309134, 0];
wgs84 = wgs84Ellipsoid('meter');
i=0;
Su = cell(1,2);
Sat = cell(1,2);
Sh = cell(1,2);
a = 0.07;
dx = 0.001;

x = [1 -1];
y = [-1 1];
z = [0 0
    0 0];
pbaspect([1 1 1])
set(gca,'XColor', 'none','YColor','none')


scatter(0,0,100,'r','fill');
hold on
scatter(a,0,100,'g','fill');
hold on
t = text(a+dx,0+dx, cellstr('East'));
t.FontSize= 12;
scatter(0,a,100,'b','fill');
hold on
t = text(0+dx,a+dx, cellstr('North'));
t.FontSize= 12;
grid on
grid minor
p = [0,0,a];
p_k = p/norm(p);
mths = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};

highlihghtmonths = [2 3  4 5];
for month = 1:12
    tnow = datetime(2019,month,1,00,00,00);
    i=1;
    mflag = 0;
    x = zeros(40,1);
    y = zeros(40,1);
    for hr = 6:1:17
        for min = 0:15:59
            for sec = 0:60:59
                time = tnow+hours(hr)+minutes(min)+seconds(sec);%+minutes(mi);
                X = datevec(time);
                disp(time);
                jdate = juliandate(time);
                [r,d,s,sun_ecef]=sun2(jdate);
                r_ecef = lla2ecef(blr_lla);

                %d = (a/norm(r_ecef))*r_ecef - (   (a*norm(r_ecef))/(  dot(sun_ecef, r_ecef) -  norm(r_ecef)*norm(r_ecef) )   )*sun_ecef;
                [s_e,s_n,s_up]=ecef2enu(sun_ecef(1),sun_ecef(2),sun_ecef(3),blr_lla(1),blr_lla(2),blr_lla(3),wgs84);
                sun = [s_e,s_n,s_up];
                sun_k = sun/norm(sun);
                shadow = p - (a/dot(sun_k,p_k)) * sun_k;
                if shadow(1)>-.15 && shadow(1)<.15 && shadow(2)>-.15 && shadow(2)<.15
                    disp(shadow)
%                   scatter(shadow(1),shadow(2),10,'b','fill');xlim([-.15 .15]);ylim([ 0 0.1]);box on;
                    x(i)=shadow(1);
                    y(i)=shadow(2);
                    if any(highlihghtmonths(:)==month)
                        scatter(shadow(1),shadow(2),50,'b','fill');xlim([-.15 .15]);ylim([ 0 0.1]);box on;
                        t = text(shadow(1)+dx,shadow(2)+dx, cellstr(num2str(X(4))));
                        t.FontSize= 12;
                        t = text(shadow(1)+dx,shadow(2)-2*dx, cellstr(num2str(X(5))));
                        t.FontSize= 10;
                    end
                    if mflag==0
                        t = text(shadow(1)+dx,shadow(2)+5*dx, cellstr(mths(month)));
                        t.FontSize= 12;
                        mflag=1;
                    end
                    i = i+1;
                end
                
                str = datestr(datevec(time));
                %Sh{i,1} = {str }; Sh{i,2} ={shadow(1),shadow(2)};
            end
        end
    end
    disp(i)
    i = i-1;
    if any(highlihghtmonths(:)==month)
        plot(x(1:i,1),y(1:i,1));
    else
        plot(x(1:i,1),y(1:i,1),'--');
    end
    hold on
end


set(gca,'XColor', 'none','YColor','none')

% surf(x,y,z) 
hold on
axis equal
hold off
writetable(cell2table(Su),'satellite_sun_data.csv');
writetable(cell2table(Sat),'satellite_sat_data.csv');
writetable(cell2table(Sh),'satellite_shadow_data.csv');