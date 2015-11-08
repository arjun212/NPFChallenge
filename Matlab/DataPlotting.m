%%
%plots data
clear
load('round1TDailyData.mat')
%%
%quantitative data

%Normalising variables
numData=table2array(round1TDailyData(:,2:end-3));
mu=mean(numData,1);
sd=(var(numData,0,1)).^0.5;
[r,c]=size(numData);
normData=zeros(r,c);
for i=1:1:r
    for j=1:1:c
        normData(i,j)=(numData(i,j)-mu(j))/(sd(j));
    end
end
%%
%Qualitative data

%Type of day
dayType=table2array(round1TDailyData(:,10));
qualData=zeros(731,1);
for idx = 1:numel(dayType)
   qualData(idx)=dayValue(cellstr(dayType(idx)));
end
round1TDailyData(:,10)
qualData=[qualData table2array(round1TDailyData(:,11:12))];


%School holiday
schoolHoliday=table2array(round1TDailyData(:,11));
noOfOccour = [sum(qualData(:,2)== 1) sum(qualData(:,2)== 0)];

schoolHolYes=0;
schoolHolNo=0;
for i=1:1:numel(schoolHoliday)
    if schoolHoliday(i)== 1
        schoolHolYes=(schoolHolYes+numData(i,8))/2;
    else
        schoolHolNo=(schoolHolNo+numData(i,8))/2;
    end
end
bar([1 0],[schoolHolYes schoolHolNo]);

%Winter
winter=table2array(round1TDailyData(:,12));
noOfOccour = [sum(qualData(:,2)== 1) sum(qualData(:,2)== 0)];

winterYes=0;
winterNo=0;
for i=1:1:numel(winter)
    if winter(i)== 1
        winterYes=(winterYes+numData(i,8))/2;
    else
        winterNo=(winterNo+numData(i,8))/2;
    end
end




%%
%Plotting volume vs time

figure
plot(datetime(table2array(round1TDailyData(:,1))),normData);
legend('Temperature','Cloud Cover','Wind Speed', 'Relative Humidity', 'Precipitation', 'Solar Radiation' ,'Volume')
ylabel('Normalised')


figure

subplot(3,3,1)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,1),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Temperature vs Volume')
ylabel('Normalised')
legend('Temperature','Volume')

subplot(3,3,2)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,2),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Cloud Cover vs Volume')
ylabel('Normalised')
legend('Cloud Cover','Volume')

subplot(3,3,3)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,3),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Wind Speed vs Volume')
ylabel('Normalised')
legend('Wind Speed','Volume')

subplot(3,3,4)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,4),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Relative Humidity vs Volume')
ylabel('Normalised')
legend('Relative Humidity','Volume')

subplot(3,3,5)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,5),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Atmospheric Precipitation vs Volume')
ylabel('Normalised')
legend('Atmospheric Precipitation','Volume')

subplot(3,3,6)
plot(datetime(table2array(round1TDailyData(:,1))),normData(:,6),datetime(table2array(round1TDailyData(:,1))),normData(:,8),'k')
title('Solar Radiation vs Volume')
ylabel('Normalised')
legend('Solar Radiation','Volume')

subplot(3,3,7)
title('Weekday');

subplot(3,3,8)
title('winter')
bar([1 0],[winterYes winterNo]);

subplot(3,3,9)
title('School')
bar([1 0],[schoolHolYes schoolHolNo]);

%%
%Plotting scatter graphs 

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