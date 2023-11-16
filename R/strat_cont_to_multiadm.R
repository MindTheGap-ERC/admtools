strat_cont_to_multiadm = function(h_tp, t_tp, strat_cont_gen, time_cont_gen, h, no_of_rep = 100){
  
  #'
  #' @title estimate age-depth model from stratigraphic contents
  #' 
  #' @param h_tp function generating height tie poitns
  #' @param t_tp function generating time tie points
  #' @param strat_cont_gen function, generating stratigraphic contents
  #' @param time_cont_gen function, generating the hypothesis on content input in time
  #' @param h heights where the adm is evaluated
  #' @param no_of_rep integer, number of repetititons
  #' 
  #' @returns a multiadm object
  #' 
  
  # initialize storage
  h_list = vector(mode = "list", length = no_of_rep)
  t_list = vector(mode = "list", length = no_of_rep)
  destr_list = vector(mode = "list", length = no_of_rep)
  
  for (i in seq_len(no_of_rep)){
    #generate samples from tie points
    h_tp_sample  = h_tp()
    t_tp_sample = t_tp()
    
    t1_sample = t_tp_sample["t1"]
    t2_sample = t_tp_sample["t2"]
    
    h1_sample = h_tp_sample["h1"]
    h2_sample = h_tp_sample["h2"]
    
    # determine relevant heights
    h_relevant = c(h1_sample, h[h> h1_sample & h < h2_sample], h2_sample)
    
    # sample stratigraphic & time contents
    strat_cont_sample = strat_cont_gen()
    time_cont_sample = time_cont_gen()
    
    # correct for differnece in time & strat domain
    strat_cont_total = stats::integrate(f = strat_cont_sample,
                                        lower = h1_sample,
                                        upper = h2_sample)$value
    
    time_cont_total = stats::integrate(f = time_cont_sample,
                                       lower = t1_sample,
                                       upper = t2_sample)$value
    
    corr_factor = strat_cont_total / time_cont_total
    
    time_cont_sample_corr = function(x) time_cont_sample(x) * corr_factor
    
    integrated_time_cont = function(t) stats::integrate(f = time_cont_sample_corr,
                                                        lower = t1_sample,
                                                        upper = t)$val
    ## Basic checks
    # integrated_time_cont(t1_sample) == 0
    # (integrated_time_cont(t2_sample) - strat_cont_total) < 10^-8o
    
    t_out = rep(NA, length(h_relevant))
    
    for (j in seq_along(h_relevant)){
      strat_cont_at_hi = stats::integrate(f = strat_cont_sample,
                                          lower = h1_sample,
                                          upper = h_relevant[j])$val
      
      f = function(t) integrated_time_cont(t) - strat_cont_at_hi
      t_out[j] = t1_sample + stats::uniroot(f = f, 
                                interval = c(t1_sample, t2_sample), 
                                extendInt = "yes")$root
    }
    
    h_list[[i]] = h_relevant
    t_list[[i]] = t_out
    destr_list[[i]] = rep(FALSE, length(h))
    
  }
  
  multiadm = list(t = t_list,
                  h = h_list,
                  destr = destr_list,
                  T_unit = NA,
                  L_unit = NA)
  class(multiadm) = "multiadm"
  return(multiadm)
}