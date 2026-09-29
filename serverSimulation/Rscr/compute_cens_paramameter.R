#' @description This function computes the scale parameter of a Weibull distribution used for censoring in such a way that the average number of observed events is fixed to a certain proportion p. We consider Weibull distributed times and Weibull and Exponential censoring and use a model for competing risk. When both time-to-event and censoring time are Weibull (or exponential) there is a closed-form solution. When the time-to-event is Weibull but the censoring time is Exponential we can find a solution from the root of a function expressed via an integral. The integral is computed via quadrature and the solution of the solving equation is computed with uniroot.  Note that the solution returns 1/lambda if exponential.

#' @param w_shape shape of the Weibull distribution 
#' @param w_scale scale of the Weibull distribution 
#' @param prop desired proportion of observed events
#' @param cens_var distribution for the censoring time. Either `'weibull'` (the default) or exponential. When using exponential the function uses numeric methods rather than an analytical solution.

compute_cens_parameter = function(w_shape,w_scale, prop = 0.8, cens_var = 'weibull')
{
res = NA
if(w_shape !=1 & cens_var=='exponential')
{
 prob_of_observing_an_event = function(lambda)
 {
  integrate(function(x) dweibull(x, w_shape,w_scale) * pexp(x,lambda,lower.tail = FALSE), lower =0, upper = Inf)$value
 }

res = 1/uniroot(\(x) prob_of_observing_an_event(x) - prop, interval = c(0, 10*w_scale))$root
}
else if(cens_var=='weibull')
{
 res = (w_scale^w_shape * prop/(1-prop))^(1/w_shape)
}
return(res)
}
