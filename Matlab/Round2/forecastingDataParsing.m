clear;
load('round2forecast1of2.mat');
load('round2forecast2of2.mat');

dates1=datetime(round2forecast1of2{:,1},'InputFormat','dd/MM/yyyy');
dates2=datetime(round2forecast2of2{:,1},'InputFormat','dd/MM/yyyy');
round2FDailyData=[];
for i=1:numel(dates1)
    date=dates1(i);
    relevantDataFrom2of2=round2forecast2of2{dates2==date,3:end};
    aveDataFrom2of2=mean(relevantDataFrom2of2,1);
    aveDataFrom1of2=[dayValue(table2array(round2forecast1of2(i,2))) round2forecast1of2{i,3:4}];
    round2FDailyData=[round2FDailyData ; [datenum(date) aveDataFrom2of2 , aveDataFrom1of2]];
end

round2FDailyData=array2table(round2FDailyData);
round2FDailyData.Properties.VariableNames={'DateNum' 'Temperature' 'CloudCover' 'WindSpeed' 'RelativeHumidity'...
    'Ave_Atmospheric_Precipitation' 'Ave_SolarRadiation' 'DayType' 'SchoolHoliday' 'Winter'};
round2FDailyData.Properties.VariableUnits={'N/A' 'degC' 'Okta' 'm/s' '%'...
    'mm' 'KJ/m^2' 'N/A' 'Y,N' 'Y,N' };

save('round2FDailyData','round2FDailyData')