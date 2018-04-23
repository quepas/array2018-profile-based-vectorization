function runner()
   %% LoopID: crni3
   loopID = 'crni3';
   % Benchmark: crni
   % Function: tridiagonal.m
   % Default: {n: 2300}

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

      %% Original code
      measurements = zeros(1, rep);
      for r = 1:rep
         X = rand(1, n);
         B = rand(1, n);
         C = rand(1, n);
         D = rand(1, n);

         tic();
         for k=(n-1):-1:1
            X(k)=(B(k)-C(k)*X(k+1))./D(k);
         end;
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

      %% LCPC code
      measurements = zeros(1, rep);
      for r = 1:rep
         X = rand(1, n);
         B = rand(1, n);
         C = rand(1, n);
         D = rand(1, n);

         tic();
         k = colon(minus(n,1),uminus(1),1);
         if length(X)==length(k)
            X=rdivide(minus(B(k),times(C(k),X(plus(k,1)))),D(k));
         else
            X(k)=rdivide(minus(B(k),times(C(k),X(plus(k,1)))),D(k));
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         X = rand(1, n);
         B = rand(1, n);
         C = rand(1, n);
         D = rand(1, n);

         tic();
         X((n-1):-1:1)=(B((n-1):-1:1)-C((n-1):-1:1).*X(n:-1:2))./D((n-1):-1:1);
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end

   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);

   fprintf('{ "time": 0.0 }\n');
end
