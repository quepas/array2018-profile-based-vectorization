%% LoopID: nw1
loopID = 'nw1';
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
parameterValues = 1:64:8192;
numValues = length(parameterValues);
aggregatedMeasurements = zeros(numValues, 3);

for value = 1:numValues
   n = parameterValues(value);

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      ii = randi([1, n], 1, 1);
      input_seq_1 = randi([1, 24], 1, n);
      input_seq_2 = randi([1, 24], 1, n);
      blosum62 = rand(24, 24);
      reference = rand(n, n);

      tic();
      for jj = 2:n
         reference(ii,jj) = blosum62(input_seq_2(jj), input_seq_1(ii));
      end
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      ii = randi([1, n], 1, 1);
      input_seq_1 = randi([1, 24], 1, n);
      input_seq_2 = randi([1, 24], 1, n);
      blosum62 = rand(24, 24);
      reference = rand(n, n);

      tic();
      jj = colon(2, n);
      reference(ii, jj) = blosum62(input_seq_2(jj),input_seq_1(ii));
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      ii = randi([1, n], 1, 1);
      input_seq_1 = randi([1, 24], 1, n);
      input_seq_2 = randi([1, 24], 1, n);
      blosum62 = rand(24, 24);
      reference = rand(n, n);

      tic();
      reference(ii, 2:n) = blosum62(input_seq_2(2:n), input_seq_1(ii));
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
