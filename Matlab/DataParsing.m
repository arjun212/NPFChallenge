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
for idx=1:1:r
    %finding the rows for each day
    date=table2array(uiqueDates(idx,1));
    repeatedVals=ismissing(completeData,{datenum(datetime(date,'InputFormat','dd/MM/yyyy'))});
    dayVals=completeData(any(repeatedVals,2),:);
    %averaging daily values and adding
    aveDayVals=mean(table2array(dayVals(:,2:end)),1);
    aveArray=[aveArray;aveDayVals];
end
%hourly table for all, EXCEPT DAY TYPE, data
round1TDailyData=[uiqueDates array2table(aveArray) round1training1of2(:,5) round1training1of2(:,2:4)];
%round1TDailyData(:,9)=[];%removing DateTime Column
round1TDailyData(:,2)=[];%removing Time Column

%Adding variable names and units in table
round1TDailyData.Properties.VariableNames={'Date' 'Temperature' 'CloudCover' 'WindSpeed' 'RelativeHumidity'...
    'AtmosphericPrecipitation' 'SolarRadiation' 'DateNum' 'Volume' 'TypeOfDay' 'SchoolHoliday' 'Winter'};
round1TDailyData.Properties.VariableUnits={'mm/dd/yyy' 'degC' 'Okta' 'm/s' '%'...
    'mm' 'KJ/m^2' 'N/A' 'kWh' 'N/A' 'Y,N' 'Y,N'};

save('round1TDailyData','round1TDailyData')