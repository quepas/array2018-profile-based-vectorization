source("findLast.R")
data <- read.csv("../results/pagerank1_2015b.csv", header = FALSE);
colnames(data) <- c("sample", "loop", "lcpc", "hhm")

par(mfrow=c(1, 3))
x <- data$sample
plot(x, data$loop, type="l")
lines(x, data$lcpc, lty=2)
lines(x, data$hhm, lty=1, col="red")

loopFit <- loess(loop ~ sample, data)
lcpcFit <- loess(lcpc ~ sample, data)
hhmFit <- loess(hhm ~ sample, data)
plot(x, predict(loopFit, x), lty=1, type="l")
lines(x, predict(lcpcFit, x), lty=2)
lines(x, predict(hhmFit, x), lty=1, col="red")

suHHM <- predict(loopFit, x) / predict(hhmFit, x)
suLCPC <- predict(loopFit, x) / predict(lcpcFit, x)
plot(x, suHHM, type="l", col="red")
lines(x, suLCPC)
#z <- x[seq(1, length(x), 7)]
#lines(z,type="b", predict(loopFit, z) / predict(lcpcFit, z), pch=c(2))

abline(1.05, 0, col="gray")
abline(1, 0, col="gray", lty=3)

minSU <- 1.1 # 10%

maskHHM <- suHHM > minSU
maskLCPC <- suLCPC > minSU

lastHHM <- findLast(maskHHM)
lastLCPC <- findLast(maskLCPC)
# First point more than 1.05 speedup (5%)
positiveHHM <- x[suHHM > minSU]
positiveLCPC <- x[suLCPC > minSU]
cat(sprintf("[HHM]\n\tNaive constraint: %d\n", positiveHHM[1]))
cat(sprintf("\tBetter constraint: %d\n", data$sample[lastHHM]))
cat(sprintf("[LCPC]\n\tNaive constraint: %d\n", positiveLCPC[1]))
cat(sprintf("\tBetter constraint: %d\n", data$sample[lastLCPC]))

#data$sample[maskLCPC]
