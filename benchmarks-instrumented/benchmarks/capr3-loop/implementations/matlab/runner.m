function runner()
   %% LoopID: capr3
   loopID = 'capr3';
   % Benchmark: capr
   % Function: gauss.m
   % Default: {m: 49, f: [21 x 50]}

   resultsDir = '../../results/loops-profiling/';
   % Num. of repated measurements
   rep = 100;
   % Function aggregating data from repeated measurements
   aggregate = @min;
   % Values of input parameter (data sizes)
   parameterValues = 1:64:8192;
   numValues = length(parameterValues);
   aggregatedMeasurements = zeros(numValues, 3);

   for value = 1:numValues
      m = parameterValues(value);
      n = 21;

      %% Original code
      measurements = zeros(1, rep);
      for r = 1:rep
         q = 0;
         f = rand(n+1, m+1);
         nn = randi([1, n], 1, 1);

         tic();
         for jj=1:m
            q=q+(f(nn, jj)+f(nn, jj+1))*0.5;
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

      %% LCPC code
      measurements = zeros(1, rep);
      for r = 1:rep
         q = 0;
         f = rand(n+1, m+1);
         nn = randi([1, n], 1, 1);

         tic();
         jj = colon(1,m);
         q = plus(q,sum(times(plus(f(nn, jj),f(nn,plus(jj,1))),0.5)));
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         q = 0;
         f = rand(n+1, m+1);
         nn = randi([1, n], 1, 1);

         tic();
         q = q+sum(f(nn, 1:m) + f(nn, 2:(m+1)))*0.5;
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end

   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);

   fprintf('{ "time": 0.0 }\n');
end
