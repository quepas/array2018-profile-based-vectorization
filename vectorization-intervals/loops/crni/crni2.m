%% LoopID: crni2
loopID = 'crni2';
% Benchmark: crni
% Function: crnich.m

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

   %% Original code
   measurements = zeros(1, rep);
   for r = 1:rep
      Vb = zeros(1, n);
      U=rand(n, n);
      j1 = randi([1, n], 1, 1)+1;
      s2 = rand(1, 1);

      tic();
      for i1=2:(n-1)
	      Vb(i1)=U(i1-1, j1-1)+U(i1+1, j1-1)+s2*U(i1, j1-1);
      end
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

   %% LCPC code
   measurements = zeros(1, rep);
   for r = 1:rep
      Vb = zeros(1, n);
      U=rand(n, n);
      j1 = randi([1, n], 1, 1)+1;
      s2 = rand(1, 1);

      tic();
      i1 = colon(2,minus(n,1));
      if length(Vb)==length(i1)
         Vb=plus(plus(U(minus(i1,1),minus(j1,1)),U(plus(i1,1),minus(j1,1))),times(minus(rdivide(2,r),2),U(i1,minus(j1,1))));
      else
         Vb(i1)=plus(plus(U(minus(i1,1),minus(j1,1)),U(plus(i1,1),minus(j1,1))),times(minus(rdivide(2,r),2),U(i1,minus(j1,1))));
      end
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

   %% HHM code
   measurements = zeros(1, rep);
   for r = 1:rep
      Vb = zeros(1, n);
      U=rand(n, n);
      j1 = randi([1, n], 1, 1)+1;
      s2 = rand(1, 1);

      tic();
      Vb(2:(n-1))=U(1:(n-2), j1-1)+U(3:n, j1-1)+s2*U(2:(n-1), j1-1);
      measurements(1, r) = toc();
   end
   aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

end

plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
