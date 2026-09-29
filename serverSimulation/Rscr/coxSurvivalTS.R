setClass(Class = "coxSurvivalTS",  contains = 'TS')


setMethod("computeSS", signature(object = "coxSurvivalTS"), function(object, parallel = FALSE, ncpus = NULL)
{

  library(survival)
  ## data frame that includes Sufficient Statistics For cases and control
  object@nodeSS = data.frame(node = names(object@mapNodesLeaves),
			     HR = 0L,
			     LRT = 0L)

  for(r in 1:length(object@mapNodesLeaves))
  {
   tmpData = dplyr::filter(object@data, object@data$leaf %in% object@mapNodesLeaves[[r]])

   mod = coxph(Surv(time_to_event, status)~exposure, data = tmpData)

   object@nodeSS$node[r] = names(object@mapNodesLeaves)[r]
   object@nodeSS$HR[r]   = exp(mod$coef)
   object@nodeSS$LRT[r]  = mod$score
  }
  return(object)
}
)


setMethod("computeLRT", signature(object = "coxSurvivalTS"), function(object) {
  if(length(object@mapNodesLeaves) == 0) object = mapNodesLeaves(object)
  if(length(object@nodeSS) == 0) object = computeSS(object)
  if(length(object@nodesToTest) == 0) object@nodesToTest = names(object@mapNodesLeaves)

  ## compute LLR for all the nodes
  LRT = numeric(length(object@nodesToTest))
  for(r in 1:length(object@nodesToTest))
  {
   j = which(object@nodeSS$node == object@nodesToTest[r])
   LRT[r] = object@nodeSS$LRT[j]
  }
   object@LRT = LRT
   names(object@LRT) = object@nodesToTest
   return(object)
 })


## this function return a vector of length n with element permuted within the groups defined by the argument strata (stratified permutation)
##  the function is adapeted from the  permutation.array function in the package boot and used within the H0_gen function
strata_perm =  function (n, strata) 
{
    output = seq_len(n)
    inds <- as.integer(names(table(strata)))
    for (is in inds) {
        group <- seq_len(n)[strata == is]
        if (length(group) > 1L) {
 	g = output[group][sample.int(length(group))]
        output[group]= g
        }
    }
    return(output)
}



setMethod("H0_gen", signature(object = "coxSurvivalTS"),
function (object)
{
    ## generate the leaves data under H0
    ## we generate data from the leaves even if these are not tested	  
	#object@data$exposure = sample(object@data$exposure)  ## --- no strata 
        #permuted_cohort = object@data  |> dplyr::group_by(strata) |> dplyr::slice_sample(prop = 1)  
        #permuted_cohort$exposure = object@data |> dplyr::arrange(strata) |> dplyr::pull(exposure)
	#object@data = permuted_cohort |> dplyr::ungroup() ## --- strata dplyr version (slow)

        #permuted_cohort = object@data
        #permuted_cohort$exposure = permuted_cohort$exposure[strata_perm(NROW(object@data),object@data$strata)]
	#object@data = permuted_cohort
        object@data$exposure = c(do.call("rbind", tapply(object@data$exposure,object@data$strata,sample))) ## faster pure R version


	object = computeSS(object)
	object = computeLRT(object)
        return(object)
}
)
