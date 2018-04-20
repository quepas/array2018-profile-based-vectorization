function runner()
   %% LoopID: capr1
   loopID = 'capr1';
   % Benchmark: capr
   % Function: capacitor.m
   % Default: {n: 8}

   resultsDir = '../../paper-results/loops/';
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
         f = zeros(maximal, maximal);
         mask = rand(maximal, maximal);
         mb = floor(n / 2);

         tic();
         for ii=1:n
            for jj=1:mb
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
         f = zeros(maximal, maximal);
         mask = rand(maximal, maximal);
         mb = floor(n / 2);


         tic();
         ii = colon(1,n);
         jj = colon(1,mb);
         f(ii, jj) = 1;
         mask(ii, jj) = 0;
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         f = zeros(maximal, maximal);
         mask = rand(maximal, maximal);
         mb = floor(n / 2);

         tic();
         mask(2:n, 2:mb) = 0;
         f(2:n, 2:mb) = 1;
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end

   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);

   fprintf('{ "time": 0.0 }\n');
end
