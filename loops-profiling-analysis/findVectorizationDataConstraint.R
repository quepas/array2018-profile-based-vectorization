source("findLast.R")
# Laod loop profiling data
data <- read.csv("../paper-results/loops-profiling/nw2_2015b.csv", header = FALSE);
colnames(data) <- c("sample", "loop", "mc2mc", "mc2mcOpt")

# Set three plots in a row
par(mfrow=c(1, 3))
x <- data$sample

# Plot measured execution time
plot(x, data$loop, type="l", col="gray",
     xlab="Iterations / Data size",
     ylab="Execution time [s]",
     main = "Measured execution time")
lines(x, data$mc2mc, lty=2, col="blue")
lines(x, data$mc2mcOpt, lty=2, col="red")
legend(x ="topleft", legend = c("Loop", "Mc2Mc", "Mc2Mc Optimized"),
       lty=c(1, 2, 2),
       col=c("gray", "blue", "red"))

# Compute measured time interpolation
loopFit <- loess(loop ~ sample, data)
mc2mcFit <- loess(mc2mc ~ sample, data)
mc2mcOptFit <- loess(mc2mcOpt ~ sample, data)
# Plot interpolated measured time
plot(x, predict(loopFit, x), lty=1,
     type="l",
     col="gray",
     xlab="Iterations / Data size",
     ylab="Execution time [s]",
     main = "Interpolated execution time")
lines(x, predict(mc2mcFit, x), lty=2, col="blue")
lines(x, predict(mc2mcOptFit, x), lty=2, col="red")
legend(x ="topleft", legend = c("Loop", "Mc2Mc", "Mc2Mc Optimized"),
       lty=c(1, 2, 2),
       col=c("gray", "blue", "red"))

# Compute mc2mc and mc2mcOpt speedups
suMc2Mc <- predict(loopFit, x) / predict(mc2mcFit, x)
suMc2McOpt <- predict(loopFit, x) / predict(mc2mcOptFit, x)
# Plot speedups of vectorized code
plot(x, suMc2McOpt, type="l",
     col="red",
     lty=2,
     xlab="Iterations / Data size",
     ylab="Speedup",
     main = "Speedup of loop vectorization")
lines(x, suMc2Mc, type="l", col="blue", lty=2)
legend(x = "topleft", legend = c("Loop (Baseline)", "Mc2Mc", "Mc2Mc Optimized"),
       lty=c(1, 2, 2),
       col=c("gray", "blue", "red"))

# Draw baseline
abline(1, 0, col="gray")

# Set minimal speedup for which we search for PV point (Profitable Vectorization)
# 1 == 100%, 1.05 = 105% etc.
minSU <- 1

# Find data size for each a given speedup is achieved
maskMc2Mc <- suMc2Mc > minSU
maskMc2McOpt <- suMc2McOpt > minSU

# Find optimistic PV point
positiveMc2Mc <- x[suMc2Mc > minSU]
positiveMc2McOpt <- x[suMc2McOpt > minSU]

# Find conservative PV point
lastMc2Mc <- findLast(maskMc2Mc)
lastMc2McOpt <- findLast(maskMc2McOpt)

# Show found optimistic and conservative PV points (for unoptimized/optimized Mc2Mc)
cat(sprintf("----- Mc2Mc Unoptimized (blue line) -----\n"))
cat(sprintf("\tOptimistic constraint: %f\n", positiveMc2Mc[1]))
cat(sprintf("\tConservative constraint: %f\n", data$sample[lastMc2Mc]))
cat(sprintf("----- Mc2Mc Optimized (red line) -----\n"))
cat(sprintf("\tOptimisitic PV point: %f\n", positiveMc2McOpt[1]))
cat(sprintf("\tConvservative  PV point: %f\n", data$sample[lastMc2McOpt]))
