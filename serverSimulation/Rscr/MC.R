  monteCarlo = function(object, parallel = FALSE, ncpus = NULL)
  {
   # a single MC sample
   do_MC = function(...)
   {
    boot_object = object
    ## re-generate data under the null
    boot_object = H0_gen(object)
 
    retval = computeLRT(boot_object)@LRT
    return(retval)
}
if(parallel)
{
 suppressMessages(require(parallel))
 suppressMessages(require(TBSS))
 cl <- makeCluster(ncpus)
 clusterExport(cl, "do_MC", envir = environment())
 clusterExport(cl, "object", envir = environment())
 boot_LRT = parSapply(cl, 1:object@B, do_MC)
 stopCluster(cl)
}
else
{
	## non-parallel version
 boot_LRT =  sapply(1:object@B, do_MC)
}

 object@LRT_H0 = boot_LRT
 return(object)
}
  
