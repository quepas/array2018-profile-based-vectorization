data <- read.csv("../../paper-results/speedup-selective-optimized/results.csv")
# Aggregate the repeated measurements with mean value
#dataAggregate <- colMeans(data)
dataAggregate <- apply(data, 2, min)
# Compute speedups of optimized vectorized code with systematic and selective strategy
speedups <- data.frame(backprop=c(dataAggregate["backprop_matlab"]/dataAggregate["backprop_mc2mc"],
                                 dataAggregate["backprop_matlab"]/dataAggregate["backprop_mc2mc_selective"]),
                      crni=c(dataAggregate["crni_matlab"]/dataAggregate["crni_mc2mc"],
                             dataAggregate["crni_matlab"]/dataAggregate["crni_mc2mc_selective"]),
                      fft=c(dataAggregate["fft_matlab"]/dataAggregate["fft_mc2mc"],
                            dataAggregate["fft_matlab"]/dataAggregate["fft_mc2mc_selective"]),
                      nw=c(dataAggregate["nw_matlab"]/dataAggregate["nw_mc2mc"],
                           dataAggregate["nw_matlab"]/dataAggregate["nw_mc2mc_selective"]),
                      pagerank=c(dataAggregate["pagerank_matlab"]/dataAggregate["pagerank_mc2mc"],
                                 dataAggregate["pagerank_matlab"]/dataAggregate["pagerank_mc2mc_selective"]))
# Save as pdf (A5 format)
pdf("mc2mc-optimized.pdf", width = 8.27, height = 5.83)
# Modify plot margins
par(mfrow=c(1, 1), mar=c(5, 5, 2, 5))
# Plot vectorization strategies comparison
barplot(as.matrix(speedups), 
        beside=T, 
        axes = T,
        xlab = "Benchmark",
        ylab = "Speedup",
        ylim= c(0, 2.0),
        col=c("#f0f0f0","#bdbdbd"),
        cex.names = 1.5,
        cex.axis = 1.5,
        cex.lab=1.5,
        legend = c("Systematic", "Selective (optimized)"), 
        args.legend = list(x ='topright',
                           bty="n",
                           cex=1.5,
                           horiz=F,
                           inset=c(0.15, -0.05),
                           title=expression(bold(underline("Strategy"))), title.col="black"))
# Plot baseline
abline(a = 1, b= 0, col="gray", lty=5)
# ... with a text !
text(8.7, 1.06, "baseline", col="gray", cex=1.2)
# Finish plotting
dev.off()
