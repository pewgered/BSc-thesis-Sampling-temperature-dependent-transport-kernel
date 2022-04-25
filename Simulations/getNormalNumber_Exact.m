function [normalNumber,numberOfRandomsNeeded] = getNormalNumber_Exact()
%Returns a normal number with rejection method

a=1;
b=0;
numberOfRandomsNeeded=0;
while a>b
    a=rand();
    normalNumber=-log(rand());
    b=exp(-1/2*(normalNumber-1)^2);
    numberOfRandomsNeeded=numberOfRandomsNeeded+1;
end
if rand()<0.5
    normalNumber=-normalNumber;
end
