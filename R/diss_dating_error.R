diss_dating_error = function(x, y, t = NULL, t_range = NULL){
  #' @export
  #'
  #' @title dating error between two age-depth models
  #'
  #' @description
    #' Determines the average error that occurs when events are placed in the section according to one age-depth model, and then dated using another age-depth model. Returns the mean absolute dating error, the root mean square (RMS) of the dating error along with its decomposition into mean error and variance, and the time interval over which the error is averaged.
    #'
  #' @param x an `adm` object, used to place events in the section (the "true" age-depth model)
  #' @param y an `adm` object of the same section, used to date the events. Must have identical time and length units as `x`
  #' @param t `NULL` or numeric vector of times. If `NULL`, the error is averaged over the interval `t_range`. Otherwise, it is averaged over the times in `t`.
  #' @param t_range `NULL` or numeric vector of length two. Time interval over which the error is averaged. If `NULL`, all times at which `x` places events within the stratigraphic range of `y` are used. Ignored if `t` is provided.
  #'
  #' @details
    #' An event at time \eqn{t} is placed at stratigraphic position \eqn{h_x(t)} by `x` (see [time_to_strat()]) and dated by `y` (see [strat_to_time()]). Where `y` accumulates sediment, it assigns a unique time \eqn{t_y(h)}. At a hiatus surface of `y` with gap \eqn{[g^-, g^+]}, every time in the gap is consistent with `y`, so `y` assigns the set \eqn{T_y(h) = [g^-, g^+]}. The dating error is the signed distance of the true time to the assigned set,
    #' \deqn{e(t) = t - \pi_{T_y(h_x(t))}(t),}
    #' where \eqn{\pi_{[g^-, g^+]}(t) = \min(\max(t, g^-), g^+)} is the time in the gap closest to \eqn{t}. Where `y` assigns a unique time, this is \eqn{e(t) = t - t_y(h_x(t))}. Positive values indicate that `y` assigns earlier times than the true time of the event.
    #'
    #' Hiatuses in `x` are not destructive: Events that occur during a hiatus of `x` are preserved at the stratigraphic position of the hiatus. If `y` assigns a unique time to this position, the dating error grows linearly during the hiatus of `x`. If `x` and `y` share a hiatus surface with gaps \eqn{G_x} and \eqn{G_y}, the error is zero for events in \eqn{G_x \cap G_y} and grows linearly outside of the intersection.
    #'
    #' Using the set of times assigned by `y` makes the dating error independent of conventions for the inverse of `y` at hiatuses (e.g. right-continuous with left limits or left-continuous with right limits, see `hiat_mode` in [get_time()]). Any such convention dates all events at a shared hiatus surface to the same time, biasing their errors. The set-valued error is the error under the best choice of time from the gap of `y` for each individual event, and only depends on the two age-depth models.
    #'
    #' If `t` is `NULL`, events are sampled uniformly in time over the effective time interval, which consists of all times in `t_range` at which `x` places events within the stratigraphic range of `y`. The returned measures are
    #' * `mae`, the mean absolute error \eqn{\mathrm{mean}(|e|)}. This is the expected dating error of an event that occurs at a uniformly distributed time in the effective time interval, and is the most intuitive measure of dating precision.
    #' * `msd`, the mean square error, with decomposition \eqn{\mathrm{msd} = \mathrm{mean}(e^2) = \mu^2 + \sigma^2}, where \eqn{\mu} is the mean error (systematic bias) and \eqn{\sigma^2} is the variance of the error. The RMS is the square root of the msd. It is at least as large as `mae`, and weights large errors more heavily.
    #'
    #' The dating error equals the age offset \eqn{d(h) = t_x(h) - t_y(h)} used in [diss_age_offset()], evaluated at \eqn{h = h_x(t)}. The two functions differ in their weighting: `diss_age_offset` weights all stratigraphic positions equally, whereas `diss_dating_error` weights all times equally, i.e. stratigraphic positions by the condensation of `x`, including the time contained in hiatuses of `x`. For age-depth models `x` with constant sedimentation rate and no hiatuses, both coincide.
    #'
    #' If `t` is `NULL`, all averages are computed exactly: Between consecutive tie point heights of `x` and `y`, both the time of deposition under `x` and the dating error are linear in stratigraphic position, and during hiatuses of `x` the dating error is piecewise linear in time. All integrals, including the one of the absolute error, are evaluated analytically. Hiatuses in `y` (jumps in the dated time) are handled exactly.
    #'
    #' If `t` is provided, the averages are taken over the times in `t`. Times outside of the effective time interval are removed with a warning. The variance is the population variance (normalized by the number of times, not the number of times minus one), so the decomposition holds exactly.
    #'
  #' @returns an object of S3 class `diss_dating_error`, a list with elements
    #' * `mae`: mean absolute dating error
    #' * `rms`: root mean square dating error
    #' * `msd`: mean square error, in the squared time unit
    #' * `mu`: mean error
    #' * `variance`: variance of the error, in the squared time unit
    #' * `t_start`, `t_end`: start and end of the effective time interval. If `t` is provided, the range of the times used
    #' * `duration`: length of the effective time interval, `t_end - t_start`
    #' * `method`: "exact" if `t` is `NULL`, "discrete" otherwise
    #' * `n_times`: number of times used if `t` is provided, `NA` otherwise
    #' * `T_unit`, `L_unit`: time and length unit
    #'
  #' @seealso [diss_age_offset()] for the age offset weighted by stratigraphic position, [time_to_strat()] and [strat_to_time()] for the underlying transformations, [summary.diss_dating_error()] for a detailed summary
  #'
  #' @examples
    #' # x has a hiatus from 1 to 3 Myr at 1 m, y has a constant sedimentation rate
    #' x = tp_to_adm(t = c(0, 1, 3, 5), h = c(0, 1, 1, 2), T_unit = "Myr", L_unit = "m")
    #' y = tp_to_adm(t = c(0, 5), h = c(0, 2), T_unit = "Myr", L_unit = "m")
    #' res = diss_dating_error(x, y)
    #' res
    #' summary(res)
    #' # decomposition
    #' res$mu^2 + res$variance - res$msd
    #' # error for events within the hiatus of x
    #' diss_dating_error(x, y, t_range = c(1, 3))
    #' # shared hiatus surface: no error for events in the overlap of the gaps
    #' z = tp_to_adm(t = c(0, 2, 4, 5), h = c(0, 1, 1, 2), T_unit = "Myr", L_unit = "m")
    #' diss_dating_error(x, z, t_range = c(2, 3))
    #' # average over specific times
    #' diss_dating_error(x, y, t = c(0.5, 2, 4))
    #'

  stopifnot(is_adm(x), is_adm(y))
  if (!identical(get_L_unit(x), get_L_unit(y)) || !identical(get_T_unit(x), get_T_unit(y))){
    stop("age-depth models must have identical length and time units")
  }

  # times assigned by y at height h: the gap [g-, g+] at hiatus surfaces of y,
  # the unique time t_y(h) elsewhere (g- = g+)
  ty = function(h, side) get_time(y, h, hiat_mode = side, bdry_pts_hiat = "consistent")

  if (!is.null(t)){
    h = get_height(x, t, destructive = FALSE)
    e = t - pmin(pmax(t, ty(h, "start")), ty(h, "end")) # distance to closest assigned time
    if (anyNA(e)){
      warning("removing times outside of the age-depth models")
      t = t[!is.na(e)]
      e = e[!is.na(e)]
    }
    if (length(e) == 0){
      stop("no times left to compare")
    }
    mu = mean(e)
    variance = mean((e - mu)^2)
    msd = mean(e^2)
    return(new_diss_dating_error(mae = mean(abs(e)), msd = msd, mu = mu, variance = variance,
                                 t_start = min(t), t_end = max(t), duration = max(t) - min(t),
                                 method = "discrete", n_times = length(e),
                                 T_unit = get_T_unit(x), L_unit = get_L_unit(x)))
  }

  h_overlap = c(max(min(x$h), min(y$h)), min(max(x$h), max(y$h)))
  if (!(h_overlap[1] < h_overlap[2])){
    stop("age-depth models do not overlap")
  }
  if (is.null(t_range)){
    h_lim = h_overlap
    t_lim = c(-Inf, Inf)
  } else {
    if (!is.numeric(t_range) || length(t_range) != 2 || !(t_range[1] < t_range[2])){
      stop("t_range must be an interval of positive length")
    }
    if (t_range[1] < min(x$t) || t_range[2] > max(x$t)){
      stop("t_range must lie within the time range of x")
    }
    h_lim = get_height(x, t_range, destructive = FALSE)
    if (h_lim[1] < h_overlap[1] || h_lim[2] > h_overlap[2]){
      stop("t_range must map into the stratigraphic range of y")
    }
    t_lim = t_range
  }

  tx = function(h, side) get_time(x, h, hiat_mode = side, bdry_pts_hiat = "consistent")

  # Accumulating parts of x, parametrized by height: between consecutive tie
  # point heights of x and y, both the time of x and the dating error are
  # linear in height. Working with exact tie point heights avoids round trips
  # through time, which can misassign positions at hiatuses of y. One-sided
  # limits handle jumps at hiatuses exactly. Clamping to t_lim only affects
  # the outermost segments.
  kn = sort(unique(c(h_lim, x$h, y$h)))
  kn = kn[kn >= h_lim[1] & kn <= h_lim[2]]
  a = kn[-length(kn)]
  b = kn[-1]
  ta = pmax(tx(a, "end"), t_lim[1]) # right limit at segment start
  tb = pmin(tx(b, "start"), t_lim[2]) # left limit at segment end
  e0 = ta - ty(a, "end")
  e1 = tb - ty(b, "start")

  # Hiatuses of x: all events in the gap [ha, hb] are placed at the hiatus
  # height H, where y assigns the times [gm, gp] (a single time unless H is
  # also a hiatus surface of y). The error t - clamp(t, gm, gp) is linear on
  # each of the pieces before, within, and after [gm, gp]
  H = unique(x$h[-1][diff(x$h) == 0])
  H = H[H >= h_lim[1] & H <= h_lim[2]]
  if (length(H) > 0){
    ha = pmax(tx(H, "start"), t_lim[1])
    hb = pmin(tx(H, "end"), t_lim[2])
    gm = ty(H, "start")
    gp = ty(H, "end")
    before_end = pmin(hb, gm)
    within_start = pmax(ha, gm)
    within_end = pmin(hb, gp)
    after_start = pmax(ha, gp)
    ta = c(ta, ha, within_start, after_start)
    tb = c(tb, before_end, within_end, hb)
    e0 = c(e0, ha - gm, rep(0, length(H)), after_start - gp)
    e1 = c(e1, before_end - gm, rep(0, length(H)), hb - gp)
  }

  keep = tb > ta
  if (!any(keep)){
    stop("no time to compare in t_range")
  }
  ta = ta[keep]
  tb = tb[keep]
  e0 = e0[keep]
  e1 = e1[keep]
  w = tb - ta
  len = sum(w)

  mae = sum(w * mean_abs_linear(e0, e1)) / len
  mu = sum(w * (e0 + e1) / 2) / len
  msd = sum(w * (e0^2 + e0 * e1 + e1^2) / 3) / len
  variance = max(msd - mu^2, 0) # guard against round-off
  return(new_diss_dating_error(mae = mae, msd = msd, mu = mu, variance = variance,
                               t_start = min(ta), t_end = max(tb), duration = len,
                               method = "exact", n_times = NA_integer_,
                               T_unit = get_T_unit(x), L_unit = get_L_unit(x)))
}

new_diss_dating_error = function(mae, msd, mu, variance, t_start, t_end, duration,
                                 method, n_times, T_unit, L_unit){
  # constructor for S3 class diss_dating_error. Not exported.
  res = list(mae = mae,
             rms = sqrt(msd),
             msd = msd,
             mu = mu,
             variance = variance,
             t_start = t_start,
             t_end = t_end,
             duration = duration,
             method = method,
             n_times = n_times,
             T_unit = T_unit,
             L_unit = L_unit)
  class(res) = "diss_dating_error"
  return(res)
}

print.diss_dating_error = function(x, digits = getOption("digits") - 3, ...){
  #' @export
  #'
  #' @title print dating error
  #'
  #' @description
    #' Prints the dating errors stored in a `diss_dating_error` object
    #'
  #' @param x a `diss_dating_error` object, see [diss_dating_error()]
  #' @param digits number of significant digits
  #' @param ... ignored
  #'
  #' @returns `x`, invisibly
  #'
  #' @seealso [diss_dating_error()] to create the object, [summary.diss_dating_error()] for a detailed summary

  f = function(v) format(v, digits = digits)
  u = if (is.null(x$T_unit)) "" else paste0(" ", x$T_unit)
  cat("Dating error (events placed by x, dated by y)\n")
  cat("  mae: ", f(x$mae), u, " (expected absolute dating error)\n", sep = "")
  cat("  rms: ", f(x$rms), u, " (mu ", f(x$mu), ", sd ", f(sqrt(x$variance)), ")\n", sep = "")
  cat("  over t in [", f(x$t_start), ", ", f(x$t_end), "]", u, "\n", sep = "")
  invisible(x)
}

summary.diss_dating_error = function(object, ...){
  #' @export
  #'
  #' @title summary of dating error
  #'
  #' @description
    #' Summarizes a `diss_dating_error` object, listing all measures of the dating error with their units and the shares of bias and variance in the mean square error.
    #'
  #' @param object a `diss_dating_error` object, see [diss_dating_error()]
  #' @param ... ignored
  #'
  #' @returns an object of S3 class `summary.diss_dating_error`, a list with elements `table` (data frame with columns `value` and `unit` and rows `mae`, `rms`, `mu`, `sd`, `msd`, `variance`, `bias_share`, `variance_share`), `t_start`, `t_end`, `duration`, `method`, `n_times`, `T_unit`, and `L_unit`. `bias_share` (\eqn{\mu^2 / \mathrm{msd}}) and `variance_share` (\eqn{\sigma^2 / \mathrm{msd}}) add up to 1, and are `NA` if the mean square error is 0.
  #'
  #' @seealso [diss_dating_error()] to create the object

  u = if (is.null(object$T_unit)) "time unit" else object$T_unit
  share = function(part) if (object$msd > 0) part / object$msd else NA_real_
  table = data.frame(value = c(object$mae, object$rms, object$mu, sqrt(object$variance),
                               object$msd, object$variance,
                               share(object$mu^2), share(object$variance)),
                     unit = c(rep(u, 4), rep(paste0(u, "^2"), 2), "", ""),
                     row.names = c("mae", "rms", "mu", "sd", "msd", "variance",
                                   "bias_share", "variance_share"))
  res = c(list(table = table),
          object[c("t_start", "t_end", "duration", "method", "n_times", "T_unit", "L_unit")])
  class(res) = "summary.diss_dating_error"
  return(res)
}

print.summary.diss_dating_error = function(x, digits = getOption("digits") - 3, ...){
  #' @export
  #'
  #' @title print summary of dating error
  #'
  #' @param x a `summary.diss_dating_error` object, see [summary.diss_dating_error()]
  #' @param digits number of significant digits
  #' @param ... ignored
  #'
  #' @returns `x`, invisibly

  f = function(v) format(v, digits = digits)
  u = if (is.null(x$T_unit)) " time units" else paste0(" ", x$T_unit)
  cat("Dating error: events placed in the section by x, dated by y\n")
  if (x$method == "exact"){
    cat("Exact average over events sampled uniformly in time\n")
  } else {
    cat("Average over ", x$n_times, " provided times\n", sep = "")
  }
  cat("Time interval [", f(x$t_start), ", ", f(x$t_end), "], duration ", f(x$duration), u, "\n\n", sep = "")
  print(x$table, digits = digits)
  cat("\nmae: expected absolute dating error; msd = mu^2 + variance\n")
  invisible(x)
}
