%% LoopID: nw2
loopID = 'nw2';
% Benchmark: nw
% Function: needle.m
% Default: {n: 4097}

resultsDir = '../../results/';
addpath('../../helpers/')
% Num. of repated measurements
rep = 100;
% Function aggregating data from repeated measurements
aggregate = @min;
% Values of input parameter (data sizes)
parameterValues = 1:8:1024;
numValues = length(parameterValues);
aggregatedMeasurements = zeros(numValues, 3);

for value = 1:numValues
   n = parameterValues(value);

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      input_itemsets = rand(n, n);
      jj = randi([1, n], 1, 1);
      penalty = rand(1, 1);

      tic();
      for ii = 2:n
         input_itemsets(ii, jj) = -(ii - 1) * penalty;
      end
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      input_itemsets = rand(n, n);
      jj = randi([1, n], 1, 1);
      penalty = rand(1, 1);

      tic();
      ii = colon(2,n);
      input_itemsets(ii, jj) = times(uminus(minus(ii,1)),penalty);
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      input_itemsets = rand(n, n);
      jj = randi([1, n], 1, 1);
      penalty = rand(1, 1);

      tic();
      input_itemsets(2:n, jj) = -(1:(n-1)) .* penalty;
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
