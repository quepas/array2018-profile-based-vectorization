loadAndComputeSpeedup <- function(filename) {
  data <- read.csv(filename, header = FALSE);
  colnames(data) <- c("sample", "loop", "mc2mc", "mc2mc.optimized")
  x <- data$sample
  loopFit <- loess(loop ~ sample, data)
  mc2mcFit <- loess(mc2mc ~ sample, data)
  suMC2MC <- predict(loopFit, x) / predict(mc2mcFit, x)
  return(list(sample=x, su=suMC2MC))
}