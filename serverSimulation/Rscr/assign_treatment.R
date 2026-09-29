##++++++++++++++++++++++++++++++++++++++++++
##++++++++++++++++++++++++++++++++++++++++++
##++ Utility functions for 2-stages ++++++++
##++++++++++++++++++++++++++++++++++++++++++



## treatment assignment model
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#' @description function that assign patient to treatment. For randomized trial we randomize to treatment with prob p. For observational study we use a logistic function of measured and unmesured confounders. 

#' @param X matrix of confounders (measured and unmeasured) used in the treatment assignment model. Note that X DOES NOT include a colum of 1s (i.e., intercept)
## typically we fix the intercept to have a certain proportion of treated (e.g. 1/2) 

#' @param beta effect of the confounders on the logistic scale.

#' @param p proportion of patients assigned to treatment. Note that if \code{method ='logistic'} the model intercet is chosen to have average number of p treated individuals.

#' @param method. Either `random` to assign patient to treatment with probability p (in this case the parameters X and beta are ignored) or `logistic` to assign patients to treatment via a logistic regression with linear predicto \code{a + X %*% beta}. The intercerpt \code{a} is chosen in such a wuy that the propotion of treated is in average \code{p}.

assign_treatment = function(X,beta, p= 1/2, method = 'random')
{
   match.arg(method, c("random", "logistic"))
   n = NROW(X)
   if(method =='random') 
   {
    mus = rep(p,n)
    A= rbinom(n,1, mus)
   }
   if(method == 'logistic')
   {
    etas = X%*%beta
    # 1 determine intercept such that the proportion of treated =p
    
    beta0 = uniroot(\(x) mean(plogis(x + etas)) -p,c(-10,10),  extendInt =  "yes")$root
    etas = etas  + beta0
    mus = plogis(etas)
    A  = rbinom(n,1,mus) 
   }
   res = cbind(A,mus)
   return(res)
}

