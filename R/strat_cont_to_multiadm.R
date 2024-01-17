strat_cont_to_multiadm = function(h_tp, t_tp, strat_cont_gen, time_cont_gen, h, no_of_rep = 100L, 
                                  subdivisions = 100L, stop.on.error = TRUE,
                                  T_unit = NULL, L_unit = NULL){
  
  #'
  #' @title estimate age-depth model from stratigraphic contents
  #' 
  #' @param h_tp function, returning tie point heights
  #' @param t_tp function, returning tie points times
  #' @param strat_cont_gen function, generating stratigraphic contents
  #' @param time_cont_gen function, generating the hypothesis on content input in time
  #' @param h numeric vector, heights where the adm is evaluated
  #' @param no_of_rep integer, number of repetitions
  #' @param subdivisions integer, max no. of subintervals used by integration procedure. passed to _integrate_, see ?stats::integrate for details
  #' @param stop.on.error logical passed to _integrate_, see ?stats::integrate for details
  #' @param T_unit time unit 
  #' @param L_unit length unit
  #' 
  #' @returns Object of class multiadm
  #' 
  #' @examples
    #' \dontrun{
    #' # see this vignette for an example
    #' vignette("adm_from_trace_cont")
    #' }
  #' 
  #' @export
  #' 
  
  t_rel = t_tp()
  h_rel = h_tp()
  
  if(is.unsorted(h_rel, strictly = TRUE)){
    stop("Expected strictly increasing stratigraphic positions of tie points")
  }
  if(is.unsorted(t_rel, strictly = TRUE)){
    stop("Expected strictly increasing times of tie points")
  }
  if(length(t_rel) != length(h_rel)){
    stop("Uneven number of tie points in time and height")
  }
  
  h_list = vector(mode = "list", length = no_of_rep)
  t_list = vector(mode = "list", length = no_of_rep)
  destr_list = vector(mode = "list", length = no_of_rep)
  
  for (i in seq_len(no_of_rep)){
    # sample stratigraphic & time contents, and tie points
    strat_cont_sample = strat_cont_gen()
    time_cont_sample = time_cont_gen()
    h_tp_sample  = h_tp()
    t_tp_sample = t_tp()
    no_of_intervals = length(diff(h_tp_sample))
    h_temp = c()
    t_temp = c()
    
    for (int_no in seq_len(no_of_intervals)){
      h_lower = h_tp_sample[int_no]
      h_upper = h_tp_sample[int_no + 1]
      t_lower = t_tp_sample[int_no]
      t_upper = t_tp_sample[int_no + 1]
      time_cont_sample_corr = get_corr_time_cont(strat_cont = strat_cont_sample,
                                                 time_cont = time_cont_sample, 
                                                 h_lower = h_lower,
                                                 h_upper = h_upper,
                                                 t_lower = t_lower, 
                                                 t_upper = t_upper,
                                                 subdivisions = subdivisions,
                                                 stop.on.error = stop.on.error)
      
      h_relevant = c(h_lower, h[h> h_lower & h < h_upper], h_upper)
      t_out = rep(NA, length(h_relevant))
      
      integrated_time_cont = function(t) stats::integrate(f = time_cont_sample_corr,
                                                          lower = t_lower,
                                                          upper = t,
                                                          subdivisions = subdivisions,
                                                          stop.on.error = stop.on.error)$val
      
      for (j in seq_along(h_relevant)){
        strat_cont_at_hi = stats::integrate(f = strat_cont_sample,
                                            lower = h_lower,
                                            upper = h_relevant[j],
                                            subdivisions = subdivisions,
                                            stop.on.error = stop.on.error)$val
        
        f = function(t) integrated_time_cont(t) - strat_cont_at_hi
        t_out[j] = t_lower + stats::uniroot(f = f, 
                                              interval = c(t_lower, t_upper), 
                                              extendInt = "yes")$root
      }
      h_temp = unique(c(h_temp, h_relevant))
      t_temp = unique(c(t_temp, t_out))
      
    }
    
    h_list[[i]] = h_temp
    t_list[[i]] = t_temp
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

get_corr_time_cont = function(strat_cont, time_cont, h_lower, h_upper, t_lower, t_upper, subdivisions, stop.on.error){
  #' @keywords internal
  #' @noRd
  #' 
  #' @title get corrected time content
  #' 
  #' @description
    #' normalizes proxy contents to match empirical observations
    #' 
  #' @param strat_cont function, proxy cont in strat domain
  #' @param time_cont function, proxy cont in time domain
  #' @param h_lower lower strat limit
  #' @param h_upper upper strat limit
  #' @param t_lower lower time limit
  #' @param t_upper upper time limit
  #' @param subdivisions maximum no of subintervals used in numeric integration. passed to _integrate_, see ?stats::integrate for details
  #' @param stop.on.error logical passed to _integrate_, see ?stats::integrate for details
  #' 
  #' @returns function, normalized proxy content in time domain
  
  strat_cont_total = stats::integrate(f = strat_cont,
                                      lower = h_lower,
                                      upper = h_upper,
                                      subdivisions = subdivisions,
                                      stop.on.error = stop.on.error)$value
  
  time_cont_total = stats::integrate(f = time_cont,
                                     lower = t_lower,
                                     upper = t_upper,
                                     subdivisions = subdivisions,
                                     stop.on.error = stop.on.error)$value
  
  corr_factor = strat_cont_total / time_cont_total
  time_cont_sample_corr = function(x) time_cont(x) * corr_factor
  
  return(time_cont_sample_corr)
  
}