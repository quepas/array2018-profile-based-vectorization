findLast <- function(interval) {
  for (i in seq(length(interval), 1, -1)) {
    if (!interval[i]) {
      last <- i+1
      return(last);
      #cat(sprintf("Vectorization point (better): %d (index: %d)", data$sample[last], last))
    }
  }
  
}