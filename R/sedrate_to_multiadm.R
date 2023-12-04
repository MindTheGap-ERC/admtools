sedrate_to_multiadm = function(h_tp, t_tp, sed_rate_gen, h, no_of_rep = 100){
  
  #' 
  #' @title Estimate age-depth model from sedimentation rate & tie points
  #' 
  #' @param h_tp : function, returns stratigraphic positions of tie points
  #' @param t_tp : function, returns times of deposition of tie points
  #' @param sed_rate_gen : function, returns sedimentation rate functions
  #' @param h : numeric, heights where the adm is calculated
  #' @param no_of_rep : numeric, number of repetitions
  #' 
  #' @returns object of class multiadm
  #' 
  #' @examples
    #' \dontrun{
    #' # see this vignette for an example
    #' vignette("adm_from_sedrate")
    #' }
  #' 
  #' @export
  
  h_list = list()
  t_list = list()
  destr_list = list()
  
  for (i in seq_len(no_of_rep)){
    #generate samples from tie points
    h_tp_sample  = h_tp()
    t_tp_sample = t_tp()
    
    t1_sample = t_tp_sample["t1"]
    t2_sample = t_tp_sample["t2"]
    
    h1_sample = h_tp_sample["h1"]
    h2_sample = h_tp_sample["h2"]
    
    # relevant heights
    h_relevant = c(h1_sample, h[h> h1_sample & h < h2_sample], h2_sample)
    
    sed_rate_sample = sed_rate_gen()
    c_corr = (t2_sample-t1_sample)/stats::integrate(function(x) 1/sed_rate_sample(x), lower = h1_sample, upper = h2_sample)$value
    tp_corr_sed_rate_sample = function(x) sed_rate_sample(x) / c_corr
    
    t_out = rep(NA, length(h))
    
    for (j in seq_along(h)){
      t_out[j] = t1_sample + stats::integrate( function(x) 1/tp_corr_sed_rate_sample(x), lower =  h1_sample, upper = h[j])$value
    }
    
    h_list[[i]] = h
    t_list[[i]] = t_out
    destr_list[[i]] = rep(FALSE, length(h))
    
  }
    
    multiadm = list(t = t_list,
                    h = h_list,
                    destr = destr_list,
                    T_unit = NA,
                    L_unit = NA,
                    no_of_entries = length(t_list))
    class(multiadm) = "multiadm"
    return(multiadm)

    
}