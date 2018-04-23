function runner()
   % Benchmark: backprop
   % Function: bpnn_layerforward.m
   % Defaults: {n: [2850001, 17], n2: [17, 2]}

   %%%% SMALL TEST
   loopID = 'backprop3';
   % Values of input parameter (data sizes)
   parameterValues = 1:32:4096;
   % Num. of repated measurements
   rep = 100;
   %%%% BIG TEST
   % loopID = 'backprop3big';
   % parameterValues = 25000:25000:3200000;
   % rep = 10;

   resultsDir = '../../results/loops-profiling/';
   % Function aggregating data from repeated measurements
   aggregate = @min;

   numValues = length(parameterValues);
   aggregatedMeasurements = zeros(numValues, 3);

   for value = 1:numValues
      n = parameterValues(value);
      n2 = 17; % or 2

      %% Original code
      measurements = zeros(1, rep);
      for r = 1:rep
         s = 0;
         conn = rand(n, n2);
         l1 = rand(1, n);

         tic();
         for jj = 1:n2
            for k = 1:n
               s = s + conn(k, jj) * l1(k);
            end
         end
         measurements(1, r) = toc();

         assert(isscalar(s));
      end
      aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

      %% LCPC code
      measurements = zeros(1, rep);
      for r = 1:rep
         s = 0;
         conn = rand(n, n2);
         l1 = rand(1, n);

         tic();
         for jj = 1:n2
            k = colon(1,n);
            s = plus(s, sum(times(transpose(conn(k, jj)), l1(k))));
         end
         measurements(1, r) = toc();

         assert(isscalar(s));
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         conn = rand(n, n2);
         l1 = rand(1, n);
         s = 0;

         tic();
         for jj = 1:n2
            s = s + sum(conn(1:n, jj) .* l1(1:n)');
         end
         measurements(1, r) = toc();

         assert(isscalar(s));
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end

   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);

   fprintf('{ "time": 0.0 }\n');
end
