function runner()
   %% LoopID: fft2
   loopID = 'fft2';
   % Benchmark: fft
   % Function: fftSimple.m
   % Default: {n: 256, 128, 64, 32, 16, 8, 4, 2}

   resultsDir = '../../results/loops-profiling/';
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
         half = floor(n/2);
         eR = zeros(1,half);
         eI = zeros(1,half);
         dR = zeros(1,half);
         dI = zeros(1,half);
         xR = rand(1, n);
         xI = rand(1, n);

         tic();
         for k=1:half
            eR(k) = xR(2*k - 1);
            eI(k) = xI(2*k - 1);
            dR(k) = xR(2*k);
            dI(k) = xI(2*k);
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

      %% LCPC code
      measurements = zeros(1, rep);
      for r = 1:rep
         half = floor(n/2);
         eR = zeros(1,half);
         eI = zeros(1,half);
         dR = zeros(1,half);
         dI = zeros(1,half);
         xR = rand(1, n);
         xI = rand(1, n);

         tic();
         k = colon(1,half);
         dR(k) = xR(times(2,k));
         dI(k) = xI(times(2,k));
         eI(k) = xI(minus(times(2,k),1));
         eR(k) = xR(minus(times(2,k),1));
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         half = floor(n/2);
         xR = rand(1, n);
         xI = rand(1, n);

         tic();
         eR = xR(1:2:(half*2-1));
         eI = xI(1:2:(half*2-1));
         dR = xR(2:2:(half*2));
         dI = xI(2:2:(half*2));
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end

   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);

   fprintf('{ "time": 0.0 }\n');
end
