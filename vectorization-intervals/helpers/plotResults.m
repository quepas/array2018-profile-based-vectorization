function plotResults(parameters, measurements, resultName, dirName)
   plot(parameters, measurements);
   legend('Original', 'Mc2Mc', 'HHM');
   print([dirName, resultName, '_', version('-release')],'-dpng');
end
