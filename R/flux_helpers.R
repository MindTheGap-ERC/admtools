flux_const = function(){
  #' @export
  #' 
  #' @title constant deterministic tracer flux
  #' 
  #' @description
    #' For usage with _strat_cont_to_multiadm_; defines constant tracer flux in the time domain
  #' @returns a function factory that takes no arguments
  #' 
  #' @examples
  #' \dontrun{
  #' # see this vignette for an example
  #' vignette("adm_from_trace_cont")
  #' }
  #' 
  #' @seealso [flux_linear()], [flux_quad()], [strat_cont_gen_from_tracer()]
  f = function() {stats::approxfun(x = c(0,1),
                                    y = c(1,1),
                                    rule = 2)}
  return(f)
}

flux_linear = function(x0 = 0, y0 = 1, x1 = 1, y1 = 2){
  #' @export
  #' 
  #' @title linear deterministic tracer flux
  #' 
  #' @description
    #' For usage with _strat_cont_to_multiadm_ : defines linear tracer flux in the time domain
    #' Tracer flux is the linear function passing through the points (x0, y0) and (x1, y1)
  #' @param x0 numeric, abscissa
  #' @param y0 numeric, ordinate
  #' @param x1 numeric, abscissa
  #' @param y1 numeric, ordinate
  #' 
  #' @returns a function factory that takes no arguments. Upon each evaluation, it returns a linear function passing through the points (x0, y0) and (x1, y1)
  #' 
  #' @seealso [flux_const()], [flux_quad()], [strat_cont_gen_from_tracer()]
   f = function(x){
     m = (y1 - y0)/(x1 - x0)
     return( m  * (x - x0) + y0 )
   }
   return( function() return(f))
}

flux_quad = function(a = 1, b = 1, c = 1){
  #' @export
  #' 
  #' @title quadratic deterministic tracer flux
  #' 
  #' @description
    #' For usage with _strat_cont_to_multiadm_ : defines quadratic tracer flux in the time domain
    #' defined by the function f(x) = ax^2 + bx + c
  #' @param a numeric
  #' @param b numeric
  #' @param c numeric
  #' 
  #' @seealso [flux_linear()], [flux_const()], [strat_cont_gen_from_tracer()]
  #' 
  #' @returns a function factory that takes no arguments. Upon each evaluation, it returns the quadratic function f(x) = ax^2 + bx + c
  
  f = function(x){
    return(a*x^2 + b*x +c)
  }
  return(function() return(f))
}
