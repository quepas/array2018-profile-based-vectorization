%% LoopID: backprop3
loopID = 'backprop3';
% Benchmark: backprop
% Function: bpnn_layerforward.m
% Defaults: {set1: {n1: 2850001, n2: 17}
%            set2: {n1: 17, n2: 2}}

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
   n = parameterValues(value)
   n2 = 17; % or 2

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      s = 0;
      conn = rand(n, n2);
      l1 = rand(1, n);
      jj = randi([1, n2], 1, 1);

      tic();
      for k = 1:n
         s = s + conn(k, jj) * l1(k);
      end
      measurements(1, r) = toc();

      assert(isscalar(s));
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      s = 0;
      conn = rand(n, n2);
      l1 = rand(1, n);
      jj = randi([1, n2], 1, 1);

      tic();
      k = colon(1,n);
      s = plus(s, sum(times(transpose(conn(k, jj)), l1(k))));
      measurements(1, r) = toc();

      assert(isscalar(s));
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      conn = rand(n, n2);
      l1 = rand(1, n);
      jj = randi([1, n2], 1, 1);

      tic();
      s = sum(conn(1:n, jj) .* l1(1:n)');
      measurements(1, r) = toc();

      assert(isscalar(s));
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements)
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
