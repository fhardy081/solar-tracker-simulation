close all
clear

% Perhitungan Sudut Penjejak Matahari
% References: Karafil, et. al (2015)
% Input Latitude and Longtitude (Cepu, East Java)
lat = -7.139771761295103;
longt = 111.57987994718926;

% Input Current Date and time
d = datetime('now','TimeZone','UTC+7','Format','dd/MM/yyyy HH:mm:ss'); % convert t to dd/mm/yyyy and hh:mm:ss

% Declination Angle
% n = day(d,'dayofyear'); % change c format of dd/mm/yyyy to day of year only
n = 168; 
decl = 23.45*sind((360*(284+n))/365);

% Hour Angle Calculation
T_utc = 7; % UTC zone for West Indonesia (Java, Sumatra, West Kalimantan)
LSTM = T_utc * 15; % local standard meridian time
B = 360/365 * (n-81); % calculate B parameter
eot = 9.87 * sind(2*B) - 7.53 * cosd(B) - 1.5 * sind(B); % equation of time
TC = 4 * (longt - LSTM) + eot; % time correction factor

% Create a vector of times from 6am to 6pm with an interval of every 60 minutes
time_vector = linspace(6,18,13);

% Initialize arrays for each variable
ha_array = zeros(size(time_vector));
zth_array = zeros(size(time_vector));
alt_array = zeros(size(time_vector));
azth_array = zeros(size(time_vector));
ns_tilt_array = zeros(size(time_vector));
ew_tilt_array = zeros(size(time_vector));

for i = 1:length(time_vector)
    lt_decimalHours = time_vector(i); % set the time to the current time in the loop
    lst = lt_decimalHours + TC/60; % calculate local solar time
    ha = 15 * (lst - 12); % calculate hour angle
    
    % Azimuth, Altitude, Zenith Angle
    zth = acosd((sind(decl)*sind(lat))+(cosd(ha)*cosd(decl)*cosd(lat))); % zenith
    alt = 90 - zth; % altitude/elevation    
    if ha < 0 % azimuth if hour angle < 0
        azth = acosd((sind(decl)*cosd(lat)-cosd(decl)*sind(lat)*cosd(ha))/cosd(alt));
    elseif ha >= 0 % azimuth if hour angle > 0
        azth = 360 - acosd((sind(decl)*cosd(lat)-cosd(decl)*sind(lat)*cosd(ha))/cosd(alt));
    end

    % PV tilt angle
    surf_azth = 0; % PV is headed north/due north
    ns_tilt = atand(tand(zth)*abs(cosd(azth-surf_azth)));
    ew_tilt = atand(tand(zth)*abs(cosd(surf_azth))); 
    
    if azth > 180
        ns_tilt = -ns_tilt;
    elseif azth < 180
        ew_tilt = -ew_tilt;
    end

%     % Make ns_tilt and ew_tilt negative if time is above 12
%     if lt_decimalHours > 12
%         ns_tilt = -ns_tilt;
%         ew_tilt = -ew_tilt;
%     end

    % Store the results in arrays
    ha_array(i) = ha;
    zth_array(i) = zth;
    alt_array(i) = alt;
    azth_array(i) = azth;
    ns_tilt_array(i) = ns_tilt;
    ew_tilt_array(i) = ew_tilt;
end


% Plot each variable against time
figure(1);
subplot(3,1,1)
plot(time_vector, zth_array);
xlabel('Time (hour)');
ylabel('Zenith angle (degree)');
title('Zenith angle vs. time');
grid on
grid minor

subplot(3,1,2)
plot(time_vector, alt_array);
xlabel('Time (hour)');
ylabel('Altitude angle (degree)');
title('Altitude angle vs. time');
grid on
grid minor

subplot(3,1,3)
plot(time_vector, azth_array);
xlabel('Time (hour)');
ylabel('Azimuth angle (degree)');
title('Azimuth angle vs. time');
grid on
grid minor

figure(2);
subplot(2,1,1)
plot(time_vector, ns_tilt_array);
xlabel('Time (hour)');
ylabel('N-S tilt angle (degree)');
title('N-S tilt angle vs. time');
grid on
grid minor

subplot(2,1,2)
plot(time_vector, ew_tilt_array);
xlabel('Time (hour)');
ylabel('E-W tilt angle (degree)');
title('E-W tilt angle vs. time');
grid on
grid minor

figure(3);
plot(time_vector, ha_array);
xlabel('Time (hour)');
ylabel('Hour angle (degree)');
title('Hour angle vs. time');
grid on
grid minor

% Create a matrix of the results
results = [time_vector', ha_array', zth_array', alt_array', azth_array', ns_tilt_array', ew_tilt_array'];

filename = 'solar_trajectory.xlsx';

writematrix(results, filename)