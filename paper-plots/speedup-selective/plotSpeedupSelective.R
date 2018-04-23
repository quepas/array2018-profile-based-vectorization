data <- read.csv("../../paper-results/speedup-selective/results_100rep.csv")
# Aggregate the repeated measurements with mean value
dataAggregate <- colMeans(data)
# Compute speedups of vectorized code with systematic and selective strategy
speedups <- data.frame(crni=c(dataAggregate["crni_matlab"]/dataAggregate["crni_mc2mc"],
                              dataAggregate["crni_matlab"]/dataAggregate["crni_mc2mc_selective"]),
                       nw=c(dataAggregate["nw_matlab"]/dataAggregate["nw_mc2mc"],
                            dataAggregate["nw_matlab"]/dataAggregate["nw_mc2mc_selective"]))
# Save as pdf (A5 format)
pdf("mc2mc-selective.pdf", width = 8.27, height = 5.83)
# Modify plot margins
par(mfrow=c(1, 1), mar=c(5, 10, 2, 13))
# Plot vectorization strategies comparison
barplot(as.matrix(speedups),
        beside=T,
        axes = T,
        col=c("#f0f0f0","#bdbdbd"),
        xlab = "Benchmark",
        ylab = "Speedup",
        cex.names = 1.5,
        cex.axis = 1.5,
        cex.lab=1.5,
        legend = c("Systematic", "Selective"),
        args.legend = list(x ='right',
                           bty='n',
                           cex=1.5,
                           horiz=F,
                           inset=c(-0.6, 0),
                           title=expression(bold(underline("Strategy"))), title.col="black"))
# Plot baseline
abline(a = 1, b= 0, col="gray", lty=5)
# ... with a text !
mtext("baseline", col="gray", cex=1.3)
# Finish plotting
dev.off()
