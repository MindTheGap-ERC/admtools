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

sed_rate_from_matrix = function(height, sedrate, matrix, rate = 1){
  #' @noRd
  #' @keywords internal
  #' @title make sed rate gen from matrix
  #' 
  #' @param height vector of heights
  #' @param sedrate vector of sed. rates x values
  #' @param matrix matrix of sed rate y values
  #' 
  #' @description
    #' at height `height[i]`, the sedimentation rate is specified by the pdf approxfun(sedrate, matrix[i,])
    #' 
  
  # x_min = -2
  # x_max = 3
  # height = seq(x_min, x_max, by = 0.25)
  # sedrate = seq(0.1, 10, by = 0.1)
  # matrix = matrix(data = runif(n = length(height) * length(sedrate)), nrow = length(height), ncol = length(sedrate))
  f = function(){
  x_max = max(height)
  x_min = min(height)
  interp_points = sort(c(x_min, x_max, crppp(x_min, x_max, rate)))
  interp_heights = rep(NA, length(interp_points))
  interp_vals = rep(NA, length(interp_points))
  se = rep(NA, length(interp_points))
  for (i in seq_along(interp_points)){
    interp_index = which.min(abs(interp_points[i] - height))
    sed_rate_vals = matrix[interp_index,]
    sed_rate_val = rej_sampling(sedrate, sed_rate_vals)
    interp_heights[i] = height[interp_index]
    se[i] = sed_rate_val
    
  }
  return(stats::approxfun(interp_heights, se, ties = function(x) sample(x, 1))) # for ties, randomly select one sample
  }
  return(f)
}

sed_rate_gen_from_bounds = function(h_l, s_l, h_u, s_u, rate = 1){
  #' 
  #' @title seg rate gen from upper/lower bounds
  #' 
  #' @param h_l height values for lower bounds
  #' @param s_l sed rate values for lower bounds
  #' @param h_u height values for upper bounds
  #' @param s_u sed rate values for upper bounds
  #' @param rate rate parameter for Poisson point process
  #' 
  f = function(){
    h_min = min(c(min(h_u), min(h_l)))
    h_max = max(c(max(h_u), max(h_l)))
    h = sort(unique(c(h_min, h_max, crppp(h_min, h_max, rate))))
    s_min = stats::approx(h_l, s_l, xout = h)$y
    s_max = stats::approx(h_u, s_u, xout = h)$y
    sval = stats::runif(length(h), s_min, s_max)
    return(stats::approxfun(h, sval, f=2))
  }
  return(f)
}
