%% LoopID: backprop4
loopID = 'backprop4';
% Benchmark: backprop
% Function: bpnn_output_error.m
% Defaults: {nj: 2}

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
      output = rand(1, n);
      target = rand(1, n);
      delta = rand(1, n);
      errsum = 0;

      tic();
      for jj = 2:n
         o = output(jj);
         t = target(jj);
         delta(jj) = o * (1.0 - o) * (t - o);
         errsum = errsum + abs(delta(jj));
      end
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      output = rand(1, n);
      target = rand(1, n);
      delta = rand(1, n);
      errsum = 0;

      tic();
      jj = colon(2,n);
      o = output(jj);
      if length(delta)==length(jj)
         delta=times(times(o,minus(1.0,o)),minus(target(jj),o));
      else
         delta(jj)=times(times(o,minus(1.0,o)),minus(target(jj),o));
      end
      errsum = plus(errsum,sum(abs(delta(jj))));
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      output = rand(1, n);
      target = rand(1, n);
      delta = rand(1, n);

      tic();
      o = output(2:n);
      t = target(2:n);
      delta(2:n) = o .* (1.0 - o) .* (t - o);
      errsum = sum(abs(delta(2:n)));
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements)
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
