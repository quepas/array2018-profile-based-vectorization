%% LoopID: capr1
loopID = 'capr1';
% Benchmark: capr
% Function: capacitor.m

resultsDir = '../../results/';
addpath('../../helpers/')
% Num. of repated measurements
rep = 100;
% Function aggregating data from repeated measurements
aggregate = @min;
% Values of input parameter (data sizes)
parameterValues = 1:1:128;
numValues = length(parameterValues);
aggregatedMeasurements = zeros(numValues, 3);

for value = 1:numValues
   n = parameterValues(value);
   maximal = max(parameterValues);

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      f = zeros(maximal+1, maximal+1);
      rel = rand(1, 1);
      mask = ones(maximal+1, maximal+1) * rel;
      na = n;
      mb = floor(n / 2);

      tic();
      for ii=1:na+1
         for jj=1:mb+1
            mask(ii, jj)=0;
            f(ii, jj)=1;
         end;
      end;
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      f = zeros(maximal+1, maximal+1);
      rel = rand(1, 1);
      mask = ones(maximal+1, maximal+1) * rel;
      na = n;
      mb = floor(n / 2);

      tic();
      ii = colon(1,plus(na,1));
      jj = colon(1,plus(mb,1));
      f(ii, jj) = 1;
      mask(ii, jj) = 0;
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      f = zeros(maximal+1, maximal+1);
      rel = rand(1, 1);
      mask = ones(maximal+1, maximal+1) * rel;
      na = n;
      mb = floor(n / 2);

      tic();
      mask(2:(na+1), 2:(mb+1)) = 0;
      f(2:(na+1), 2:(mb+1)) = 1;
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
