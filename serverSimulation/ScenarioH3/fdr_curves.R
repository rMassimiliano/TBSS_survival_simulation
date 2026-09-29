library(arrow)
library(dplyr)
library(TBSS)

nodeListH0 = paste0('Node-', c(8:11,14:23,4,5,2)) ## nodes that are not linked in any way to node 6 (signal) --- so rejecting this nodes is a false positive
nodeListH1 = c('Node-13','Node-24', 'Node-25','Node-6')
allH1 = setdiff(paste0("Node-",1:25),nodeListH0)


get_rates = function(dat)
{
dat |> group_by(beta) |> summarize(fdr = mean(rH0/pmax(1,n_rej)), tps = mean(rallH1/pmax(1,n_rej)), pow = mean(rH1 ))
}



results_path = 'results/bernoulliTBSS'

file_list = list.files(results_path)
d = length(file_list)


power_curve = data.frame(id = numeric(d), beta  = numeric(d), rH0 = numeric(d), rH1 = numeric(d), rallH1 = numeric(d), n_rej = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r]    = c_id
 power_curve$beta[r]  = c_beta

 S = c_res[[1]]

 power_curve$rH0[r]   = sum(S$pval[S$node  %in% nodeListH0] <=0.05)
 power_curve$rH1[r]   = sum(S$pval[S$node  %in% nodeListH1] <=0.05)
 power_curve$n_rej[r] = sum(S$pval <=0.05)
 power_curve$rallH1[r]   = sum(S$pval[S$node  %in% allH1] <=0.05)

 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}


get_rates(power_curve) |> write.csv(file = "hs3_bernoulli_fdr.csv")




results_path = 'results/poissonTBSS/'

file_list = list.files(results_path)
d = length(file_list)


power_curve = data.frame(id = numeric(d), beta  = numeric(d), rH0 = numeric(d), rH1 = numeric(d), rallH1 = numeric(d), n_rej = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r]    = c_id
 power_curve$beta[r]  = c_beta

 S = c_res[[1]]

 power_curve$rH0[r]   = sum(S$pval[S$node  %in% nodeListH0] <=0.05)
 power_curve$rH1[r]   = sum(S$pval[S$node  %in% nodeListH1] <=0.05)
 power_curve$n_rej[r] = sum(S$pval <=0.05)
 power_curve$rallH1[r]   = sum(S$pval[S$node  %in% allH1] <=0.05)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}

get_rates(power_curve) |> write.csv(file = "hs3_poisson_fdr.csv")



results_path = 'results/poissonSTBSS/'

file_list = list.files(results_path)
d = length(file_list)


power_curve = data.frame(id = numeric(d), beta  = numeric(d), rH0 = numeric(d), rH1 = numeric(d), rallH1 = numeric(d), n_rej = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r]    = c_id
 power_curve$beta[r]  = c_beta

 S = c_res[[1]]

 power_curve$rH0[r]   = sum(S$pval[S$node  %in% nodeListH0] <=0.05)
 power_curve$rH1[r]   = sum(S$pval[S$node  %in% nodeListH1] <=0.05)
 power_curve$n_rej[r] = sum(S$pval <=0.05)
 power_curve$rallH1[r]   = sum(S$pval[S$node  %in% allH1] <=0.05)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}

get_rates(power_curve) |> write.csv(file = "hs3_poissonS_fdr.csv")






results_path = 'results/robustTBSS/'

file_list = list.files(results_path)
d = length(file_list)

power_curve = data.frame(id = numeric(d), beta  = numeric(d), rH0 = numeric(d), rH1 = numeric(d), rallH1 = numeric(d), n_rej = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r]    = c_id
 power_curve$beta[r]  = c_beta
 power_curve$rH0[r]   = sum(c_res[[1]]$pval[c_res[[1]]$node  %in% nodeListH0] <=0.05)
 power_curve$rH1[r]   = sum(c_res[[1]]$pval[c_res[[1]]$node  %in% nodeListH1] <=0.05)
 power_curve$rallH1[r]   = sum(c_res[[1]]$pval[c_res[[1]]$node  %in% allH1] <=0.05)
 power_curve$n_rej[r] = sum(c_res[[1]]$pval <=0.05)

 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}

get_rates(power_curve) |>   write.csv(file = "hs3_robust_fdr.csv")

results_path = 'results/coxTBSS/'

file_list = list.files(results_path)
d = length(file_list)



power_curve = data.frame(id = numeric(d), beta  = numeric(d), rH0 = numeric(d), rH1 = numeric(d), rallH1 = numeric(d), n_rej = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r]    = c_id
 power_curve$beta[r]  = c_beta
 power_curve$rH0[r]   = sum(c_res[[1]]$pval[c_res[[1]]$node  %in% nodeListH0] <=0.05)
 power_curve$rH1[r]   = sum(c_res[[1]]$pval[c_res[[1]]$node  %in% nodeListH1] <=0.05)
 power_curve$n_rej[r] = sum(c_res[[1]]$pval <=0.05)
 power_curve$rallH1[r]   = sum(c_res[[1]]$pval[c_res[[1]]$node  %in% allH1] <=0.05)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}

get_rates(power_curve) |>
        write.csv(file = "hs3_cox_fdr.csv")

