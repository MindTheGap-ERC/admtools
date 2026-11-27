rms_age_offset = function(x, y, h = NULL, h_range = NULL){
  #' @export
  #'
  #' @title root mean square age offset between two age-depth models
  #'
  #' @description
    #' Determines the root mean square (RMS) of the difference between the ages that two age-depth models assign to the same stratigraphic positions, along with its decomposition into mean offset and variance.
    #'
  #' @param x an `adm` object
  #' @param y an `adm` object of the same section, with identical time and length units as `x`
  #' @param h `NULL` or numeric vector of stratigraphic positions. If `NULL`, the offset is averaged over the interval `h_range`. Otherwise, it is averaged over the positions in `h`.
  #' @param h_range `NULL` or numeric vector of length two. Stratigraphic interval over which the offset is averaged. If `NULL`, the interval covered by both `x` and `y` is used. Ignored if `h` is provided.
  #'
  #' @details
    #' The age offset at stratigraphic position \eqn{h} is \eqn{d(h) = t_x(h) - t_y(h)}, where \eqn{t_x} and \eqn{t_y} are the times assigned by `x` and `y` (see [get_time()]). Positive values indicate that `x` assigns older ages than `y`. The mean square difference (msd) decomposes as
    #' \deqn{\mathrm{msd} = \mathrm{mean}(d^2) = \mu^2 + \sigma^2,}
    #' where \eqn{\mu} is the mean offset (systematic bias) and \eqn{\sigma^2} is the variance of the offset. The RMS is the square root of the msd.
    #'
    #' If `h` is `NULL`, all stratigraphic positions in `h_range` are weighted equally, and the averages are computed exactly: Between the tie points of both age-depth models, the age offset is linear in height and is integrated analytically. Hiatuses (jumps in the age as a function of height) are handled exactly, as they occupy no stratigraphic thickness.
    #'
    #' If `h` is provided, the averages are taken over the positions in `h`. Positions that coincide with hiatuses or lie outside of either age-depth model are removed with a warning. The variance is the population variance (normalized by the number of positions, not the number of positions minus one), so the decomposition holds exactly.
    #'
  #' @returns a named numeric vector with entries `rms` (root mean square age offset), `msd` (mean square difference), `mu` (mean offset), and `variance` (variance of the offset). Entries are in the squared time unit for `msd` and `variance`, and in the time unit otherwise.
  #'
  #' @seealso [get_time()] to determine the times assigned to stratigraphic positions
  #'
  #' @examples
    #' # second adm is shifted and has a hiatus at 1 m
    #' x = tp_to_adm(t = c(0, 2, 4), h = c(0, 1, 2), T_unit = "Myr", L_unit = "m")
    #' y = tp_to_adm(t = c(0.5, 1.5, 3, 4.5), h = c(0, 1, 1, 2), T_unit = "Myr", L_unit = "m")
    #' res = rms_age_offset(x, y)
    #' res
    #' # decomposition
    #' res[["mu"]]^2 + res[["variance"]] - res[["msd"]]
    #' # average over sample positions instead
    #' rms_age_offset(x, y, h = c(0.2, 0.7, 1.5))
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
      d = d[!is.na(d)]
    }
    if (length(d) == 0){
      stop("no stratigraphic positions left to compare")
    }
    mu = mean(d)
    variance = mean((d - mu)^2)
    msd = mean(d^2)
  } else {
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
    len = h_range[2] - h_range[1]
    mu = sum((b - a) * (d0 + d1) / 2) / len
    msd = sum((b - a) * (d0^2 + d0 * d1 + d1^2) / 3) / len
    variance = max(msd - mu^2, 0) # guard against round-off
  }
  return(c(rms = sqrt(msd), msd = msd, mu = mu, variance = variance))
}
