function [f, x] = calculatePDF(sample, nPoints, left, right, normalize)
% Proposed parameters:
% testPowerNumber -> [yEstimatedPDF, xEstimatedPDF] = calculatePDF(sample, 20, 0.0, 1.0, 1);
% testExponentialNumber -> [yEstimatedPDF, xEstimatedPDF] = calculatePDF(sample, 20, 0.0, -log(0.01)/lambda, 1);
% NOTE: The domain of the functions is (0,infinity), but 99% of the range lies on the interval(0.0, -log(0.01)/lambda)

   x = zeros(nPoints,1);
   f = zeros(nPoints,1);

   % determining interval boundaries as well as subinterval width and midpoints
   width = (right-left)/nPoints;  

   for i=1:nPoints
      x(i) = left + (i-0.5)*width;    
   end
  
   % determining count-histogram, that is, counting the number of values falling into different subintervals
   
   for i=1:length(sample)
      if sample(i)>left && sample(i)<right
         index = ceil((sample(i)-left)/width);
         f(index) = f(index) + 1;
         
      end
   end
  
   % if normalization was requested, dividing the count-histogram by its integral, 
   % resulting in the probability distribution function

   if normalize
      integral = sum(f)*width;
      f = f/integral;
   end
   
  
end

