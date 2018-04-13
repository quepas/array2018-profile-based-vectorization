%% LoopID: capr2
loopID = 'capr2';
% Benchmark: capr
% Function: gauss.m
% Default: {n: 20, f: [21 x 50]}

resultsDir = '../../results/';
addpath('../../helpers/')
% Num. of repated measurements
rep = 100;
% Function aggregating data from repeated measurements
aggregate = @min;
% Values of input parameter (data sizes)
parameterValues = 1:16:4096;
numValues = length(parameterValues);
aggregatedMeasurements = zeros(numValues, 3);

for value = 1:numValues
   n = parameterValues(value);
   m = 49;

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      q = 0;
      f = rand(n+1, m+1);
      mm = randi([1, m], 1, 1);

      tic();
      for ii=1:n
         q=q+(f(ii, mm)+f(ii+1, mm))*0.5;
      end;
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      q = 0;
      f = rand(n+1, m+1);
      mm = randi([1, m], 1, 1);

      tic();
      ii = colon(1,n);
      q = plus(q,sum(times(plus(f(ii, mm),f(plus(ii,1),mm)),0.5)));
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      q = 0;
      f = rand(n+1, m+1);
      mm = randi([1, m], 1, 1);

      tic();
      q = sum(0.5*(f(1:n, mm) + f(2:(n+1), mm)));
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
