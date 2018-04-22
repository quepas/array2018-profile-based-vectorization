data <- read.csv("rep5.csv")
time <- data$mean
newdata <- data.frame(backprop=c(time[1]/time[2], time[1]/time[3]),
                      crni=c(time[4]/time[5], time[4]/time[6]),
                      fft=c(time[7]/time[8], time[7]/time[9]),
                      nw=c(time[10]/time[11], time[10]/time[12]),
                      pagerank=c(time[13]/time[14], time[13]/time[15]))

par(mfrow=c(1, 1), mar=c(5, 5, 2, 5))
rownames(newdata) <- c("mc2mc", "mc2mc-selective")
b<-barplot(as.matrix(newdata), 
           beside=T, 
           col=c("#f0f0f0","#bdbdbd"),
           legend = c("Selective", "Selective (optimized)"), 
           args.legend = list(x ='topright', bty="n", cex=1.5, horiz=F, inset=c(0.15, -0.05), title=expression(bold(underline("Strategy"))), title.col="black"),
           xlab = "Benchmark",
           ylab = "Speed-up",
           ylim= c(0, 2.0),
           axes = T,
           cex.names = 1.5,
           cex.axis = 1.5,
           cex.lab=1.5
           )
abline(a = 1, b= 0, col="gray", lty=5)
text(8.7, 1.06, "baseline", col="gray", cex=1.2)
