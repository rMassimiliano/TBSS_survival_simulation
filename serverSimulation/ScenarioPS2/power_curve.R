library(dplyr)

cat("Computing -- Bernoulli")
results_path = 'results/bernoulliTBSS'

file_list = list.files(results_path)
d = length(file_list)

power_curve = data.frame(id = numeric(d), beta  = numeric(d), pvalue = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r] = c_id
 power_curve$beta[r] = c_beta
 power_curve$pvalue[r] = min(c_res[[1]]$pvalue)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}


power_curve |>
	group_by(beta) |>
	summarize(power = mean(pvalue <=0.05)) |>
   write.csv(file = "sp2_bernoulli_power.csv")




cat("Computing -- Exponential")

results_path = 'results/exponentialTBSS/'

file_list = list.files(results_path)
d = length(file_list)

power_curve = data.frame(id = numeric(d), beta  = numeric(d), pvalue = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r] = c_id
 power_curve$beta[r] = c_beta
 power_curve$pvalue[r] = min(c_res[[1]]$pvalue)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}


power_curve |>
	group_by(beta) |>
	summarize(power = mean(pvalue <=0.05)) |>
   write.csv(file = "sp2_exponential_power.csv")


cat("Computing -- Poisson")
results_path = 'results/poissonTBSS/'

file_list = list.files(results_path)
d = length(file_list)

power_curve = data.frame(id = numeric(d), beta  = numeric(d), pvalue = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r] = c_id
 power_curve$beta[r] = c_beta
 power_curve$pvalue[r] = min(c_res[[1]]$pvalue)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}


power_curve |>
	group_by(beta) |>
	summarize(power = mean(pvalue <=0.05)) |>
   write.csv(file = "sp2_poisson_power.csv")



cat("Computing -- survival Poisson")
results_path = 'results/poissonSTBSS/'

file_list = list.files(results_path)
d = length(file_list)

power_curve = data.frame(id = numeric(d), beta  = numeric(d), pvalue = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r] = c_id
 power_curve$beta[r] = c_beta
 power_curve$pvalue[r] = min(c_res[[1]]$pvalue)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}


power_curve |>
	group_by(beta) |>
	summarize(power = mean(pvalue <=0.05)) |>
   write.csv(file = "sp2_poissonS_power.csv")


cat("Computing -- robust survival ")
results_path = 'results/robustTBSS/'

file_list = list.files(results_path)
d = length(file_list)

power_curve = data.frame(id = numeric(d), beta  = numeric(d), pvalue = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r] = c_id
 power_curve$beta[r] = c_beta
 power_curve$pvalue[r] = min(c_res[[1]]$pvalue)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}


power_curve |>
	group_by(beta) |>
	summarize(power = mean(pvalue <=0.05)) |>
   write.csv(file = "sp2_robust_power.csv")



cat("Computing -- Cox TBSS")
results_path = 'results/coxTBSS/'

file_list = list.files(results_path)
d = length(file_list)

power_curve = data.frame(id = numeric(d), beta  = numeric(d), pvalue = numeric(d))
for(r in 1:d)
{
 c_file = file_list[r]
 info = strsplit(c_file, "_")[[1]]
 c_id = as.numeric(info[3])
 c_beta   = as.numeric(strsplit(info[5], "[.]rds")[[1]])
 c_res = readRDS(sprintf("%s/%s",results_path,c_file))

 power_curve$id[r] = c_id
 power_curve$beta[r] = c_beta
 power_curve$pvalue[r] = min(c_res[[1]]$pvalue)
 if(r%%1000 ==0) cat(sprintf("Done %i/%i \n",r,d))
}


power_curve |>
	group_by(beta) |>
	summarize(power = mean(pvalue <=0.05)) |>
   write.csv(file = "sp2_cox_power.csv")
