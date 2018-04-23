# Find the last TRUE point in a binary vector (T/F)
findLast <- function(interval) {
  for (i in seq(length(interval), 1, -1)) {
    if (!interval[i]) {
      last <- i+1
      return(last);
    }
  }
}
