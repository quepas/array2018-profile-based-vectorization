source("loadData.R")

crni1 <- loadData("../../benchmarks-instrumented/paper-results/loops-final/crni1_2015b.csv")
backprop1 <- loadData("../../benchmarks-instrumented/paper-results/loops-final/backprop1_2015b.csv")

ssample <- crni1$sample[crni1$sample %in% backprop1$sample]#c(33, 97, 289, 545, 801, 1057, 1313, 1569, 1825, 2033)
sample <- ssample[seq(5, 128, 8)]
sample <- unique(sort(c(sample, 97, 113, 145)))

par(mfrow=c(1, 1), mar=c(5, 5, 2, 5))
#pdf("motivatingExamples.pdf", width = 8.27, height = 5.83)
plot(sample, 
     crni1$su[crni1$sample %in% sample], 
     type="b", 
     pch=2, 
     xlab="Iterations / Data size", 
     ylab="Speed-up", 
     frame.plot = F, 
     cex.lab=1.5, 
     cex.axis=1.5, 
     cex=2, 
     xlim=c(0, 2000)
     )
legend(1100, 
       0.7, 
       legend=c("crni1", "backprop1"),
       lty=1, 
       pch=c(2, 10), 
       cex=1.5,
       pt.cex=2,
       bty = "n",
       title=expression(bold(underline("Loop"))))
lines(sample, backprop1$su[backprop1$sample %in% sample], pch=10, type="b", cex=2)

abline(1, 0, col="gray", lty=5)
text(1000, 1.04, "baseline", col="gray", cex=1.2)
#dev.off()
