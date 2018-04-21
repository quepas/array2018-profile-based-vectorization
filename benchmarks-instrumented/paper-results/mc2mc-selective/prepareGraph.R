data <- read.csv("results_100rep.csv")

one <- data.frame(time=data$crni_matlab, benchmark=factor("crni"),code=factor("matlab"))
colnames(one) <- c("time", "benchmark", "code")
two <- data.frame(time=data$crni_mc2mc, benchmark=factor("crni"),code=factor("mc2mc"))
colnames(two) <- c("time", "benchmark", "code")
three <- data.frame(time=data$crni_mc2mc_selective, benchmark=factor("crni"),code=factor("mc2mc_selective"))
colnames(three) <- c("time", "benchmark", "code")

newdata <- rbind(one, two, three)

one <- data.frame(time=data$nw_matlab, benchmark=factor("nw"),code=factor("matlab"))
colnames(one) <- c("time", "benchmark", "code")
two <- data.frame(time=data$nw_mc2mc, benchmark=factor("nw"),code=factor("mc2mc"))
colnames(two) <- c("time", "benchmark", "code")
three <- data.frame(time=data$nw_mc2mc_selective, benchmark=factor("nw"),code=factor("mc2mc_selective"))
colnames(three) <- c("time", "benchmark", "code")

newdata <- rbind(newdata, one, two, three)

boxplot(time ~ code + benchmark, newdata, bty="n")

col <- colMeans(data)
su <- c(col["crni_matlab"]/col["crni_mc2mc"], col["crni_matlab"]/col["crni_mc2mc_selective"], col["nw_matlab"]/col["nw_mc2mc"], col["nw_matlab"]/col["nw_mc2mc_selective"])

par(mfrow=c(1, 1), mar=c(5, 5, 2, 13))
newdata <- data.frame(crni=su[1:2], nw=su[3:4])
rownames(newdata) <- c("mc2mc", "mc2mc-selective")
b<-barplot(as.matrix(newdata), 
           beside=T, 
           col=c("#f0f0f0","#bdbdbd"),
           legend = c("mc2mc", "mc2mc-selective"), 
           args.legend = list(x ='right', bty='n', cex=1.5, horiz=F, inset=c(-0.6, 0)),
           xlab = "Benchmark",
           ylab = "Speed-up",
           axes = T,
           cex.names = 1.5,
           cex.axis = 1.5,
           cex.lab=1.5
           )
abline(a = 1, b= 0, col="gray", lty=5)
mtext("baseline", col="gray")
