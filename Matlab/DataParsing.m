clear;
load('round1training1of2.mat');
load('round1training2of2.mat');

%%
%% Creating Hourly data matrix
[r,~]=size(round1training1of2);
dayToHour=[];
for i=1:1:r
    rows2Change=find(table2array(round1training2of2(:,1))==datetime(table2array(round1training1of2(i,1))));
    for col=3:1:5
        for row=1:1:numel(rows2Change)
        dayToHour(rows2Change(row),col-2)=table2array(round1training1of2(i,col));%add day type...cell2mat(table2array(repmat(round1training1of2(i,2),24,1)))
        end
    end
end

%convert date and time into one variable
DateTime=table2array(round1training2of2(:,1));
for i=1:1:numel(DateTime)
    vector=datevec(DateTime(i));
    vector(4)=round(table2array(round1training2of2(i,2))*24);
    date2Num(i)=datenum(vector);    
end
date2Num=transpose(date2Num);

round1THourlyData=[array2table(date2Num) round1training2of2(:,3:8) array2table(dayToHour)];
round1THourlyData.Properties.VariableNames={'DateNum' 'Temperature' 'CloudCover' 'WindSpeed' 'RelativeHumidity'...
    'Atmospheric_Precipitation' 'SolarRadiation' 'School' 'Winter' 'Volume'};

save('round1THourlyData','round1THourlyData')

%% Creating dailyData matrix

%Clean Up: Find, list and remove 'NaN' rows
missVals=ismissing(round1training2of2,{NaN}); %Finds cells with 'NaN'
round1training2of2(any(missVals,2),:)%lists rows with 'NaN'
completeData=round1training2of2(~any(missVals,2),:);%Removes rows with 'NaN'

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
    aveDayVals=mean(table2array(dayVals(:,2:end)),1);
    aveArray=[aveArray;aveDayVals];
end

%dailyData table
round1TDailyData=[uiqueDates array2table(aveArray) round1training1of2(:,5) round1training1of2(:,2:4)];
round1TDailyData(:,2)=[];%removing Time Column

%Adding variable names and units in table
round1TDailyData.Properties.VariableNames={'Date' 'Temperature' 'CloudCover' 'WindSpeed' 'RelativeHumidity'...
    'Ave_Atmospheric_Precipitation' 'Ave_SolarRadiation' 'DateNum' 'Volume' 'TypeOfDay' 'SchoolHoliday' 'Winter'};
round1TDailyData.Properties.VariableUnits={'mm/dd/yyy' 'degC' 'Okta' 'm/s' '%'...
    'mm' 'KJ/m^2' 'N/A' 'kWh' 'N/A' 'Y,N' 'Y,N' 'mm' 'KJ/m^2'};

%save('round1TDailyData','round1TDailyData')


