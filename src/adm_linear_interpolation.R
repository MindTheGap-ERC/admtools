source("src/utility_functions.R")

#### constructor: tie_points_to_adm ####
tie_points_to_adm <- function(t_dim_in, # input in time domain, either time or age
                              l_dim_in, # input in space domain, either depth or height
                              lmode, # "depth" of "height"
                              tmode) { # "time" or "age"
  # turn tie points in depth/height and time/age into adm
  if (tmode == "time") {
    time <- t_dim_in
  }
  if (tmode == "age") {
    time <- age_to_time(age = t_dim_in)
  }

  if (lmode == "height") {
    height <- l_dim_in
  }
  if (lmode == "depth") {
    height <- depth_to_height(depth = l_dim_in)
  }
  out <- parallel_sorting(
    x = time,
    y = height
  )

  time <- out$x
  height <- out$y

  adm <- list(
    tpoints = time,
    lpoints = height,
    interpol_mode = "piecewise_linear",
    lmode = lmode,
    tmode = tmode,
    interpol_data = NULL
  )

  return(adm)
}

#### constructor: pc_sed_to_adm_time_domain ####

pc_sed_to_adm_time_domain <- function(t_dim_in, # tie points in time domain
                                      sed_rate, # sed rate
                                      tmode) { # "time" or "age"
  # turns piecewise constant sed rate in time domain into adm

  if (tmode == "age") {
    time <- age_to_time(age = t_dim_in)
  }
  if (tmode == "time") {
    time <- t_dim_in
  }

  out <- parallel_sorting(
    x = time,
    y = sed_rate
  )

  time <- out$x
  sed_rate <- out$y

  acc_incr <- accumulate_increments(
    x = time,
    y = sed_rate,
    mode = "pc"
  )

  adm <- list(
    tpoints = time,
    lpoints = acc_incr,
    interpol_mode = "piecewise_linear",
    lmode = "height",
    tmode = tmode,
    interpol_data = NULL
  )

  return(adm)
}

#### constructor: pc_sed_to_adm_depth_domain ####

pc_sed_to_adm_depth_domain <- function(l_dim_in, # tie points in depth domain
                                       sed_rate, # sed rate
                                       lmode) { # "time" or "age"
  # turn piecewise constant sed rate in strat domain into adm

  if (lmode == "depth") {
    height <- depth_to_height(depth = l_dim_in)
  }
  if (lmode == "height") {
    height <- l_dim_in
  }

  condensation <- sed_rate_to_condensation(sed_rate)

  out <- parallel_sorting(
    x = height,
    y = condensation
  )

  height <- out$x
  condensation <- out$y

  acc_time <- accumulate_increments(
    x = height,
    y = condensation,
    mode = "pc"
  )

  adm <- list(
    tpoints = acc_time,
    lpoints = heightr,
    interpol_mode = "piecewise_linear",
    lmode = lmode,
    tmode = "time",
    interpol_data = NULL
  )

  return(adm)
}

#### constructor: pc_cond_to_adm ####

pc_cond_to_adm <- function(l_dim_in, # length dimension
                           cond, # condensation
                           lmode) { # "depth" or "height"
  # tunr piecewise ocnstant condensation into adm
  if (lmode == "depth") {
    height <- depth_to_height(depth = l_dim_in)
  }
  if (lmode == "height") {
    height <- l_dim_in
  }
  out <- parallel_sorting(
    x = height,
    y = cond
  )
  height <- out$x
  condensation <- out$y

  acc_time <- accumulate_increments(
    x = height,
    y = condensation,
    mode = "pc"
  )
  adm <- list(
    tpoints = acc_time,
    lpoints = height,
    interpol_mode = "piecewise_linear",
    lmode = lmode,
    tmode = "time",
    interpol_data = NULL
  )
  return(adm)
}
