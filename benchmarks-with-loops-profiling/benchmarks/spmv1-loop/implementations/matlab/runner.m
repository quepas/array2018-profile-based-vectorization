function runner()
   %% LoopID: spmv1
   loopID = 'spmv1';
   % Benchmark: spmv
   % Function: spmv_core.m
   % Default: {n: [2, 3]}

   resultsDir = '../../results/loops-profiling/';
   %addpath('../../helpers/')
   % Num. of repated measurements
   rep = 100;
   % Function aggregating data from repeated measurements
   aggregate = @min;
   % Values of input parameter (data sizes)
   parameterValues = 1:64:8192;
   numValues = length(parameterValues);
   aggregatedMeasurements = zeros(numValues, 3);

   for value = 1:numValues
      n = parameterValues(value)

      %% Original code
      measurements = zeros(1, rep);
      for r = 1:rep
         csr_Ax = rand(1, n);
         csr_Aj = randi([1, n], 1, n);
         vec = rand(1, n);
         temp = 0;

         tic();
         for jj = 1:n
            temp = temp + csr_Ax(jj) * vec(csr_Aj(jj));
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

      %% LCPC code
      measurements = zeros(1, rep);
      for r = 1:rep
         csr_Ax = rand(1, n);
         csr_Aj = randi([1, n], 1, n);
         vec = rand(1, n);
         temp = 0;

         tic();
         jj = 1:n;
         temp = plus(temp,sum(times(csr_Ax(jj),vec(csr_Aj(jj)))));
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         csr_Ax = rand(1, n);
         csr_Aj = randi([1, n], 1, n);
         vec = rand(1, n);

         tic();
         temp = sum(csr_Ax(1:n) .* vec(csr_Aj(1:n)));
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end
   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);

   fprintf('{ "time": 0.0 }\n');
end
