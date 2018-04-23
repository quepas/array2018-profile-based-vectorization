source("loadAndComputeSpeedup.R")

# Load vectorization speedup of each loop
crni1     <- loadAndComputeSpeedup("../../paper-results/loops-profiling/crni1_2015b.csv")
backprop1 <- loadAndComputeSpeedup("../../paper-results/loops-profiling/backprop1_2015b.csv")

# Find common number of iterations used in both loops
sample <- crni1$sample[crni1$sample %in% backprop1$sample]
sample <- sample[seq(5, 128, 8)]
sample <- unique(sort(c(sample, 97, 113, 145)))

# Save as pdf (A5 format)
pdf("motivatingExample.pdf", width = 8.27, height = 5.83)
# Modify plot margins
par(mfrow=c(1, 1), mar=c(5, 5, 2, 5))
# Plot the first loop speedup
plot(sample,
     crni1$su[crni1$sample %in% sample],
     xlab="Iterations / Data size",
     xlim=c(0, 2000),
     ylab="Speedup",
     type="b",
     pch=2,
     cex.lab=1.5,
     cex.axis=1.5,
     cex=2,
     frame.plot = F)
# Plot the second loop speedup
lines(sample, backprop1$su[backprop1$sample %in% sample], pch=10, type="b", cex=2)
# Add legend to the plot
legend(1100,
       0.7,
       legend=c("crni1", "backprop1"),
       title=expression(bold(underline("Loop"))),
       pch=c(2, 10),
       lty=1,
       cex=1.5,
       pt.cex=2,
       bty = "n")
# Plot baseline
abline(1, 0, col="gray", lty=5)
# ... with a text !
text(1000, 1.04, "baseline", col="gray", cex=1.2)
# Finish plotting
dev.off()
