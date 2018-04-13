%% LoopID: fft1
loopID = 'fft1';
% Benchmark: fft
% Function: fft2D.m
% Default: {n: 256}

resultsDir = '../../results/';
addpath('../../helpers/')
% Num. of repated measurements
rep = 100;
% Function aggregating data from repeated measurements
aggregate = @min;
% Values of input parameter (data sizes)
parameterValues = 1:32:4096;
numValues = length(parameterValues);
aggregatedMeasurements = zeros(numValues, 3);

for value = 1:numValues
   n = parameterValues(value);

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      rtnR = zeros(n, n);
      rtnI = zeros(n, n);
      resR = rand(1, n);
      resI = rand(1, n);
      ii = randi([1, n], 1, 1);

      tic();
      for k=1:n
         rtnR(ii,k) = resR(k);
         rtnI(ii,k) = resI(k);
      end
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      rtnR = zeros(n, n);
      rtnI = zeros(n, n);
      resR = rand(1, n);
      resI = rand(1, n);
      ii = randi([1, n], 1, 1);

      tic();
      k = colon(1,n);
      rtnI(ii, k) = resI(k);
      rtnR(ii, k) = resR(k);
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      rtnR = zeros(n, n);
      rtnI = zeros(n, n);
      resR = rand(1, n);
      resI = rand(1, n);
      ii = randi([1, n], 1, 1);

      tic();
      rtnR(ii, :) = resR(1:n);
      rtnI(ii, :) = resI(1:n);
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
