function runner()
   %% LoopID: backprop1
   loopID = 'backprop1';
   % Benchmark: backprop
   % Function: bpnn_adjust_weights.m
   % Default: {n: [17, 2850001], ndelta: [2, 17]}
   % Found: {n: 497}

   resultsDir = '../../paper-results/loops/';
   % Num. of repated measurements
   rep = 100;
   % Function aggregating data from repeated measurements
   aggregate = @min;
   % Values of input parameter (data sizes)
   parameterValues = 1:16:2048; %2850000:1000:2855000;%
   numValues = length(parameterValues);
   aggregatedMeasurements = zeros(numValues, 3);

   for value = 1:numValues
      n = parameterValues(value);
      ndelta = 17; % from backprop2: 2049; % default: 17

      %% Original code
      measurements = zeros(1, rep);
      for r = 1:rep
         delta = rand(1, ndelta);
         nly = n;
         ly = rand(1, nly);
         oldw = rand(n, ndelta);
         w = rand(n, ndelta);
         ETA = rand(1, 1);
         MOMENTUM = rand(1, 1);

         tic();
         for jj = 1:ndelta
            for k = 1:nly
               new_dw = ((ETA * delta(jj) * ly(k)) + (MOMENTUM * oldw(k,jj)));
               w(k,jj) = w(k,jj) + new_dw;
               oldw(k,jj) = new_dw;
            end
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

      %% LCPC code
      measurements = zeros(1, rep);
      for r = 1:rep
         delta = rand(1, ndelta);
         nly = n;
         ly = rand(1, nly);
         oldw = rand(n, ndelta);
         w = rand(n, ndelta);
         ETA = rand(1, 1);
         MOMENTUM = rand(1, 1);

         tic();
         for jj = 1:ndelta
            k = colon(1,nly);
            new_dw = plus(transpose(times(MOMENTUM,oldw(k, jj))),times(times(ETA,delta(jj)),ly(k)));
            oldw(k, jj) = transpose(new_dw);
            w(k, jj) = transpose(plus(transpose(w(k, jj)),new_dw));
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         delta = rand(1, ndelta);
         nly = n;
         ly = rand(1, nly);
         oldw = rand(n, ndelta);
         w = rand(n, ndelta);
         ETA = rand(1, 1);
         MOMENTUM = rand(1, 1);

         tic();
         for jj = 1:ndelta
            new_dw = ((ETA .* delta(jj) .* ly)' + (MOMENTUM .* oldw(1:nly,jj)));
            w(1:nly,jj) = w(1:nly,jj) + new_dw;
            oldw(1:nly,jj) = new_dw;
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end

   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);


   fprintf('{ "time": 0.0 }\n');
end
