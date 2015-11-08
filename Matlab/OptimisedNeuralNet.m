% clear;
% load('round1TDailyData.mat');
% variables=table2array(round1TDailyData(:,[2 3 5 8 12 14]));
% vol=table2array(round1TDailyData(:,9));
% time=datetime(table2array(round1TDailyData(:,1)));
% 
% x = variables';
% t = vol';

clear;

load('round1TDailyData.mat');
variables=table2array(round1TDailyData(:,[2 3 5 8 12 14]));

y = myNeuralNetworkOptFunction(variables);


MAPE = mean(abs(transpose(e)./vol))*100;

figure
plot(time,y,time,vol);
legend('Acutal','Predicted');
title(strcat('ANN Model','(MAPE=',num2str(round(MAPE)),'%)'));
ylabel('Gas Consumption (kWh)')
