## compute the Bernoulli TBSS for each of the generated data
## we use 1:1 matching


Indices = matrix(1:20000, ncol = 20, byrow = TRUE)


library(arrow)
library(optparse)
library(TBSS)
library(dplyr)
library(MatchIt)
source("../Rscr/compute_cens_paramameter.R")

setGeneric("computeSS", function(object, parallel = FALSE, ncpus = NULL) {
  standardGeneric("computeSS")
})
setGeneric("computeLRT", function(object, parallel = FALSE, ncpus = NULL) {
  standardGeneric("computeLRT")
})

setGeneric("H0_gen", function(object) {
  standardGeneric("H0_gen")
})

source("../Rscr/allUnconditionalBernoulliTS.R")
source("../Rscr/MC.R")




option_list = list(
  make_option(c("-r","--replicate"), type="integer", default=NULL, 
              help="number of the simulation", metavar="integer")
) 

opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)
r = opt$replicate 



results_path = 'results/bernoulliTBSS'

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

 ## for each match set count events happened from 0 to shorthers followup
 c_dat$events = 0 
 for(k in 1:NROW(mi))
 {
	 stat = c_dat[mi[k,],]$status       ## status
         tim = c_dat[mi[k,],]$time_to_event ## time
	 fup = min(tim)                     ## shortest time
         c_dat$events[mi[k,]] = with(c_dat[mi[k,],], status*I(time_to_event <= fup)) ## event censoring
 }

## total events vs uncensored in matched population
tab = rbind( c(with(c_dat[c(mi),], tapply(status,exposure,sum)), sum(c_dat$status)),
           c(with(c_dat[c(mi),], tapply(events,exposure,sum)), sum(c_dat$events)))
colnames(tab) = c("control", "exposed", "total")
rownames(tab) = c("observed","after_censoring")

## summarize events for each leaves
suppressMessages({c_dat = c_dat[c(mi),] |> 
	group_by(leaf,exposure) |>
	summarize(events = sum(events))})

## create control and case file
control = c_dat[c_dat$exposure==0,c("leaf","events")]
case = c_dat[c_dat$exposure==1,c("leaf","events")]

dat = as.data.frame(dplyr::full_join(case, control,  by = "leaf")) 
dat = dplyr::mutate_at(dat, 2:3, function(x) coalesce(x,  0L))
names(dat) = c("leaf", "case", "control")

## Bernoulli TBSS  analysis -- switch cases and controll
exec_time = system.time({
  myTS = new("allUnconditionalBernoulliTS", data =  dat, tree = tree, p = 1/2 )
  myTS = TBSS:::mapNodesLeaves(myTS)
  myTS = computeSS(myTS)
  myTS = computeLRT(myTS)
  myTS@B = 9999
  myTS = monteCarlo(myTS)
  })
##
results = list(mod_TBSS = summary(myTS), exec_time = exec_time, event_summary =  tab)
file = sprintf("%s/res_id_%i_beta_%i.rds",results_path, c_id, c_beta)
saveRDS(results,file)
cat(sprintf("Done %i/%i\n",j,length(file_list)))
}

