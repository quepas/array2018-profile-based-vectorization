%% LoopID: template
loopID = 'template';
% Benchmark: template
% Function: template

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

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      % REMOVE! INITIALIZATION CODE

      tic();
      % REMOVE! TEST CODE
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      % REMOVE! INITIALIZATION CODE

      tic();
      % REMOVE! TEST CODE
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      % REMOVE! INITIALIZATION CODE

      tic();
      % REMOVE! TEST CODE
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements)
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
