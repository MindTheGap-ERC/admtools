strat_cont_gen_from_tracer = function(bin_borders, df, distribution = "normal", cap = TRUE, cap_val = 0){
  #' @export
  #' 
  #' @title proxy values in strat domain
  #' 
  #' @description
    #' Generates a function factory for usage with _strat_cont_to_multiadm_ based on empirical tracer measurements in the section
    #' 
  #' 
  #' @param bin_borders borders of sampling bins
  #' @param df data frame with proxy records
  #' @param distribution character, currently only "normal" implemented. Specifies the distribution of proxies
  #' @param cap logical. Should values below `cap_val`be replaced?
  #' @param cap_val numeric. If `cap = TRUE`, values below `cap_val`will be replaced by `cap_val`
  #' 
  #' @returns a functional for usage with strat_cont_to_multiadm
  #' 
  #' @seealso [flux_const()], [flux_linear()], [flux_quad()] to define tracer fluxes
  #' 
  #' @examples
  #' \dontrun{
  #' # see this vignette for a use case
  #' vignette("adm_from_trace_cont")
  #' }
  
  if (distribution != "normal"){
    stop("Distribution type not implemented. Use one of the currently available options: \"normal\".")
  }
  if (distribution == "normal" & (! all(c("sd", "mean") %in% names(df)))){
    stop("COuld not find columns specifying standard deviation and mean: expected column names \"sd\" and \"mean\" in df.")
  }
  if ( (length(bin_borders) - 1) != length(df[,"sd"])){
    stop("Number of observations does not match number of sampling bins. Need length(bin_borders) - 1 to match number of rows in df.")
  }
  
  mean = df[ , "mean"]
  sd = df[ , "sd"]
  
  strat_cont_gen = function(){
    proxy_vals = stats::rnorm( n = length(mean),
                               mean = mean,
                               sd = sd)
    if (cap){
      proxy_vals = pmax(proxy_vals, cap_val)
    }
    strat_cont = stats::approxfun(x = bin_borders,
                                   y = c(proxy_vals, proxy_vals[length(proxy_vals)]),
                                   method = "constant",
                                   rule = 2,
                                   f = 0)
    return(strat_cont)
  }
  return(strat_cont_gen)
}

