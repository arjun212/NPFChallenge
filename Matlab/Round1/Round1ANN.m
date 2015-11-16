clear;
load('round1TDailyData.mat');
x=table2array(round1TDailyData(:,[2 3 4 5 8 11 12 13 14]));
vol=table2array(round1TDailyData(:,9));
time=datetime(table2array(round1TDailyData(:,1)));


%   X = 2xTS cell, 2 inputs over TS timsteps
%   Each X{1,ts} = 9xQ matrix, input #1 at timestep ts.
%   Each X{2,ts} = 1xQ matrix, input #2 at timestep ts.
%
%   Xi = 2x2 cell 2, initial 2 input delay states.
%   Each Xi{1,ts} = 9xQ matrix, initial states for input #1.
%   Each Xi{2,ts} = 1xQ matrix, initial states for input #2.



call function
% 
% %mape
% rowsInTest=find(~isnan(tr.testMask{1}));
% 
% inputTestVol = vol(rowsInTest,:);
% outputTestVol = y(:,rowsInTest)';
% APE = mean(abs((outputTestVol-inputTestVol))./inputTestVol)*100;
% 
% 
% figure
% plot(time,y,time,vol);
% legend('Acutal','Predicted');
% title(strcat('ANN Model','(MAPE=',num2str(MAPE),'%)'));
% ylabel('Gas Consumption (kWh)')
