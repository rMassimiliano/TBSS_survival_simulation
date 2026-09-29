
## We consider the tree in TBSS package as an example
## the tree has 12 leaves Node-14 to Node-25
## we need to generate a dataset for each leaves
## we consider a AFT & PHM model i.e. weibul

library(arrow)
library(MatchIt)
library(TBSS)
source("../Rscr/compute_cens_paramameter.R")
source("../Rscr/assign_treatment.R")

leaves_names = paste0("Node-",13:25)


##-----------------------------------------
##-----------------------------------------
## Simulation parameters
##-----------------------------------------
##-----------------------------------------
save_data_path = 'data'
NREP = 1000 ## number of replicates for each scenario


n_ell    = 600 ## sample size for each leaf treated + untreated
k_ell    = 1  ## Weibul shape parameter k --- 1 is exponential
mu = 2    ## baseline scale parameter with 
exp_beta_seq = seq(0,2, length = 20) 
prop_obs = 0.8 ## ~80% observ*ed data in each group
px = 0.8 ## propo of binary observed confounder
ps_beta = c(1,1) ## true PS model coeffiecient
p0 = 1/2 ## proportion of treated (to set intercept in the true PS model)
outcome_beta = c(0.5,0.5) ## coeffient for outcome model

alternative_node = 'Node-6' ## vector of leaves where there is a TE
data(tree_example,package = 'TBSS')
myTS = new("TS")
myTS@tree = tree_example
myTS@leaves = leaves_names
myTS = TBSS:::mapNodesLeaves(myTS) 
alternative_leaves = myTS@mapNodesLeaves[[alternative_node]]

##-----------------------------------------
##-----------------------------------------
## Data generation
##-----------------------------------------
##-----------------------------------------
for(b in 1:length(exp_beta_seq))
{
for(i in 1:NREP)
{
#-----------------------------------------
c_data =  data.frame(leaf  = character(1), 
		     exposure = integer(1),
		     time_to_event = numeric(1),
		     status = integer(1),
                     x1 = integer(1),
                     x2 = numeric(1))

for(c_leaf in leaves_names)
{
 
 ## generate covariate
 ## ------------------------
 X = cbind(rbinom(n_ell,1,px), runif(n_ell))
 true_A =  assign_treatment(X,ps_beta, p =p0, method = 'logistic')
 eta =exp(X%*%outcome_beta) 
 ## baseline times
 times = rweibull(n_ell, shape = k_ell, scale = mu) * eta
 c_data  = rbind.data.frame(c_data, data.frame(leaf = c_leaf, exposure = true_A[,1], time_to_event = times, status = 1, x1 = X[,1], x2 = X[,2]))
}

c_data =  c_data[-1,]
## adding TE 
logistic_beta = exp_beta_seq[b]
eta_ps = as.matrix(c_data[with(c_data,leaf %in% alternative_leaves),5:6]) %*% ps_beta 
find_int = \(x) (mean(plogis(x +eta_ps + logistic_beta *c_data[with(c_data,leaf %in% alternative_leaves),]$time_to_event)) - 1/2)
logistic_alpha = uniroot(find_int,c(-1000,1000))$root
exp_prob = plogis(logistic_alpha + eta_ps + logistic_beta *c_data[with(c_data,leaf %in% alternative_leaves),]$time_to_event)
new_exp = rbinom(length(exp_prob),1, prob = exp_prob )
c_data[with(c_data,leaf %in% alternative_leaves),]$exposure= new_exp

# adding censoring 
mu_cens = compute_cens_parameter(w_shape = k_ell, w_scale = mu/exp(as.matrix(c_data[,5:6]) %*% outcome_beta), prop = prop_obs)
cens_time = rweibull(n_ell, shape = k_ell, scale = mu_cens)

c_data$time_to_event = pmin(c_data$time_to_event, cens_time)
c_data$status = 1*I(c_data$time_to_event <= cens_time)

c_file = sprintf("%s/data_id_%i_beta_%i.parquet",save_data_path,i,b)
write_parquet(c_data,c_file)
}
cat(sprintf("Done with scenario %i of %i \n",b,length(exp_beta_seq)))

}
