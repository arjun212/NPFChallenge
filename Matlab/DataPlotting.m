%Plotting
clear
load('round1TDailyData.mat')

%variables
data=table2array(round1TDailyData(:,2:end-3));

figure

subplot(3,2,1)
scatter(data(:,1),data(:,8),'.')
title('Temperature vs Volume')
ylabel('Volume')
xlabel('Temperature')

subplot(3,2,2)
scatter(data(:,2),data(:,8),'.')
title('Cloud Cover vs Volume')
ylabel('Volume')
xlabel('Cloud Cover')

subplot(3,2,3)
scatter(data(:,3),data(:,8),'.')
title('Wind Speed vs Volume')
ylabel('Volume')
xlabel('Wind Speed')

subplot(3,2,4)
scatter(data(:,4),data(:,8),'.')
title('Relative Humidity vs Volume')
ylabel('Volume')
xlabel('Relative Humidity')

subplot(3,2,5)
scatter(data(:,5),data(:,8),'.')
title('Atmospheric Precipitation vs Volume')
ylabel('Volume')
xlabel('Atmospheric Precipitation')

subplot(3,2,6)
scatter(data(:,6),data(:,8),'.')
title('Solar Radiation vs Volume')
ylabel('Volume')
xlabel('Solar Radiation')

%Normalising variables
data=table2array(round1TDailyData(:,2:end-3));
mu=mean(data,1);
sd=(var(data,0,1)).^0.5;
[r,c]=size(data);
normData=zeros(r,c);
for i=1:1:r
    for j=1:1:c
        normData(i,j)=(data(i,j)-mu(j))/(sd(j));
    end
end

figure
plot(datetime(table2array(round1TDailyData(:,1))),normData);
legend('Temperature','Cloud Cover','Wind Speed', 'Relative Humidity', 'Precipitation', 'Solar Radiation' ,'Volume')
ylabel('Normalised')


figure

subplot(3,2,1)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,1),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Temperature vs Volume')
ylabel('Normalised')
legend('Temperature','Volume')

subplot(3,2,2)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,2),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Cloud Cover vs Volume')
ylabel('Normalised')
legend('Cloud Cover','Volume')

subplot(3,2,3)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,3),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Wind Speed vs Volume')
ylabel('Normalised')
legend('Wind Speed','Volume')

subplot(3,2,4)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,4),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Relative Humidity vs Volume')
ylabel('Normalised')
legend('Relative Humidity','Volume')

subplot(3,2,5)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,5),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Atmospheric Precipitation vs Volume')
ylabel('Normalised')
legend('Atmospheric Precipitation','Volume')

subplot(3,2,6)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,6),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Solar Radiation vs Volume')
ylabel('Normalised')
legend('Solar Radiation','Volume')

