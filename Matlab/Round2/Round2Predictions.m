clear;
load('round2SimpleANNFinal.mat')
load('round2FDailyData.mat');
x1=table2array(round2FDailyData(:,[2 7 1 8]))';

view(net);
x2 = preparets(net,x1);
yc = net(x2);

ys=smooth(cell2mat(yc));

figure
plot(cell2mat(yc)','b');hold all;plot(ys,'r');
legend('Predicted','Smoothed Predcited');
title(strcat('Simple ANN Model'))
ylabel('Gas Consumption (kWh)')


%checking the data trend
load('round2training1of2');
y=table2array(round2training1of2(:,end));

[r,c]=size(y);

yPred=[[zeros(r,1)];ys];

figure

plot(yPred,'r');hold all; plot(y,'b')
legend('Predicted','Acutal');
