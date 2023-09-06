close all
clc

% How to get control system response data
% 1. Run 'param.m'
% 2. Run 'sim_baru2.slx'
% 3. Run 'response.m' 

%% Get data from simulink
t = out.time(:,1);

sp1 = out.sp1(:,1);
y1 = out.Fuzzy1_NS_5MF(:,1);
y2 = out.Fuzzy2_NS_2_5MF(:,1);
y3 = out.Fuzzy2_NS_4_5MF(:,1);
y4 = out.Fuzzy2_NS_6_5MF(:,1);
y5 = out.Fuzzy1_NS_7MF(:,1);
y6 = out.Fuzzy2_NS_2_7MF(:,1);
y7 = out.Fuzzy2_NS_4_7MF(:,1);
y8 = out.Fuzzy2_NS_6_7MF(:,1);

sp2 = out.sp2(:,1);
y9 = out.Fuzzy1_EW_5MF(:,1);
y10 = out.Fuzzy2_EW_2_5MF(:,1);
y11 = out.Fuzzy2_EW_4_5MF(:,1);
y12 = out.Fuzzy2_EW_6_5MF(:,1);
y13 = out.Fuzzy1_EW_7MF(:,1);
y14 = out.Fuzzy2_EW_2_7MF(:,1);
y15 = out.Fuzzy2_EW_4_7MF(:,1);
y16 = out.Fuzzy2_EW_6_7MF(:,1);

%% Graph
% Plot System Response for N-S Tilt Angle with 5 Membership Function
figure(1)
plot(t,sp1)
hold on
plot(t,y1)
hold on
plot(t,y2)
hold on
plot(t,y3)
hold on
plot(t,y4)
grid on
grid minor
xlabel('Time (s)');
ylabel('N-S tilt angle (degree)');
title('Dual Axis Solar Tracker System Response (N-S tilt angle) with 5 MF')
legend('Setpoint','Type-1 FLC','Type-2 FLC FOU 0.2','Type-2 FLC FOU 0.4','Type-2 FLC FOU 0.6')

% Plot System Response for N-S Tilt Angle with 7 Membership Function
figure(2)
plot(t,sp1)
hold on
plot(t,y5)
hold on
plot(t,y6)
hold on
plot(t,y7)
hold on
plot(t,y8)
grid on
grid minor
xlabel('Time (s)');
ylabel('N-S tilt angle (degree)');
title('Dual Axis Solar Tracker System Response (N-S tilt angle) with 7 MF')
legend('Setpoint','Type-1 FLC','Type-2 FLC FOU 0.2','Type-2 FLC FOU 0.4','Type-2 FLC FOU 0.6')

% Plot System Response for E-W Tilt Angle with 5 Membership Function
figure(3)
plot(t,sp2)
hold on
plot(t,y9)
hold on
plot(t,y10)
hold on
plot(t,y11)
hold on
plot(t,y12)
grid on
grid minor
xlabel('Time (s)');
ylabel('N-S tilt angle (degree)');
title('Dual Axis Solar Tracker System Response (E-W tilt angle) with 5 MF')
legend('Setpoint','Type-1 FLC','Type-2 FLC FOU 0.2','Type-2 FLC FOU 0.4','Type-2 FLC FOU 0.6')

% Plot System Response for E-W Tilt Angle with 7 Membership Function
figure(4)
plot(t,sp2)
hold on
plot(t,y13)
hold on
plot(t,y14)
hold on
plot(t,y15)
hold on
plot(t,y16)
grid on
grid minor
xlabel('Time (s)');
ylabel('N-S tilt angle (degree)');
title('Dual Axis Solar Tracker System Response (E-W tilt angle) with 7 MF')
legend('Setpoint','Type-1 FLC','Type-2 FLC FOU 0.2','Type-2 FLC FOU 0.4','Type-2 FLC FOU 0.6')

%% Info
% N-S tilt angle
st1 = stepinfo(y1,t); % Type-1 FLC 5MF for N-S Tilt Angle
st2 = stepinfo(y2,t); % Type-2 FLC 5MF for N-S Tilt Angle (FOU 0.2)
st3 = stepinfo(y3,t); % Type-2 FLC 5MF for N-S Tilt Angle (FOU 0.4)
st4 = stepinfo(y4,t); % Type-2 FLC 5MF for N-S Tilt Angle (FOU 0.6)
st5 = stepinfo(y5,t); % Type-1 FLC 7MF for N-S Tilt Angle
st6 = stepinfo(y6,t); % Type-2 FLC 7MF for N-S Tilt Angle (FOU 0.2)
st7 = stepinfo(y7,t); % Type-2 FLC 7MF for N-S Tilt Angle (FOU 0.4)
st8 = stepinfo(y8,t); % Type-2 FLC 7MF for N-S Tilt Angle (FOU 0.6)

% E-W tilt angle
st9 = stepinfo(y9,t); % Type-1 FLC 5MF for E-W Tilt Angle
st10 = stepinfo(y10,t); % Type-2 FLC 5MF for E-W Tilt Angle (FOU 0.2)
st11 = stepinfo(y11,t); % Type-2 FLC 5MF for E-W Tilt Angle (FOU 0.4)
st12 = stepinfo(y12,t); % Type-2 FLC 5MF for E-W Tilt Angle (FOU 0.6)
st13 = stepinfo(y13,t); % Type-1 FLC 7MF for E-W Tilt Angle
st14 = stepinfo(y14,t); % Type-2 FLC 7MF for E-W Tilt Angle (FOU 0.2)
st15 = stepinfo(y15,t); % Type-2 FLC 7MF for E-W Tilt Angle (FOU 0.4)
st16 = stepinfo(y16,t); % Type-2 FLC 7MF for E-W Tilt Angle (FOU 0.6)

%% steady state error
ste1 = ((abs((y1(end) - sp1(end))))/sp1(end))*100;
ste2 = ((abs((y2(end) - sp1(end))))/sp1(end))*100;
ste3 = ((abs((y3(end) - sp1(end))))/sp1(end))*100;
ste4 = ((abs((y4(end) - sp1(end))))/sp1(end))*100;
ste5 = ((abs((y5(end) - sp1(end))))/sp1(end))*100;
ste6 = ((abs((y6(end) - sp1(end))))/sp1(end))*100;
ste7 = ((abs((y7(end) - sp1(end))))/sp1(end))*100;
ste8 = ((abs((y8(end) - sp1(end))))/sp1(end))*100;
ste9 = ((abs((y9(end) - sp1(end))))/sp1(end))*100;
ste10 = ((abs((y10(end) - sp2(end))))/sp2(end))*100;
ste11 = ((abs((y11(end) - sp2(end))))/sp2(end))*100;
ste12 = ((abs((y12(end) - sp2(end))))/sp2(end))*100;
ste13 = ((abs((y13(end) - sp2(end))))/sp2(end))*100;
ste14 = ((abs((y14(end) - sp2(end))))/sp2(end))*100;
ste15 = ((abs((y15(end) - sp2(end))))/sp2(end))*100;
ste16 = ((abs((y16(end) - sp2(end))))/sp2(end))*100;