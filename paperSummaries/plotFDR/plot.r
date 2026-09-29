## color definitions1
color1 = "#DDAA33"
color2 = "#00239C"
color3 = '#f44546'
color4 = '#039c4b'



## x axis (exposure effect)
exp_beta_seq = seq(1,2.5, length = 20) 

## Loading data
########
bern1 = read.csv("../resultSummaries/power/s1_bernoulli_fdr.csv")
cox1  = read.csv("../resultSummaries/power/s1_cox_fdr.csv")
spois1 = read.csv("../resultSummaries/power/s1_poissonS_fdr.csv")
pois1 = read.csv("../resultSummaries/power/s1_poisson_fdr.csv")
rob1 = read.csv("../resultSummaries/power/s1_robust_fdr.csv")


##########
bern2  = read.csv("../resultSummaries/power/s2_bernoulli_fdr.csv")
cox2   = read.csv("../resultSummaries/power/s2_cox_fdr.csv")
spois2 = read.csv("../resultSummaries/power/s2_poissonS_fdr.csv")
pois2  = read.csv("../resultSummaries/power/s2_poisson_fdr.csv")
rob2   = read.csv("../resultSummaries/power/s2_robust_fdr.csv")

#########
bern3  = read.csv("../resultSummaries/power/s3_bernoulli_fdr.csv")
cox3   = read.csv("../resultSummaries/power/s3_cox_fdr.csv")
spois3 = read.csv("../resultSummaries/power/s3_poissonS_fdr.csv")
pois3  = read.csv("../resultSummaries/power/s3_poisson_fdr.csv")
rob3   = read.csv("../resultSummaries/power/s3_robust_fdr.csv")

##########
bernSp1  = read.csv("../resultSummaries/power/ps1_bernoulli_fdr.csv")
coxSp1   = read.csv("../resultSummaries/power/ps1_cox_fdr.csv")
spoisSp1 = read.csv("../resultSummaries/power/ps1_poissonS_fdr.csv")
poisSp1  = read.csv("../resultSummaries/power/ps1_poisson_fdr.csv")
robSp1   = read.csv("../resultSummaries/power/ps1_robust_fdr.csv")

##########
bernSp2  = read.csv("../resultSummaries/power/ps2_bernoulli_fdr.csv") 
coxSp2   = read.csv("../resultSummaries/power/ps2_cox_fdr.csv")
spoisSp2 = read.csv("../resultSummaries/power/ps2_poissonS_fdr.csv")
poisSp2  = read.csv("../resultSummaries/power/ps2_poisson_fdr.csv")
robSp2   = read.csv("../resultSummaries/power/ps2_robust_fdr.csv")

##########
bernSp3  = read.csv("../resultSummaries/power/ps3_bernoulli_fdr.csv")
coxSp3   = read.csv("../resultSummaries/power/ps3_cox_fdr.csv")
spoisSp3 = read.csv("../resultSummaries/power/ps3_poissonS_fdr.csv")
poisSp3  = read.csv("../resultSummaries/power/ps3_poisson_fdr.csv")
robSp3   = read.csv("../resultSummaries/power/ps3_robust_fdr.csv")


##########
bernHs1  = read.csv("../resultSummaries/power/hs1_bernoulli_fdr.csv")
coxHs1   = read.csv("../resultSummaries/power/hs1_cox_fdr.csv")
spoisHs1 = read.csv("../resultSummaries/power/hs1_poissonS_fdr.csv")
poisHs1  = read.csv("../resultSummaries/power/hs1_poisson_fdr.csv")
robHs1   = read.csv("../resultSummaries/power/hs1_robust_fdr.csv")


##########
bernHs2  = read.csv("../resultSummaries/power/hs2_bernoulli_fdr.csv")
coxHs2   = read.csv("../resultSummaries/power/hs2_cox_fdr.csv")
spoisHs2 = read.csv("../resultSummaries/power/hs2_poissonS_fdr.csv")
poisHs2  = read.csv("../resultSummaries/power/hs2_poisson_fdr.csv")
robHs2   = read.csv("../resultSummaries/power/hs2_robust_fdr.csv")

##########
bernHs3  = read.csv("../resultSummaries/power/hs3_bernoulli_fdr.csv")
coxHs3   = read.csv("../resultSummaries/power/hs3_cox_fdr.csv")
spoisHs3 = read.csv("../resultSummaries/power/hs3_poissonS_fdr.csv")
poisHs3  = read.csv("../resultSummaries/power/hs3_poisson_fdr.csv")
robHs3   = read.csv("../resultSummaries/power/hs3_robust_fdr.csv")


## 1-1

pdf("sim_fdr11.pdf",width = 4.25, height = 4.25)
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(pois1,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bern1,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spois1,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(cox1,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(rob1,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
#title( main= "Scenario 1", line = 0.4)
dev.off()


pdf("sim_fdr12.pdf",width = 4.25, height = 4.25)
## 1-2
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(pois2,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bern2,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spois2,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(cox2,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(rob2,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
#title( main= "Scenario 2", line = 0.4)
dev.off()

## 1-3
pdf("sim_fdr13.pdf",width = 4.25, height = 4.25)
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(pois3,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bern3,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spois3,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(cox3,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(rob3,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
#title( main= "Scenario 3", line = 0.4)
dev.off()



## 2-1
pdf("sim_fdr21.pdf",width = 4.25, height = 4.25)
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(poisSp1,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bernSp1,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spoisSp1,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(coxSp1,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(robSp1,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
dev.off()

## 2-2
pdf("sim_fdr22.pdf",width = 4.25, height = 4.25)
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(poisSp2,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bernSp2,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spoisSp2,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(coxSp2,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(robSp2,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
dev.off()


## 2-3
pdf("sim_fdr23.pdf",width = 4.25, height = 4.25)
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(poisSp3,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bernSp3,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spoisSp3,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(coxSp3,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(robSp3,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
dev.off()

##3-1

pdf("sim_fdr31.pdf",width = 4.25, height = 4.25)
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(poisHs1,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bernHs1,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spoisHs1,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(coxHs1,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(robHs1,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
dev.off()
##3-2

pdf("sim_fdr32.pdf",width = 4.25, height = 4.25)
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(poisHs2,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bernHs2,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spoisHs2,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(coxHs2,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(robHs2,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
dev.off()
##3-3
pdf("sim_fdr33.pdf",width = 4.25, height = 4.25)
plot(NULL,NULL, xlim = range(exp_beta_seq), ylim = c(0,1), xlab = '', ylab ='')
abline(h =seq(0,1,by =0.2), col = 'grey80')
abline(h =0.05, lty = 'dashed')
with(poisHs3,points(exp_beta_seq,fdr, pch = 15, type = 'b'))
with(bernHs3,points(exp_beta_seq,fdr, col =color1, pch =15, type = 'b'))
with(spoisHs3,points(exp_beta_seq,fdr, col = color2, pch = 15, type ='b'))
with(coxHs3,points(exp_beta_seq[beta],fdr, col = color3, pch = 15, type ='b'))
with(robHs3,points(exp_beta_seq,fdr, col = color4, pch = 15, type ='b'))
title(y = 'Proportion of false positives', x = 'Exposure Effect')
dev.off()

pdf("legend.pdf",width = 11, height = 4.25)
#par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
   plot(0, 0, type = 'l', bty = 'n', xaxt = 'n', yaxt = 'n')
legend("top",col = c(1,color1,color2,color3,color4), legend = c('Poisson','Bernoulli', 'Exponential','Cox','Robust'),pch = 15, horiz = TRUE,xpd = TRUE, inset = 0.05,text.width= 0.23)
dev.off()




