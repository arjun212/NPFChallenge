function[value]=dayValue(dayType)

% WE – Weekday 
% SA – Saturday
% SU - Sunday
% CD – Christmas Day
% BD – Boxing Day
% J1 – New Years Day
% GF – Good Friday
% EM – Easter Monday
% M1 – Early May Bank Holiday
% M2 – End of May Bank Holiday
% A2 – End of August Bank Holiday

transform=struct('WE',1,'SA',1,'SU',1,'CD',1,'BD',1,'J1',1,'GF',1,'EM',1,'M1',1,'M2',1,'A2',1);

value=transform.(dayType);

end




