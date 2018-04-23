function runner()
   %% LoopID: backprop2
   loopID = 'backprop2';
   % Benchmark: backprop
   % Function: bpnn_hidden_error.m
   % Default: {nh: 17, n: 2}
   % Found: {hidden_n+1: 2049}

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
      n = parameterValues(value);
      nh = 17; % not-dependent parameter

      %% Original code
      measurements = zeros(1, rep);
      for r = 1:rep
         s = 0;
         delta_o = rand(1, n);
         wh = rand(nh, n);

         tic();
         for jj = 1:nh
            for k = 2:n
               s = s + delta_o(k) * wh(jj,k);
            end
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

      %% LCPC code
      measurements = zeros(1, rep);
      for r = 1:rep
         s = 0;
         delta_o = rand(1, n);
         wh = rand(nh, n);

         tic();
         for jj = 1:nh
            k = colon(2,n);
            s = plus(s, sum(times(delta_o(k),wh(jj, k))));
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         delta_o = rand(1, n);
         wh = rand(nh, n);
         s = 0;

         tic();
         for jj = 1:nh
            s = s + sum(delta_o(2:n) .* wh(jj, 2:n));
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end

   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);

   fprintf('{ "time": 0.0 }\n');
end
