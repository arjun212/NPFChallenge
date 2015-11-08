clear;
load('round1training1of2.mat');
load('round1training2of2.mat');

%Clean Up: Find, list and remove 'NaN' rows
missVals=ismissing(round1training2of2,{NaN}); %Finds cells with 'NaN'
round1training2of2(any(missVals,2),:)%lists rows with 'NaN'
completeData=round1training2of2(~any(missVals,2),:);%Removes rows with 'NaN'

%Inserting Units and naming/ descriptions
%%completeData.Properties.VariableUnits = {'mm/dd/yyyy' 's' 'c' 'd' 'e' 'f' 'g' 'h' 'i'};
completeData.Properties.VariableNames{end}='DateTime'; % Labelling the newly added column

%Calculating Average Values Per Day
completeData=[completeData table(datenum(table2array(completeData(:,1))))];% converting dates to numbers and inserting a new column in the table
uiqueDates=[unique(completeData(:,1),'first')]; %extracting unique rows from 'CompleteData'

[r,c]=size(uiqueDates);
aveArray=[];
sumRainfall=[];
sumSolarRad=[];
for idx=1:1:r
    %finding the rows for each day
    date=table2array(uiqueDates(idx,1));
    repeatedVals=ismissing(completeData,{datenum(datetime(date,'InputFormat','dd/MM/yyyy'))});
    dayVals=completeData(any(repeatedVals,2),:);
    %averaging daily values and adding
    aveDayVals=mean(table2array(dayVals(:,2:end)),1);
    sumRainfall=[sumRainfall  ;  sum(table2array(dayVals(:,7)))];
    sumSolarRad=[sumSolarRad  ;  sum(table2array(dayVals(:,8)))];
    aveArray=[aveArray;aveDayVals];
end

%hourly table for all, EXCEPT DAY TYPE, data
round1TDailyData=[uiqueDates array2table(aveArray) round1training1of2(:,5) round1training1of2(:,2:4) array2table(sumRainfall) array2table(sumSolarRad)];
round1TDailyData(:,2)=[];%removing Time Column


%Adding variable names and units in table
round1TDailyData.Properties.VariableNames={'Date' 'Temperature' 'CloudCover' 'WindSpeed' 'RelativeHumidity'...
    'Ave_Atmospheric_Precipitation' 'Ave_SolarRadiation' 'DateNum' 'Volume' 'TypeOfDay' 'SchoolHoliday' 'Winter' 'Cumulat_Rainfall' 'Cumulat_Solar_Rad'};
round1TDailyData.Properties.VariableUnits={'mm/dd/yyy' 'degC' 'Okta' 'm/s' '%'...
    'mm' 'KJ/m^2' 'N/A' 'kWh' 'N/A' 'Y,N' 'Y,N' 'mm' 'KJ/m^2'};

save('round1TDailyData','round1TDailyData')
