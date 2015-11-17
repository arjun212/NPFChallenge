clear;
load('round1FDailyData.mat');
load('Round1ANNFinal.mat');
load('round1TDailyData.mat')

xi=[{table2array(round1TDailyData(end,2:8))'};table2cell(round1TDailyData(end,9))];
x=[num2cell(table2array(round1FDailyData(1,1:7))',1)...
    ;table2cell(round1TDailyData(end,9))];

[r,c]=size(round1FDailyData);
volPred={};
for i=1:1:r
    volPred(i)=net(x,xi);
    x=[num2cell(table2array(round1FDailyData(r,1:7))',1)...
        ;volPred(i)]
    if i>1
    xi=[{table2array(round1FDailyData(r,1:7))'}...
        ;volPred(i-1)]
    end
end


% % 
% Ni	=	net.numInputs
% Nl	=	net.numLayers
% No	=	net.numOutputs
% D	=	net.numInputDelays
% LD	=	net.numLayerDelays
% Ri	=	net.inputs{1}.size
% Si	=	net.layers{i}.size
% Ui	=	net.outputs{i}.size
