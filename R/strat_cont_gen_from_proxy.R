strat_cont_gen_from_proxy = function(bin_borders, df, distribution = "normal"){
  #' @export
  #' 
  #' @title proxy record fluxes
  #' 
  #' @param bin_borders borders of sampling bins
  #' @param df data frame with proxy records
  #' @param distribution character, currently only "normal" implemented. Specifies the distribution of proxies
  #' 
  #' @returns a functional for usage with strat_cont_to_multiadm
  #' 
  
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
    proxy_vals = rnorm( n = length(mean),
                     mean = mean,
                     sd = sd)
    strat_cont = approxfun(x = bin_borders,
                           y = c(proxy_vals, proxy_vals[length(proxy_vals)]),
                           method = "constant",
                           rule = 2,
                           f = 0)
    return(strat_cont)
  }
  return(strat_cont_gen)
}

