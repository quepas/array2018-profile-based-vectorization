loadAndComputeSpeedup <- function(filename) {
  data <- read.csv(filename, header = FALSE);
  colnames(data) <- c("sample", "loop", "lcpc", "hhm")
  x <- data$sample
  loopFit <- loess(loop ~ sample, data)
  lcpcFit <- loess(lcpc ~ sample, data)
  suLCPC <- predict(loopFit, x) / predict(lcpcFit, x)
  return(list(sample=x, su=suLCPC))
}