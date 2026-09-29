## compute the Bernoulli TBSS for each of the generated data
## follow-up time is pre-specified in such a way that the average number of events observed in the study period is 80%


Indices = matrix(1:20000, ncol = 20, byrow = TRUE)


library(arrow)
library(optparse)
library(TBSS)
library(dplyr)
library(MatchIt)


option_list = list(
  make_option(c("-r","--replicate"), type="integer", default=NULL, 
              help="number of the simulation", metavar="integer")
) 

opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)
r = opt$replicate 



results_path = 'results/poissonTBSS'

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


## total events vs uncensored
tab = rbind( c(with(c_dat[c(mi),], tapply(status,exposure,sum)), sum(c_dat$status)))
colnames(tab) = c("control", "exposed", "total")

## summarize events for each leaves
suppressMessages({c_dat = c_dat[c(mi),] |> 
	group_by(leaf,exposure) |>
	summarize(events = sum(status), time_to_event = sum(time_to_event))})

## create control and case file
control = c_dat[c_dat$exposure==0,c("leaf","events", "time_to_event")]
case = c_dat[c_dat$exposure==1,c("leaf","events","time_to_event")]

names(control)[2] = 'expected'
names(control)[3] = 'time_to_event_con'

## Rescale time to make control comparable to cases in terms of time
c_dat = full_join(case,control)
c_dat = c_dat |> mutate(expected = expected/time_to_event_con * time_to_event) |> select(-time_to_event, - time_to_event_con)



## Poisson TBSS  analysis
exec_time = system.time({ mod_TBSS = poissonTBSS(c_dat,tree, B = 9999, parallel = FALSE,direction ='all' )})
##
##
results = list(mod_TBSS = summary(mod_TBSS), exec_time = exec_time, event_summary =  tab)


file = sprintf("%s/res_id_%i_beta_%i.rds",results_path, c_id, c_beta)
saveRDS(results,file)
cat(sprintf("Done %i/%i\n",j,length(file_list)))
}

