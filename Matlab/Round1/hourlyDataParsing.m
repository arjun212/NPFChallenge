%% Creating Hourly data matrix
clear;
load('round1training1of2.mat');
load('round1training2of2.mat');

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

%Clean Up: Find, list and remove 'NaN' rows
missVals=ismissing(round1THourlyData,{NaN}); %Finds cells with 'NaN'
round1THourlyData(any(missVals,2),:);%lists rows with 'NaN'
round1THourlyData=round1THourlyData(~any(missVals,2),:);%Removes rows with 'NaN'

save('round1THourlyData','round1THourlyData')

