library(scales)
color1 = "#DDAA33" ## bern
color2 = "#00239C" ## expone
color3 = '#f44546' ## cox
color4 = '#039c4b' ## rob



path = '../resultSummaries/computingTimes/'
fileList = list.files(path)
method_list = c( 'bernoulliTBSS', 'coxTBSS', 'poissonSTBSS', 'poissonTBSS', 'robustTBSS')
names_list = c( 'bernoulliTBSS', 'coxTBSS', 'exponentialTBSS', 'poissonTBSS', 'robustTBSS')
ctimes = lapply(fileList, \(x) read.csv(sprintf("%s/%s",path, x)))

ctimes = do.call("rbind", ctimes)
colnames(ctimes) = c("id",names_list)

## order Poisson Bernoulli Exponential Cox Robust -- as in fig 1
ctimes = ctimes[,-1] 
ctimes = ctimes[, c(4,1,3,2,5)]

color_list = c("#000000", color1,color2,color3,color4)
## apply some transparenty
bcol = sapply(color_list, \(x) scales::alpha(x,0.5))


pdf("comp_time.pdf",width = 8.5, height = 5)
plot(NULL,NULL, xlim = c(0.7,5.3), ylim = c(1,8), ylab = 'Elapsed time in log seconds', xlab ='Method', xaxt = 'n', yaxt = 'n')
abline(h =seq(1,8,by =1), col = 'grey80')
boxplot(log(ctimes), col = bcol, add = T, boxwex = 0.5) 
dev.off()

#cbind(apply(ctimes,2,mean), apply(ctimes,2,sd))

