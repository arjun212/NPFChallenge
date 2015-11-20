function[value]=dayValue(dayType)


% WE – Weekday -
% SA – Saturday -
% SU - Sunday -
% CD – Christmas Day -
% BD – Boxing Day -
% J1 – New Years Day -
% GF – Good Friday -
% EM – Easter Monday -
% M1 – Early May Bank Holiday -
% M2 – End of May Bank Holiday -
% A2 – End of August Bank Holiday -

transform=struct('WE',2,'SA',3,'SU',4,'CD',5,'BD',6,'J1',7,'GF',8,'EM',9,'M1',10,'M2',11,'A2',12,'SD',13);
dayType=char(dayType);
if isfield(transform,dayType)==1
    value=transform.(dayType);
else
    value=1;
end




