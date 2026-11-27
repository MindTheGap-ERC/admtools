diss_age_offset = function(x, y, h = NULL, h_range = NULL){
  #' @export
  #'
  #' @title age offset between two age-depth models
  #'
  #' @description
    #' Determines the difference between the ages that two age-depth models assign to the same stratigraphic positions. Returns the mean absolute offset, the root mean square (RMS) of the offset along with its decomposition into mean offset and variance, and the stratigraphic interval over which the offset is averaged.
    #'
  #' @param x an `adm` object
  #' @param y an `adm` object of the same section, with identical time and length units as `x`
  #' @param h `NULL` or numeric vector of stratigraphic positions. If `NULL`, the offset is averaged over the interval `h_range`. Otherwise, it is averaged over the positions in `h`.
  #' @param h_range `NULL` or numeric vector of length two. Stratigraphic interval over which the offset is averaged. If `NULL`, the interval covered by both `x` and `y` is used. Ignored if `h` is provided.
  #'
  #' @details
    #' The age offset at stratigraphic position \eqn{h} is \eqn{d(h) = t_x(h) - t_y(h)}, where \eqn{t_x} and \eqn{t_y} are the times assigned by `x` and `y` (see [get_time()]). Positive values indicate that `x` assigns later times than `y`. The returned measures are
    #' * `mae`, the mean absolute offset \eqn{\mathrm{mean}(|d|)}, the expected offset at a uniformly distributed stratigraphic position.
    #' * `msd`, the mean square difference, with decomposition \eqn{\mathrm{msd} = \mathrm{mean}(d^2) = \mu^2 + \sigma^2}, where \eqn{\mu} is the mean offset (systematic bias) and \eqn{\sigma^2} is the variance of the offset. The RMS is the square root of the msd. It is at least as large as `mae`, and weights large offsets more heavily.
    #'
    #' If `h` is `NULL`, all stratigraphic positions in `h_range` are weighted equally, and the averages are computed exactly: Between the tie points of both age-depth models, the age offset is linear in height and is integrated analytically, including its absolute value. Hiatuses (jumps in the age as a function of height) are handled exactly, as they occupy no stratigraphic thickness.
    #'
    #' If `h` is provided, the averages are taken over the positions in `h`. Positions that coincide with hiatuses or lie outside of either age-depth model are removed with a warning. The variance is the population variance (normalized by the number of positions, not the number of positions minus one), so the decomposition holds exactly.
    #'
  #' @returns an object of S3 class `diss_age_offset`, a list with elements
    #' * `mae`: mean absolute age offset
    #' * `rms`: root mean square age offset
    #' * `msd`: mean square difference, in the squared time unit
    #' * `mu`: mean offset
    #' * `variance`: variance of the offset, in the squared time unit
    #' * `h_start`, `h_end`: start and end of the stratigraphic interval. If `h` is provided, the range of the positions used
    #' * `thickness`: length of the stratigraphic interval, `h_end - h_start`
    #' * `method`: "exact" if `h` is `NULL`, "discrete" otherwise
    #' * `n_positions`: number of positions used if `h` is provided, `NA` otherwise
    #' * `T_unit`, `L_unit`: time and length unit
    #'
  #' @seealso [get_time()] to determine the times assigned to stratigraphic positions, [diss_dating_error()] for the same offset weighted by time instead of stratigraphic position, [summary.diss_age_offset()] for a detailed summary
  #'
  #' @examples
    #' # second adm is shifted and has a hiatus at 1 m
    #' x = tp_to_adm(t = c(0, 2, 4), h = c(0, 1, 2), T_unit = "Myr", L_unit = "m")
    #' y = tp_to_adm(t = c(0.5, 1.5, 3, 4.5), h = c(0, 1, 1, 2), T_unit = "Myr", L_unit = "m")
    #' res = diss_age_offset(x, y)
    #' res
    #' summary(res)
    #' # decomposition
    #' res$mu^2 + res$variance - res$msd
    #' # average over sample positions instead
    #' diss_age_offset(x, y, h = c(0.2, 0.7, 1.5))
    #'

  stopifnot(is_adm(x), is_adm(y))
  if (!identical(get_L_unit(x), get_L_unit(y)) || !identical(get_T_unit(x), get_T_unit(y))){
    stop("age-depth models must have identical length and time units")
  }

  if (!is.null(h)){
    d = get_time(x, h, hiat_mode = "destroy", bdry_pts_hiat = "consistent") -
      get_time(y, h, hiat_mode = "destroy", bdry_pts_hiat = "consistent")
    if (anyNA(d)){
      warning("removing positions at hiatuses or outside of the age-depth models")
      h = h[!is.na(d)]
      d = d[!is.na(d)]
    }
    if (length(d) == 0){
      stop("no stratigraphic positions left to compare")
    }
    mu = mean(d)
    variance = mean((d - mu)^2)
    msd = mean(d^2)
    return(new_diss_age_offset(mae = mean(abs(d)), msd = msd, mu = mu, variance = variance,
                              h_start = min(h), h_end = max(h), thickness = max(h) - min(h),
                              method = "discrete", n_positions = length(d),
                              T_unit = get_T_unit(x), L_unit = get_L_unit(x)))
  }

  overlap = c(max(min(x$h), min(y$h)), min(max(x$h), max(y$h)))
  if (is.null(h_range)){
    h_range = overlap
  }
  if (length(h_range) != 2 || !(h_range[1] < h_range[2])){
    stop("h_range must be an interval of positive length")
  }
  if (h_range[1] < overlap[1] || h_range[2] > overlap[2]){
    stop("h_range must lie within the stratigraphic range of both age-depth models")
  }
  # the offset is linear between consecutive tie points of both adms. Use
  # one-sided limits at the ends of each segment, so jumps at hiatuses are
  # handled exactly
  kn = sort(unique(c(h_range, x$h, y$h)))
  kn = kn[kn >= h_range[1] & kn <= h_range[2]]
  a = kn[-length(kn)]
  b = kn[-1]
  lim = function(adm, h, side) get_time(adm, h, hiat_mode = side, bdry_pts_hiat = "consistent")
  d0 = lim(x, a, "end") - lim(y, a, "end") # right limit at segment start
  d1 = lim(x, b, "start") - lim(y, b, "start") # left limit at segment end
  w = b - a
  len = h_range[2] - h_range[1]
  mae = sum(w * mean_abs_linear(d0, d1)) / len
  mu = sum(w * (d0 + d1) / 2) / len
  msd = sum(w * (d0^2 + d0 * d1 + d1^2) / 3) / len
  variance = max(msd - mu^2, 0) # guard against round-off
  return(new_diss_age_offset(mae = mae, msd = msd, mu = mu, variance = variance,
                            h_start = h_range[1], h_end = h_range[2], thickness = len,
                            method = "exact", n_positions = NA_integer_,
                            T_unit = get_T_unit(x), L_unit = get_L_unit(x)))
}

new_diss_age_offset = function(mae, msd, mu, variance, h_start, h_end, thickness,
                              method, n_positions, T_unit, L_unit){
  # constructor for S3 class diss_age_offset. Not exported.
  res = list(mae = mae,
             rms = sqrt(msd),
             msd = msd,
             mu = mu,
             variance = variance,
             h_start = h_start,
             h_end = h_end,
             thickness = thickness,
             method = method,
             n_positions = n_positions,
             T_unit = T_unit,
             L_unit = L_unit)
  class(res) = "diss_age_offset"
  return(res)
}

print.diss_age_offset = function(x, digits = getOption("digits") - 3, ...){
  #' @export
  #'
  #' @title print age offset
  #'
  #' @description
    #' Prints the age offsets stored in a `diss_age_offset` object
    #'
  #' @param x a `diss_age_offset` object, see [diss_age_offset()]
  #' @param digits number of significant digits
  #' @param ... ignored
  #'
  #' @returns `x`, invisibly
  #'
  #' @seealso [diss_age_offset()] to create the object, [summary.diss_age_offset()] for a detailed summary

  f = function(v) format(v, digits = digits)
  u = if (is.null(x$T_unit)) "" else paste0(" ", x$T_unit)
  ul = if (is.null(x$L_unit)) "" else paste0(" ", x$L_unit)
  cat("Age offset (times assigned by x minus times assigned by y)\n")
  cat("  mae: ", f(x$mae), u, " (expected absolute age offset)\n", sep = "")
  cat("  rms: ", f(x$rms), u, " (mu ", f(x$mu), ", sd ", f(sqrt(x$variance)), ")\n", sep = "")
  cat("  over h in [", f(x$h_start), ", ", f(x$h_end), "]", ul, "\n", sep = "")
  invisible(x)
}

summary.diss_age_offset = function(object, ...){
  #' @export
  #'
  #' @title summary of age offset
  #'
  #' @description
    #' Summarizes a `diss_age_offset` object, listing all measures of the age offset with their units and the shares of bias and variance in the mean square difference.
    #'
  #' @param object a `diss_age_offset` object, see [diss_age_offset()]
  #' @param ... ignored
  #'
  #' @returns an object of S3 class `summary.diss_age_offset`, a list with elements `table` (data frame with columns `value` and `unit` and rows `mae`, `rms`, `mu`, `sd`, `msd`, `variance`, `bias_share`, `variance_share`), `h_start`, `h_end`, `thickness`, `method`, `n_positions`, `T_unit`, and `L_unit`. `bias_share` (\eqn{\mu^2 / \mathrm{msd}}) and `variance_share` (\eqn{\sigma^2 / \mathrm{msd}}) add up to 1, and are `NA` if the mean square difference is 0.
  #'
  #' @seealso [diss_age_offset()] to create the object

  u = if (is.null(object$T_unit)) "time unit" else object$T_unit
  share = function(part) if (object$msd > 0) part / object$msd else NA_real_
  table = data.frame(value = c(object$mae, object$rms, object$mu, sqrt(object$variance),
                               object$msd, object$variance,
                               share(object$mu^2), share(object$variance)),
                     unit = c(rep(u, 4), rep(paste0(u, "^2"), 2), "", ""),
                     row.names = c("mae", "rms", "mu", "sd", "msd", "variance",
                                   "bias_share", "variance_share"))
  res = c(list(table = table),
          object[c("h_start", "h_end", "thickness", "method", "n_positions", "T_unit", "L_unit")])
  class(res) = "summary.diss_age_offset"
  return(res)
}

print.summary.diss_age_offset = function(x, digits = getOption("digits") - 3, ...){
  #' @export
  #'
  #' @title print summary of age offset
  #'
  #' @param x a `summary.diss_age_offset` object, see [summary.diss_age_offset()]
  #' @param digits number of significant digits
  #' @param ... ignored
  #'
  #' @returns `x`, invisibly

  f = function(v) format(v, digits = digits)
  ul = if (is.null(x$L_unit)) " length units" else paste0(" ", x$L_unit)
  cat("Age offset: times assigned by x minus times assigned by y\n")
  if (x$method == "exact"){
    cat("Exact average over stratigraphic positions sampled uniformly in height\n")
  } else {
    cat("Average over ", x$n_positions, " provided stratigraphic positions\n", sep = "")
  }
  cat("Stratigraphic interval [", f(x$h_start), ", ", f(x$h_end), "], thickness ", f(x$thickness), ul, "\n\n", sep = "")
  print(x$table, digits = digits)
  cat("\nmae: expected absolute age offset; msd = mu^2 + variance\n")
  invisible(x)
}
