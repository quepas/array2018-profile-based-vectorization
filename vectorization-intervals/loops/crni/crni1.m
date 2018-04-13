%% LoopID: crni1
loopID = 'crni1';
% Benchmark: crni
% Function: crnich.m
% Default: {n: 2300, m: 2300}

resultsDir = '../../results/';
addpath('../../helpers/')
% Num. of repated measurements
rep = 100;
% Function aggregating data from repeated measurements
aggregate = @min;
% Values of input parameter (data sizes)
parameterValues = 1:16:2048;
numValues = length(parameterValues);
aggregatedMeasurements = zeros(numValues, 3);

for value = 1:numValues
   n = parameterValues(value);

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      h = rand(1, 1);
      U = zeros(n, n);
      m = randi([1, n], 1, 1);

      tic();
      for i1=2:(n-1)
         U(i1, m)=sin(pi*h*(i1-1))+sin(3*pi*h*(i1-1));
      end
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      C_PI = 3.14159265358979323846;
      h = rand(1, 1);
      U = zeros(n, n);
      m = randi([1, n], 1, 1);

      tic();
      i1 = colon(2,minus(n,1));
      U(i1, m) = plus(sin(times(times(C_PI, h),minus(i1,1))),sin(times(times(times(3,C_PI),h),minus(i1,1))));
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      h = rand(1, 1);
      U = zeros(n, n);
      m = randi([1, n], 1, 1);

      tic();
      U(2:(n-1), m)= sin(pi.*h.*(1:(n-2)))+sin(3.*pi.*h.*(1:(n-2)));
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
