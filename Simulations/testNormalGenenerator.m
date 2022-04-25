function [  ] = testNormalGenenerator(  )
N=10e7;
RandomNumbersNeeded=0;

for i=1:N
    [a,b]=getNormalNumber_Exact();
    RandomNumbersNeeded=RandomNumbersNeeded+b;
end

RandomNumbersNeeded/N
    
end