sedrate_to_multiadm = function(h_tp, t_tp, sed_rate_gen, h, no_of_rep = 100L, subdivisions = 100L,
                               stop.on.error = TRUE,
                               T_unit = NULL, L_unit = NULL){
  
  #' 
  #' @export
  #' 
  #' @title Estimate age-depth model from sedimentation rate & tie points
  #' 
  #' @description
    #' Combines information on tie points and sedimentation rates to estimate age-depth models and their associated uncertainty. For an example, see `vignette("adm_from_sedrate")`.
    #' 
  #' 
  #' @param h_tp : function, returns stratigraphic positions of tie points
  #' @param t_tp : function, returns times of tie points
  #' @param sed_rate_gen : function, returns function describing sedimentation rate
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
  
  ## Check inputs
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
  
  ## Initialize storage
  h_list = vector(mode = "list", length = no_of_rep)
  t_list = vector(mode = "list", length = no_of_rep)
  destr_list = vector(mode = "list", length = no_of_rep)
  
  for ( i in seq_len(no_of_rep)){
    sed_rate_sample = sed_rate_gen() # draw sed rate
    t_sample = c(-Inf, t_tp(), Inf) # draw times, pad
    h_sample = c(-Inf, h_tp(), Inf) # draw heights, pad
    h_temp = c()
    t_temp = c()
    no_of_intervals = length(diff(h_sample))
    
    for (int_no in seq_len(no_of_intervals)){
      h_lower = h_sample[int_no]
      h_upper = h_sample[int_no + 1]
      t_lower = t_sample[int_no]
      t_upper = t_sample[int_no + 1]
      h_relevant = h[h> h_lower & h <= h_upper]
      if (length(h_relevant) == 0){ # if no h vals are in interval, move to next
        next
      }
      t_out = rep(NA, length(h_relevant))
      rescale = is.finite(h_upper - h_lower) # does sed rate need to be rescaled? 
      reverse_direction = is.infinite(h_lower) # reverse integration direction for first/last interval
      inv_tp_corr_sed_rate_sample = get_tp_corr_sed_rate(sed_rate = sed_rate_sample,
                                                     t_lower = t_lower,
                                                     t_upper = t_upper,
                                                     h_lower = h_lower,
                                                     h_upper = h_upper,
                                                     subdivisions = subdivisions,
                                                     stop.on.error = stop.on.error,
                                                     rescale = rescale)
      
      for (j in seq_along(h_relevant)){
        if (!reverse_direction){
          t_out[j] = t_lower + stats::integrate(f = inv_tp_corr_sed_rate_sample,
                                                lower =  h_lower,
                                                upper = h_relevant[j],
                                                subdivisions = subdivisions, 
                                                stop.on.error = stop.on.error)$value
        }
        if (reverse_direction){
          t_out[j] = t_upper - stats::integrate(f = inv_tp_corr_sed_rate_sample,
                                                lower =  h_relevant[j],
                                                upper = h_upper,
                                                subdivisions = subdivisions, 
                                                stop.on.error = stop.on.error)$value
        }

      }
      h_temp = c(h_temp, h_relevant)
      t_temp = c(t_temp, t_out)
      
      
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

get_tp_corr_sed_rate = function(sed_rate, h_lower, h_upper, t_lower, t_upper, subdivisions, stop.on.error, rescale){
  
  #' 
  #' @keywords internal
  #' @noRd
  #' 
  #' @title inverse tie point corrected sed rate
  #' 
  #' @param sed_rate function, sed rate
  #' @param h_lower lower strat limit   
  #' @param h_upper  higher strat limit
  #' @param t_lower time of early tie point
  #' @param t_upper time of later tie point
  #' @param subdivision maximum no of subintervals used in numeric integration. passed to _integrate_, see ?stats::integrate for details
  #' @param stop.on.error logical passed to _integrate_, see ?stats::integrate for details
  #' @param rescale logical, should the the function be rescaled?
  #' 
  #' @returns function, the inverse tie point corrected sedimentation rate
  #' 
  c_corr = 1
  if (rescale){
    time_cont = stats::integrate(function(x) 1/sed_rate(x),
                                 lower = h_lower, 
                                 upper = h_upper, 
                                 subdivisions = subdivisions, 
                                 stop.on.error = stop.on.error)$value
    c_corr = (t_upper - t_lower)/time_cont
  }

  inv_tp_corr_sed_rate_sample = function(x)  c_corr / sed_rate(x)
  
  return( inv_tp_corr_sed_rate_sample )
  
}

