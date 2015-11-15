clear;
load('round1forecast1of2.mat');
load('round1forecast2of2.mat');

dates1=datetime(round1forecast1of2{:,1},'InputFormat','dd/MM/yyyy');
dates2=datetime(round1forecast2of2{:,1},'InputFormat','dd/MM/yyyy');
round1FDailyData=[];
for i=1:numel(dates1)
    date=dates1(i);
    relevantDataFrom2of2=round1forecast2of2{dates2==date,3:end};
    aveDataFrom2of2=mean(relevantDataFrom2of2,1);
    aveDataFrom1of2=round1forecast1of2{i,3:4};
    round1FDailyData=[round1FDailyData ; [datenum(date) aveDataFrom2of2 , aveDataFrom1of2]];
end


round1FDailyData=array2table(round1FDailyData);
round1FDailyData.Properties.VariableNames={'DateNum' 'Temperature' 'CloudCover' 'WindSpeed' 'RelativeHumidity'...
    'Ave_Atmospheric_Precipitation' 'Ave_SolarRadiation' 'SchoolHoliday' 'Winter'};
round1FDailyData.Properties.VariableUnits={'N/A' 'degC' 'Okta' 'm/s' '%'...
    'mm' 'KJ/m^2' 'Y,N' 'Y,N' };

save('round1FDailyData','round1FDailyData')