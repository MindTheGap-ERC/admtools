rej_sampling = function(x,y, n = 1){
  #' @noRd
  #' @keywords internal
  #' 
  #' @title rejection sampling
  #' 
  #' @param x numeirc vector, strictly increasing.
  #' @param y numeric vector, positive
  #' @param n interger, number of samples generated
  #' 
  #' @description
    #' draws samples from a pdf given by approxfun(x,y)
    #'  
  #' @returns numeric vector of length n
  
  f = stats::approxfun(x,y)
  f_max = max(y)
  out = c()
  while (length(out) < n){
    x_draw = stats::runif(1, min = min(x), max = max(x))
    y_draw = stats::runif(1, min = 0, max = f_max)
    if (y_draw < f(x_draw)){
      out = c(out, x_draw)
    }
  }
  return(out)
}

crppp = function(x_min, x_max, rate = 1){
  #' @noRd
  #' @keywords internal
  #' 
  #' @title Poisson point process
  #' 
  #' @description
    #' generates points of Poisson point process in the interval x_min, x_max
  #'
  #' @param x_min lower limit
  #' @param x_max upper limit
  #' @param rate  numeric, rate of PPP
  #' 
  #' @returns numeric vector of variable length
  #' 
  n = stats::rpois(1, (x_max - x_min)* rate)
  points = stats::runif(n, min = x_min, max = x_max)
  return(points)
}

sed_rate_from_matrix = function(height, sedrate, matrix, mode = "deterministic", rate = 1, expand_domain = TRUE, transform = identity){
  #' @export
  #' @title make sed rate gen from matrix
  #' 
  #' @param height vector of heights
  #' @param sedrate vector of sed. rates x values
  #' @param matrix matrix of sed rate y values. Must have as many columns as length(height) and as many rows as length(sedrate).
  #' @param mode character, "deterministic" or "poisson". Determines at which stratigraphic heights the sed rate is determined. If "deterministic" this will be the heights in `height`, if "poisson" the heights where the sed rate is determined follows a poisson point process with rate specified by `rate`
  #' @param rate numeric, rate of the Poisson point process determining frequency of sedimentation rate changes.
  #' @param expand_domain should sedimentation rates be defined below/above the highest/lowest height in the section? If TRUE, the sed rate values are the values at the closest interpolated point, if FALSE it will be NA
  #' @param transform a function, the identity function by default. How should the values of the (pseudo)pdf defined by the entries of `matrix` be transformed? Using this function allows to (nonlinearly) rescale the values in matrix to put more emphasis on higher/lower values
  #' 
  #' @returns a function factory for usage with `sedrate_to_multiadm`
  #' 
  #' @seealso [sedrate_to_multiadm()] for estimating sedimentation rates based on the outputs, [get_data_from_eTimeOpt()] for extracting data from the `eTimeOpt` function of the astrochron package.
  #' * [sed_rate_gen_gamma()] for sed. rate generator based on a gamma distribution
  #' 
  #' @description
    #' Construct a sedimentation rate generator (function factory) from a matrix, e.g. one returned from `get_data_from_eTimeOpt`. This generator can be passed on to `sedrate_to_multiadm` to estimate age-depth models from it. 
    #' If mode is "deterministic", the generator evaluates the sedimentation rates at heights specified by `height`, if the mode is "poisson" it is evaluated at heights that are determined based on a poisson point process. At these heights, the value of the sedimentation rate is determined based on the (pseudo) pdf that is determined by the matrix values.
  if (!all(dim(matrix) == c(length(sedrate), length(height)))){
    stop("dimension mismatch. \"matrix\" must have length(height) columns and length(sedrate) rows")
  }
  
  rule = 1
  if (expand_domain == TRUE){
    rule = 2
  }
  if (mode == "poisson"){
    f = function(){
      x_max = max(height)
      x_min = min(height)
      interp_points = sort(c(x_min, x_max, crppp(x_min, x_max, rate)))
      interp_heights = rep(NA, length(interp_points))
      interp_vals = rep(NA, length(interp_points))
      se = rep(NA, length(interp_points))
      for (i in seq_along(interp_points)){
        low_int = height[height <= interp_points[i]]   #heights below poi
        high_int = height[height >= interp_points[i]]  # heights above poi
        h_low = max(low_int)  # highest point below poi
        h_high = min(high_int) # lowest point above poi
        low_ind = which(height ==h_low)
        high_ind = which(height == h_high)
        if (h_high == h_low){
          lam = 0
        } else {
          lam = (interp_points[i] - h_low)/(h_high - h_low) #relative position of the poi between h_low and h_high
        }
        ppdf = lam * matrix[, low_ind] + (1-lam)* matrix[, high_ind]
        sed_rate_vals = transform(ppdf)
        sed_rate_val = rej_sampling(sedrate, sed_rate_vals)
        se[i] = sed_rate_val
        
      }
      return(stats::approxfun(x = interp_points, y = se, ties = function(x) sample(x, 1), rule = rule)) # for ties, randomly select one sample
    }
    return(f)
  }
  if (mode == "deterministic"){
    f = function(){
      interp_points = sort(height)
      se = rep(NA, length(interp_points))
      for (i in seq_along(interp_points)){
        sed_rate_vals = transform(matrix[, i])
        se[i] = rej_sampling(sedrate, sed_rate_vals)
      }
      return(stats::approxfun(x = interp_points, y = se, rule = rule))
    }
    return(f)
  }
  stop("unknown mode, use either \"poisson\" or \"deterministic\"")

}

sed_rate_gen_from_bounds = function(h_l, s_l, h_u, s_u, rate = 1){
  
  #' @export
  #' 
  #' @title seg rate gen from upper/lower bounds
  #' 
  #' @param h_l height values for lower bounds
  #' @param s_l sed rate values for lower bounds
  #' @param h_u height values for upper bounds
  #' @param s_u sed rate values for upper bounds
  #' @param rate rate of poisson point process
  #' 
  #' @returns a function factory for usage with `sedrate_to_multiadm`
  #' 
  #' @seealso 
  #' * [sedrate_to_multiadm()] for estimating age-depth models using the outputs
  #' * [sed_rate_from_matrix()] for other means of defining sedimentation rates
  #' * [sed_rate_gen_gamma()] for sed. rate generator based on a gamma distribution
  f = function(){
    h_min = min(c(min(h_u), min(h_l)))
    h_max = max(c(max(h_u), max(h_l)))
    h = sort(unique(c(h_min, h_max, crppp(h_min, h_max, rate))))
    s_min = stats::approx(h_l, s_l, xout = h, f = 2)$y
    s_max = stats::approx(h_u, s_u, xout = h, f = 2)$y
    sval = stats::runif(length(h), s_min, s_max)
    return(stats::approxfun(h, sval, f=2))
  }
  return(f)
}

sed_rate_gen_gamma = function(h, shapes, rates, rule = 1){
  #' @export
  #' 
  #' @title sed. rate gen based on gamma distribution
  #' 
  #' @param h heights at which sedimentation rate is determined
  #' @param shapes shape parameters for the gamma distribution
  #' @param rates rate parameter for the gamma distribution
  #' @param rule an integer of length 1 or 2, see description for details
  #' 
  #' @returns a function factory for usage with `sedrate_to_multiadm`
  #' 
  #' @description
    #' generates a function factory for usage with `sedrate_to_multiadm`. At `h[i]`,
    #' the sedimentation rate is given by a gamma distribution with parameters
    #' `shapes[i]` and `rates[i]`. Between those values, sedimentation rate is linearly interpolated
    #' Outside of the range of `h`, behaviour is determined by the argument `rule`
    #' which is passed to `approxfun`. See there for details.
    #' 
  #' 
  #' @seealso 
  #' * [sedrate_to_multiadm()] for estimating age-depth models using the outputs
  #' * [sed_rate_from_matrix()] for other means of defining sedimentation rates
  #' * [sed_rate_gen_from_bounds()] for sed. rate generator based on bounds on sedimentation rates.
  # check inputs
  if (length(h) != length(shapes)){
    stop("Length of `h` must be identical to number of parameters (`shapes`, `rates`)")
  }
  if (length(shapes) != length(rates)){
    stop("Length of parameter vectors `shapes` and `rates` must be identical")
  }
  
  f = function(){
    y = sapply(seq_along(h), function(x) stats::rgamma(n = 1, shape = shapes[x], rate = rates[x]))
    return(stats::approxfun(h, y, f = 2, rule = rule))
  }
  return(f)
}
