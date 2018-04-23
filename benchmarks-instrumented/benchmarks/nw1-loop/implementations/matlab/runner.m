function runner()
   %% LoopID: nw1
   loopID = 'nw1';
   % Benchmark: nw
   % Function: needle.m
   % Default: {n: 4097}

   resultsDir = '../../results/loops-profiling/';
   % Num. of repated measurements
   rep = 10;
   % Function aggregating data from repeated measurements
   aggregate = @min;
   % Values of input parameter (data sizes)
   parameterValues = 1:64:6144;
   numValues = length(parameterValues);
   aggregatedMeasurements = zeros(numValues, 3);

   for value = 1:numValues
      n = parameterValues(value)

      %% Original code
      measurements = zeros(1, rep);
      for r = 1:rep
         input_seq_1 = randi([1, 24], 1, n);
         input_seq_2 = randi([1, 24], 1, n);
         blosum62 = rand(24, 24);
         reference = rand(n, n);

         tic();
         for ii = 1:n
            for jj = 2:n
               reference(ii,jj) = blosum62(input_seq_2(jj), input_seq_1(ii));
            end
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 1) = aggregate(measurements(1, :));

      %% LCPC code
      measurements = zeros(1, rep);
      for r = 1:rep
         input_seq_1 = randi([1, 24], 1, n);
         input_seq_2 = randi([1, 24], 1, n);
         blosum62 = rand(24, 24);
         reference = rand(n, n);

         tic();
         for ii = 1:n
            jj = colon(2, n);
            reference(ii, jj) = blosum62(input_seq_2(jj),input_seq_1(ii));
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 2) = aggregate(measurements(1, :));

      %% HHM code
      measurements = zeros(1, rep);
      for r = 1:rep
         input_seq_1 = randi([1, 24], 1, n);
         input_seq_2 = randi([1, 24], 1, n);
         blosum62 = rand(24, 24);
         reference = rand(n, n);

         tic();
         for ii = 1:n
            reference(ii, 2:n) = blosum62(input_seq_2(2:n), input_seq_1(ii));
         end
         measurements(1, r) = toc();
      end
      aggregatedMeasurements(value, 3) = aggregate(measurements(1, :));

   end

   plotResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);
   writeResults(parameterValues, aggregatedMeasurements, loopID, resultsDir);

   fprintf('{ "time": 0.0 }\n');
end
