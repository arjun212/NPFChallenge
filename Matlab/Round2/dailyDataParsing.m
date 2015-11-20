%% Creating dailyData matrix

clear;
load('round2training1of2.mat');
load('round2training2of2.mat');

%Clean Up: Find, list and remove 'NaN' rows
missVals=ismissing(round2training2of2,{NaN}); %Finds cells with 'NaN'
round2training2of2(any(missVals,2),:)%lists rows with 'NaN'
completeData=round2training2of2(~any(missVals,2),:);%Removes rows with 'NaN'

%Inserting Units and naming/ descriptions
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
    aveDayVals=mean(table2array(dayVals(:,3:end)),1);
    aveArray=[aveArray;aveDayVals];
end

%converting dayType to a number
[r,~]=size(aveArray);
day2Num=zeros(r,1);
for i=1:1:r
    day2Num(i)=dayValue(table2array(round2training1of2(i,2)));
end

%dailyData table
round2DailyData=[uiqueDates array2table(aveArray) array2table(day2Num) round2training1of2(:,3:5)];

%Adding variable names and units in table
round2DailyData.Properties.VariableNames={'Date' 'Temperature' 'CloudCover' 'WindSpeed' 'RelativeHumidity'...
    'Ave_Atmospheric_Precipitation' 'Ave_SolarRadiation' 'DateNum' 'TypeOfDay' 'SchoolHoliday' 'Winter' 'Volume'};
round2DailyData.Properties.VariableUnits={'mm/dd/yyy' 'degC' 'Okta' 'm/s' '%'...
    'mm' 'KJ/m^2' 'N/A' 'N/A' 'Y,N' 'Y,N' 'kWh'};

%splitting data into test and training sets

test2trainRatio=1-0.25;
noOfTrainData=round(r*test2trainRatio);
round2TDailyData=round2DailyData(1:noOfTrainData,:);
round2TestDailyData=round2DailyData(noOfTrainData:end,:);

save('round2TDailyData','round2TDailyData')
save('round2TestDailyData','round2TestDailyData')
