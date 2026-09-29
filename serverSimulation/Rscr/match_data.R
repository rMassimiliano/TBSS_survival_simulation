#' Propensity score matching with caliper (optional) and without replacement
#' @description Perform propensity score matching in order of distance (i.e., best matched first).
#' @param PS, a propensity score to be used for the matching 
#' @param S0 indices (i.e., element of PS) for the comparator (control) group 
#' @param S1 indices (i.e., element of PS) for the exposure (treatment) group 
#' @param caliper. If distance is larger than caliper observation are not matched. Default is \code{Inf} corresponding to no caliper

match_data = function(PS,S0,S1, caliper = Inf)
{
  ##  compute distance (absolute difference)
  #dist = abs(outer(PS,PS, "-"))
  dist = as.matrix(dist(PS, method = 'man'))
  
  ## select distance from treated to control
  cDist = dist[S1,S0]
  ## position of the best possible match
  cmin = arrayInd(which.min(cDist),.dim = dim(cDist))
  ## result place holder
  mpairs = NULL

  ## using a caliper
  while(TRUE)
  {
  if(cDist[cmin[1],cmin[2]] <= caliper)
  {
   mpairs = rbind(mpairs,c(S1[cmin[1]],S0[cmin[2]]))
  }
  else return(mpairs)
  ## remove matched subject
  S1 = setdiff(S1,S1[cmin[1]])
  S0 = setdiff(S0,S0[cmin[2]])
  if(length(S0) ==0 | length(S1) == 0) return(mpairs)
  cDist = matrix(dist[S1,S0], ncol = length(S0), nrow = length(S1)) ## force matrix format for arrayInd function
  cmin = arrayInd(which.min(cDist),.dim = dim(cDist))
}
}
