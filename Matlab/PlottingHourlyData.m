clear all;
close all;
clc;
load('round1training2of2.mat');


y = round1training2of2(:, 9);


figure
subplot(3,2,1)
scatter(y, dataMatrix(:,1), '.')
title('Temperature');

subplot(3,2,2)
scatter(y, dataMatrix(:,2), '.')
title('Cloud_ Cover');

subplot(3,2,3)
scatter(y, dataMatrix(:,3), '.')
title('Wind_ Speed');

subplot(3,2,4)
scatter(y, dataMatrix(:,4), '.')
title('Humidity');

subplot(3,2,5)
scatter(y, dataMatrix(:,5), '.')
title('Precipitation_ Amount');

subplot(3,2,6)
scatter(y, dataMatrix(:,6), '.')
title('Solar_ Radiation');