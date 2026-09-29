## compute the exponential TBSS for each of the generated data

Indices = matrix(1:20000, ncol = 20, byrow = TRUE)



library(arrow)
library(optparse)
library(TBSS)
library(dplyr)
library(MatchIt)
source("../Rscr/compute_cens_paramameter.R")
source("../Rscr/get_pval_exp.R")

setGeneric("computeSS", function(object, parallel = FALSE, ncpus = NULL) {
  standardGeneric("computeSS")
})

setGeneric("computeLRT", function(object, parallel = FALSE, ncpus = NULL) {
  standardGeneric("computeLRT")
})


setGeneric("H0_gen", function(object) {
  standardGeneric("H0_gen")
})

source("../Rscr/robustSurvivalTS.R")
source("../Rscr/MC.R")

option_list = list(
  make_option(c("-r","--replicate"), type="integer", default=NULL, 
              help="number of the simulation", metavar="integer")
) 

opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)
r = opt$replicate 

results_path = 'results/robustTBSS'

file_list = list.files('data/')

tree = get(data(tree_example));rm(tree_example)

for(j in Indices[r,])
{
 c_file = file_list[j]
 info   = strsplit(c_file, "_")[[1]][c(3,5)]
 c_id   = as.numeric(info[1])
 c_beta = as.numeric(strsplit(info[2],"[.]parquet")[[1]][1])

 c_dat  = read_parquet(sprintf("data/%s",c_file)) 
 

 ## matching 
 estimand = ifelse(sum(c_dat$exposure)  <=0.5*NROW(c_dat), "ATT", "ATC")
 PS =  glm(exposure~x1+x2,data = c_dat, family ='binomial')$fit
 caliper = 0.2*sd(PS)
 mi = matchit(exposure~x1+x2, replace = FALSE, m.order = 'closest', data = c_dat, estimand = estimand, caliper = caliper)
 mi =  cbind(as.numeric(rownames(mi$match.matrix)), as.numeric(mi$match.matrix[,1]))
 mi = mi[complete.cases(mi),]

tab = rbind( c(with(c_dat, tapply(status,exposure,sum)), sum(c_dat$status)),
           c(with(c_dat[c(mi),], tapply(status,exposure,sum)), sum(c_dat[c(mi),]$status)))
colnames(tab) = c("control", "exposed", "total")
rownames(tab) = c("observed","matched")


 suppressMessages({
 c_dat = c_dat[c(mi),] |>
	 group_by(leaf,exposure) |>
	 summarize(sample_size = n(),
                   events = sum(status),
		   total_person_time = sum(time_to_event),
total_person_time_SOS = sum(time_to_event^2),
uncensored_person_time =sum(time_to_event*status))
 })

 ## cases
cases = c_dat[c_dat$exposure==1,-2]
names(cases)[-1] = paste0(names(cases)[-1],"_case")

##control 
control = c_dat[c_dat$exposure==0,-2]
names(control)[-1] = paste0(names(control)[-1],"_control")

## data ready
dat = full_join(cases, control, by ='leaf')



exec_time = system.time({
## Exponential TBSS  analysis
myTS = new("robustSurvivalTS", data = as.data.frame(dat), tree = tree)
myTS = TBSS:::mapNodesLeaves(myTS)
myTS = computeSS(myTS)
myTS = computeLRT(myTS)
myTS@B = 9999

myTS = monteCarlo(myTS)
})

results = list(mod_TBSS = get_pval_exp(myTS), exec_time = exec_time, event_summary =  tab)
file = sprintf("%s/res_id_%i_beta_%i.rds",results_path, c_id, c_beta)
saveRDS(results,file)


cat(sprintf("Done %i/%i\n",j,length(file_list)))
}

