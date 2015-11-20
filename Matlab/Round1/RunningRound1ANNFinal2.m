clear;
load('round1FDailyData.mat');
load('Round1ANNFinal.mat');
load('round1TDailyData.mat');
load('round1answer.mat');

x1=[{table2array(round1TDailyData(end,2:8))'} num2cell(table2array(round1FDailyData(:,1:7))',1)];
[r,c]=size(x1);
t1=zeros(184,1)';
t1(1)=table2array(round1TDailyData(end,9));
t1=num2cell(t1);


% Closed-loop neural network
view(net)
netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
view(netc)
[xc,xic,aic,tc] = preparets(netc,x1,{},t1);
yc = netc(xc,xic,aic);
closedLoopPerformance = perform(netc,tc,yc);

plot(cell2mat(yc),'b');hold all; plot(table2array(round1answer(:,end)),'g')

MAPE = mean(abs((cell2mat(yc)'-table2array(round1answer(:,end)))./table2array(round1answer(:,end)))*100);

