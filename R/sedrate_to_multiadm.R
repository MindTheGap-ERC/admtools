sedrate_to_multiadm = function(h_tp, t_tp, sed_rate_gen, h, no_of_rep = 100L, subdivisions = 100L,
                               stop.on.error = TRUE,
                               T_unit = NULL, L_unit = NULL){
  
  #' 
  #' @export
  #' 
  #' @title Estimate age-depth model from sedimentation rate & tie points
  #' 
  #' @param h_tp : function, returns stratigraphic positions of tie points
  #' @param t_tp : function, returns times of deposition of tie points
  #' @param sed_rate_gen : function, returns sedimentation rate functions
  #' @param h : numeric, heights where the adm is calculated
  #' @param no_of_rep : numeric, number of repetitions
  #' @param subdivisions maximum no of subintervals used in numeric integration. passed to _integrate_, see ?stats::integrate for details
  #' @param stop.on.error logical passed to _integrate_, see ?stats::integrate for details
  #' @param T_unit time unit
  #' @param L_unit length unit
  #' 
  #' @returns object of class multiadm
  #' 
  #' @examples
    #' \dontrun{
    #' # see this vignette for an example
    #' vignette("adm_from_sedrate")
    #' }
  #' 
  
  t_rel = unname(t_tp())
  h_rel = unname(h_tp())
  
  if(is.unsorted(h_rel, strictly = TRUE)){
    stop("Expected strictly increasing stratigraphic positions of tie points")
  }
  if(is.unsorted(t_rel, strictly = TRUE)){
    stop("Expected strictly increasing times of tie points")
  }
  if(length(t_rel) != length(h_rel)){
    stop("Uneven number of tie points in time and height")
  }
  
  
  h_list = list()
  t_list = list()
  destr_list = list()
  

  
  madm_list = list()
  
  for ( i in seq_len(no_of_rep)){
    sed_rate_sample = sed_rate_gen()
    t_sample = t_tp()
    h_sample = h_tp()
    
    h_temp = c()
    t_temp = c()
    for (int_no in seq_along(diff(h_rel))){
      h_lower = h_sample[int_no]
      h_upper = h_sample[int_no + 1]
      t_lower = t_sample[int_no]
      t_upper = t_sample[int_no + 1]
      tp_corr_sed_rate_sample = get_tp_corr_sed_rate(sed_rate = sed_rate_sample,
                                                     t_lower = t_lower,
                                                     t_upper = t_upper,
                                                     h_lower = h_lower,
                                                     h_upper = h_upper,
                                                     subdivisions = subdivisions,
                                                     stop.on.error = stop.on.error)
      
      h_relevant = unname(c(h_lower, h[h> h_lower & h < h_upper], h_upper))
      
      t_out = rep(NA, length(h_relevant))
      
      for (j in seq_along(h_relevant)){
        t_out[j] = t_lower + stats::integrate( function(x) 1/tp_corr_sed_rate_sample(x),
                                                 lower =  h_lower,
                                                 upper = h_relevant[j],
                                                 subdivisions = subdivisions, 
                                                 stop.on.error = stop.on.error)$value
      }
      h_temp = unique(c(h_temp, h_relevant))
      t_temp = unique(c(t_temp, t_out))
      
      
    }
    h_list[[i]] = h
    t_list[[i]] = t_out
    destr_list[[i]] = rep(FALSE, length(h))
    
  }
  
  multiadm = list(t = t_list,
                    h = h_list,
                    destr = destr_list,
                    T_unit = T_unit,
                    L_unit = L_unit,
                    no_of_entries = length(t_list))
    class(multiadm) = "multiadm"
    return(multiadm)

    
}

get_tp_corr_sed_rate = function(sed_rate, h_lower, h_upper, t_lower, t_upper, subdivisions, stop.on.error){
  
  #' 
  #' @keywords internal
  #' @noRd
  #' 
  #' @title tie point corrected sed rate
  #' 
  #' @param sed_rate function, sed rate
  #' @param h_lower lower strat limit   
  #' @param h_upper  higher strat limit
  #' @param t_lower time of early tie point
  #' @param t_upper time of later tie point
  #' @param subdivision maximum no of subintervals used in numeric integration. passed to _integrate_, see ?stats::integrate for details
  #' @param stop.on.error logical passed to _integrate_, see ?stats::integrate for details
  #' 
  #' @returns function, the tie point corrected sedimentation rate
  #' 
  
  time_cont = stats::integrate(function(x) 1/sed_rate(x),
                               lower = h_lower, 
                               upper = h_upper, 
                               subdivisions = subdivisions, 
                               stop.on.error = stop.on.error)$value
  c_corr = (t_upper - t_lower)/time_cont
  tp_corr_sed_rate_sample = function(x) sed_rate(x) / c_corr
  
  return( tp_corr_sed_rate_sample )
  
}

