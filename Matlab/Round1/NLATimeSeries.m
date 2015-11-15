clear;
load('round1TDailyData.mat');
variables=table2array(round1TDailyData(:,[2 3 5 8 12 14]));
vol=table2array(round1TDailyData(:,9));
time=datetime(table2array(round1TDailyData(:,1)));

x = variables';
t = vol';