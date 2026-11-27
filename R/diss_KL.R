diss_KL = function(x, y, h_range = NULL, rate = 1){
  #' @export
  #'
  #' @title KL divergence between the distributions of time of two age-depth models
  #'
  #' @description
    #' Determines the Kullback-Leibler (KL) divergence between how two age-depth models distribute time over a stratigraphic section, splits it into a volume component (how much time is preserved) and a position component (where in the section it is preserved), and provides a symmetrized version.
    #'
  #' @param x an `adm` object
  #' @param y an `adm` object of the same section, with identical time and length units as `x`
  #' @param h_range `NULL` or numeric vector of length two. Stratigraphic interval over which the distributions of time are compared. If `NULL`, the interval covered by both `x` and `y` is used. See Details for intervals that extend beyond either age-depth model.
  #' @param rate positive number, number of events per time unit. Converts time into an expected number of events, see Details
  #'
  #' @details
    #' ## Distribution of time in the section
    #' An age-depth model distributes time over the stratigraphic section. The amount of time contained in a stratigraphic increment is given by the condensation \eqn{c(h)} (time per stratigraphic increment, see [condensation()]), the inverse of the sedimentation rate. Hiatuses represent time that is not preserved in the section: they have zero thickness and contribute no time to the distribution. The total preserved time is \eqn{\int c(h) \, dh}, i.e. the duration of the age-depth model minus the duration of its hiatuses.
    #'
    #' `diss_KL` compares the distributions of time \eqn{\lambda_x(h) = \mathrm{rate} \cdot c_x(h)} and \eqn{\lambda_y(h) = \mathrm{rate} \cdot c_y(h)} of `x` and `y`. The factor `rate` converts time into an expected number of events, and gives the KL divergence its probabilistic interpretation: If events (e.g. fossils, samples, or geochemical signals) occur in time as a homogeneous Poisson point process with rate `rate`, an age-depth model places them in the section as an inhomogeneous Poisson point process with intensity \eqn{\lambda(h)}. Events that occur during a hiatus are not preserved. The KL divergence then measures how well the stratigraphic record of events expected under `y` describes the record expected under `x`.
    #'
    #' ## Decomposition
    #' The KL divergence of the distribution of time of `x` from the one of `y` is
    #' \deqn{\mathrm{KL} = \int \lambda_x \log(\lambda_x / \lambda_y) - \lambda_x + \lambda_y \, dh = \mathrm{volume} + \mathrm{position}.}
    #' Let \eqn{\Lambda = \int \lambda \, dh} be the preserved time multiplied by `rate` (the expected number of preserved events), and \eqn{p = \lambda / \Lambda} the distribution of the preserved time within the section, normalized to one. The volume component
    #' \deqn{\mathrm{volume} = \Lambda_x \log(\Lambda_x / \Lambda_y) - \Lambda_x + \Lambda_y}
    #' only depends on how much time the two age-depth models preserve. It is zero if both preserve the same amount of time, irrespective of where in the section. It equals the KL divergence between the Poisson distributed numbers of preserved events. The position component
    #' \deqn{\mathrm{position} = \Lambda_x \, \mathrm{shape}, \quad \mathrm{shape} = \mathrm{KL}(p_x \| p_y)}
    #' only depends on where in the section the time is preserved. It is zero if both age-depth models distribute their preserved time in the same proportions over the section, irrespective of how much time they preserve. The shape term compares the normalized distributions of preserved time. It is independent of `rate` and of the time unit, whereas `kl`, `volume`, `position`, and \eqn{\Lambda} scale linearly with `rate`. In terms of events, the shape term is the position divergence per preserved event.
    #'
    #' ## Symmetrized divergence
    #' The KL divergence is not symmetric. `kl_reverse` is the KL divergence of the distribution of time of `y` from the one of `x`, and `kl_sym` is the symmetrized (Jeffreys) divergence
    #' \deqn{\mathrm{kl\_sym} = \mathrm{KL}(x \| y) + \mathrm{KL}(y \| x) = \int (\lambda_x - \lambda_y) \log(\lambda_x / \lambda_y) \, dh,}
    #' which is symmetric in `x` and `y`. The components of the reverse direction are stored in the element `reverse`.
    #'
    #' All calculations are exact: The condensation of both age-depth models is constant between consecutive tie points of the two age-depth models, so all integrals reduce to finite sums.
    #'
    #' ## Sections without time and the convention 0 log 0 = 0
    #' Age-depth models have strictly increasing time tie points (see [is_adm()]), so the condensation is strictly positive everywhere within the stratigraphic range of an age-depth model: every stratigraphic increment contains some time. Stratigraphic intervals without time therefore only occur if `h_range` extends beyond the range of `x` or `y`. Outside of its range, an age-depth model has no sediment and contains no time. The following cases can occur:
    #' * Within the range of both models (in particular for the default `h_range`), both models assign time everywhere and all divergences are finite.
    #' * Where \eqn{\lambda_x = 0 < \lambda_y}, the term \eqn{\lambda_x \log(\lambda_x / \lambda_y)} is 0 (convention \eqn{0 \log 0 = 0}), and the interval contributes \eqn{\int \lambda_y \, dh} to the KL divergence: `y` places time where `x` places none, which is penalized only by the amount of that time.
    #' * Where \eqn{\lambda_x > 0 = \lambda_y}, `x` places time where `y` places none (in terms of events: `x` predicts events that are impossible under `y`), and the KL divergence, its position component and the shape term are `Inf`. If in addition \eqn{\Lambda_y = 0}, the volume component is `Inf` as well.
    #' * If \eqn{\Lambda_x = 0} (`h_range` does not overlap with `x`), `x` preserves no time in `h_range`, the position component is 0 by convention, the shape term is undefined (`NA`), and the KL divergence equals the volume component \eqn{\Lambda_y}.
    #' * If neither model preserves time in `h_range`, all divergences are 0, and the shape terms are `NA`.
    #' * `kl_sym` is `Inf` if either direction is `Inf`, i.e. whenever exactly one of the models places time on part of `h_range`.
    #'
  #' @returns an object of S3 class `diss_KL`, a list with elements
    #' * `kl`, `volume`, `position`, `shape`: KL divergence of the distribution of time of `x` from the one of `y`, and its components (`kl = volume + position`, `position = Lambda_x * shape`)
    #' * `kl_reverse`: KL divergence of `y` from `x`
    #' * `kl_sym`: symmetrized divergence `kl + kl_reverse`
    #' * `Lambda_x`, `Lambda_y`: time preserved by `x` and `y` in `h_range`, multiplied by `rate` (expected number of preserved events)
    #' * `reverse`: list with the components `kl`, `volume`, `position`, and `shape` of the reverse direction
    #' * `h_range`, `rate`, `T_unit`, `L_unit`: settings used for the comparison
    #'
  #' @seealso [condensation()] for the condensation of an age-depth model, [diss_age_offset()] for a dissimilarity based on age offsets, [summary.diss_KL()] for a detailed summary
  #'
  #' @examples
    #' # x has a hiatus from 1 to 3 Myr at 1 m
    #' x = tp_to_adm(t = c(0, 1, 3, 4, 6), h = c(0, 1, 1, 1.5, 2), T_unit = "Myr", L_unit = "m")
    #' y = tp_to_adm(t = c(0, 2, 5), h = c(0, 1, 2), T_unit = "Myr", L_unit = "m")
    #' res = diss_KL(x, y)
    #' res
    #' summary(res)
    #' # decomposition
    #' res$kl - res$volume - res$position
    #' # x preserves 4 Myr, y 5 Myr
    #' c(res$Lambda_x, res$Lambda_y)
    #' # comparison of normalized distributions of preserved time does not depend on rate
    #' diss_KL(x, y, rate = 100)$shape
    #'

  stopifnot(is_adm(x), is_adm(y))
  if (!is.numeric(rate) || length(rate) != 1 || !(rate > 0)){
    stop("rate must be a single positive number")
  }
  if (!identical(get_L_unit(x), get_L_unit(y)) || !identical(get_T_unit(x), get_T_unit(y))){
    stop("age-depth models must have identical length and time units")
  }
  if (is.null(h_range)){
    h_range = c(max(min(x$h), min(y$h)), min(max(x$h), max(y$h)))
    if (!(h_range[1] < h_range[2])){
      stop("age-depth models do not overlap, please provide h_range")
    }
  }
  if (!is.numeric(h_range) || length(h_range) != 2 || !(h_range[1] < h_range[2])){
    stop("h_range must be an interval of positive length")
  }

  # condensation at positions strictly between tie points. Hiatuses have zero
  # thickness and contribute no atoms (destructive gaps). Zero outside of the adm
  cond_at = function(adm, h){
    acc = diff(adm$h) > 0
    knots = c(adm$h[1], adm$h[-1][acc])
    cond = (diff(adm$t) / diff(adm$h))[acc]
    res = rep(0, length(h))
    inside = h > min(adm$h) & h < max(adm$h)
    res[inside] = cond[findInterval(h[inside], knots)]
    return(res)
  }

  # both intensities are constant between consecutive tie points of both adms
  kn = sort(unique(c(h_range, x$h, y$h)))
  kn = kn[kn >= h_range[1] & kn <= h_range[2]]
  w = diff(kn)
  mid = kn[-length(kn)] + w / 2
  lx = rate * cond_at(x, mid)
  ly = rate * cond_at(y, mid)

  fwd = poisson_kl_parts(lx, ly, w)
  rev = poisson_kl_parts(ly, lx, w)

  res = list(kl = fwd$kl,
             volume = fwd$volume,
             position = fwd$position,
             shape = fwd$shape,
             kl_reverse = rev$kl,
             kl_sym = fwd$kl + rev$kl,
             Lambda_x = fwd$Lambda_p,
             Lambda_y = fwd$Lambda_q,
             reverse = rev[c("kl", "volume", "position", "shape")],
             h_range = h_range,
             rate = rate,
             T_unit = get_T_unit(x),
             L_unit = get_L_unit(x))
  class(res) = "diss_KL"
  return(res)
}

poisson_kl_parts = function(lp, lq, w){
  # KL divergence of Poisson process with piecewise constant intensity lp from
  # one with intensity lq, on segments of length w, and its decomposition.
  # Not exported.

  # a log(a/b) with the conventions 0 log(0/b) = 0 and a log(a/0) = Inf for a > 0
  xlogy = function(a, b){
    res = rep(0, length(a))
    pos = a > 0
    res[pos] = a[pos] * log(a[pos] / b[pos])
    return(res)
  }

  Lp = sum(w * lp)
  Lq = sum(w * lq)
  volume = xlogy(Lp, Lq) - Lp + Lq
  if (Lp == 0){
    shape = NA_real_
    position = 0
  } else if (Lq == 0){
    shape = Inf
    position = Inf
  } else {
    shape = sum(w * xlogy(lp / Lp, lq / Lq))
    position = Lp * shape
  }
  kl = sum(w * (xlogy(lp, lq) - lp + lq))
  return(list(kl = kl, volume = volume, position = position, shape = shape,
              Lambda_p = Lp, Lambda_q = Lq))
}

print.diss_KL = function(x, digits = getOption("digits") - 3, ...){
  #' @export
  #'
  #' @title print KL divergence
  #'
  #' @description
    #' Prints the KL divergence and its components stored in a `diss_KL` object
    #'
  #' @param x a `diss_KL` object, see [diss_KL()]
  #' @param digits number of significant digits
  #' @param ... ignored
  #'
  #' @returns `x`, invisibly
  #'
  #' @seealso [diss_KL()] to create the object, [summary.diss_KL()] for a detailed summary

  f = function(v) format(v, digits = digits)
  cat("KL divergence of the distribution of time of x from y\n")
  cat("  kl:         ", f(x$kl), " = volume ", f(x$volume), " + position ", f(x$position), "\n", sep = "")
  cat("  shape:      ", f(x$shape), " (normalized distributions of preserved time)\n", sep = "")
  cat("  kl_reverse: ", f(x$kl_reverse), "\n", sep = "")
  cat("  kl_sym:     ", f(x$kl_sym), "\n", sep = "")
  invisible(x)
}

summary.diss_KL = function(object, ...){
  #' @export
  #'
  #' @title summary of KL divergence
  #'
  #' @description
    #' Summarizes a `diss_KL` object, listing the components for both directions of the KL divergence and the shares of the volume component (how much time is preserved) and the position component (where in the section it is preserved).
    #'
  #' @param object a `diss_KL` object, see [diss_KL()]
  #' @param ... ignored
  #'
  #' @returns an object of S3 class `summary.diss_KL`, a list with elements `table` (data frame with columns `x_from_y` and `y_from_x` and rows `kl`, `volume`, `position`, `shape`, `Lambda`, `volume_share`, `position_share`), `kl_sym`, `h_range`, `rate`, `T_unit`, and `L_unit`. Shares are `NA` if the divergence is 0 or infinite.
  #'
  #' @seealso [diss_KL()] to create the object

  share = function(part, total) if (is.finite(total) && total > 0) part / total else NA_real_
  col = function(d, Lambda){
    c(kl = d$kl, volume = d$volume, position = d$position, shape = d$shape, Lambda = Lambda,
      volume_share = share(d$volume, d$kl), position_share = share(d$position, d$kl))
  }
  fwd = object[c("kl", "volume", "position", "shape")]
  table = data.frame(x_from_y = col(fwd, object$Lambda_x),
                     y_from_x = col(object$reverse, object$Lambda_y))
  res = list(table = table,
             kl_sym = object$kl_sym,
             h_range = object$h_range,
             rate = object$rate,
             T_unit = object$T_unit,
             L_unit = object$L_unit)
  class(res) = "summary.diss_KL"
  return(res)
}

print.summary.diss_KL = function(x, digits = getOption("digits") - 3, ...){
  #' @export
  #'
  #' @title print summary of KL divergence
  #'
  #' @param x a `summary.diss_KL` object, see [summary.diss_KL()]
  #' @param digits number of significant digits
  #' @param ... ignored
  #'
  #' @returns `x`, invisibly

  unit = function(u) if (is.null(u)) "" else paste0(" ", u)
  cat("KL divergence between the distributions of time of age-depth models x and y\n")
  cat("Compared over h in [", format(x$h_range[1], digits = digits), ", ",
      format(x$h_range[2], digits = digits), "]", unit(x$L_unit),
      ", event rate ", format(x$rate, digits = digits), " per",
      if (is.null(x$T_unit)) " time unit" else unit(x$T_unit), "\n\n", sep = "")
  print(x$table, digits = digits)
  cat("\nSymmetrized divergence (kl_sym): ", format(x$kl_sym, digits = digits), "\n", sep = "")
  cat("volume: how much time is preserved; position: where in the section it is preserved\n")
  cat("Lambda: preserved time times rate; shape: divergence of normalized distributions of preserved time\n")
  invisible(x)
}
