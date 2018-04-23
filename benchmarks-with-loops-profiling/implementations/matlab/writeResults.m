function writeResults(parameters, data, resultName, dirName)
   data = [parameters' data];
   csvwrite([dirName, resultName, '_', version('-release'), '.csv'], data);
end
