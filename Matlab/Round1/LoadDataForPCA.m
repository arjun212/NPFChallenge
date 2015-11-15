
clear all;
close all;
clc;
load('round1training1of2.mat');
load('round1training2of2.mat');
load('round1TDailyData.mat')


% 1 - Temperature
% 2 - Cloud_Cover
% 3 - Wind_Speed
% 4 - Humidity
% 5 - Precipitation_Amount
% 6 - Solar_Radiation

%Initialise <Date, Volume> Hashmap
% keyset = datenum(table2array(round1training1of2(:, 1)));
% valueset = table2array(round1training1of2(:, 5));
% dateVolMap = containers.Map(keyset, valueset);
% ======
% yVol = []
% for i = 1:numel(round1training2of2(:,1))
%     yVol = [yVol dateVolMap(datenum(table2array(round1training2of2(i,1))))];
% end



%Hourly Data
dataMatrix = normc(table2array(round1training2of2(:,3:8)));
yVol = normc(table2array(round1training2of2(:,9)))

% Average Daily Data
% dataMatrix = normc(table2array(round1TDailyData(:,[2:5 13 14])));
% yVol = normc(table2array(round1TDailyData(:, 9)))

[r, ~] = size(dataMatrix);
y = [1:r];
y = yVol;

[coeff,score,latent] = pca(dataMatrix);

figure
subplot(3,2,1)
scatter(y, score(:,1), '.')
title('Temperature');


subplot(3,2,2)
scatter(y, score(:,2), '.')
title('Cloud_ Cover');

subplot(3,2,3)
scatter(y, score(:,3), '.')
title('Wind_ Speed');

subplot(3,2,4)
scatter(y, score(:,4), '.')
title('Humidity');

subplot(3,2,5)
scatter(y, score(:,5), '.')
title('Precipitation_ Amount');

subplot(3,2,6)
scatter(y, score(:,6), '.')
title('Solar_ Radiation');