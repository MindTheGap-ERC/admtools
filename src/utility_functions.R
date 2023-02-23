#### age to time transformation ####
age_to_time = function(age) {
  time = -age
  return(time)
}

#### depth to height transformation ####
depth_to_height = function(depth) {
  height = - depth
  return(height)
}

#### paralell sorting of vectors ####

parallel_sorting = function(x, y) {
  # sorts the elements of x (strictly) increasing & permutes the values of y in
  # parallel
  # if x & y have same no of elements, they are sorted
  # else it checks if x is strictly increasing/ decreasing, and 
  # adjusts y accordingly
  
  # duplicate elements in x -> error
  if (any(duplicated(x))) {
    stop("Error: Duplicated tie points")
  }
  # if x sorted increasingly -> return as is
  if (!is.unsorted(x)) {
    return(list(x = x,
                y = y))
  }
  # if x sorted increasingly -> reverse order & return
  if (!is.unsorted(rev(x))) {
    return(list(x = rev(x),
                y = rev(y)))
  }
  # if x is unsorted, sort it & permute y accordingly
  if (is.unsorted(x) && (length(x) == length(y))) {
    sorted_list = sort(x, 
                     index.return = TRUE, 
                     decreasing = FALSE)
    x = sorted_list$x
    y = y[sorted_list$ix]
    return(list(x = x, 
                y = y))
  }
  # if x is unsorted & has different no of elements than y -> error
  stop("Could not order input values")
}



#### Sed rate in l domain to condensation ####
sed_rate_to_condensation = function(sed_rate) {
  if (any(sed_rate <= 0)) {
    stop("sedimentation rate in stratigraphic domain must be > 0")
  }
  condensation = sed_rate^(-1)
  return(condensation)
}

#### accumulate_increments ####
# integration procedure
accumulate_increments = function(x,
                                 y,
                                 mode) { #"pc","pl"
  
  if (mode == "pc") { # integrate over piece wise constant function
    acc_incr = cumsum(c(0, diff(x) * y))
  }
  
  if (mode == "pl") { # integrate over pairwise linear function
    # via trapezoidal rule
    increments =0.5 * (tail(y,-1) + head(y,-1)) * diff(x)
    acc_incr = cumsum(c(0,increments))
  }
  
  return(acc_incr)
}
