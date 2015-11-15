%basic regression model for daily data:

clear;
load('round1TDailyData.mat');

variables=[table2array(round1TDailyData(:,2:7)),table2array(round1TDailyData(:,9))];
vol=table2array(round1TDailyData(:,8));

[b,bint,r,rint,stats]=regress(vol,variables);

volPred=variables*b;

MAPE = mean(abs(r./vol))*100;

figure
plot(datetime(table2array(round1TDailyData(:,1))),vol,...
    datetime(table2array(round1TDailyData(:,1))),volPred);
text(2,10,strcat('MAPE=',round(num2str(MAPE)),'%'),'FontSize',14);
legend('Acutal','Predicted');
title(strcat('Linear Regression Model','(MAPE=',num2str(round(MAPE)),'%)'));
ylabel('Gas Consumption (kWh)')