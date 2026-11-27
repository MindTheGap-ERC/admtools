err_parts = c("rms", "msd", "mu", "variance")
num_parts = c("mae", err_parts, "t_start", "t_end", "duration")
comps = function(res, nms) unlist(res[nms], use.names = FALSE)

test_that("identical adms have no dating error, also with hiatuses", {
  adm = tp_to_adm(t = 1:3, h = 1:3)
  res = diss_dating_error(adm, adm)
  expect_equal(comps(res, c("mae", err_parts)), rep(0, 5))
  expect_equal(comps(res, c("t_start", "t_end", "duration")), c(1, 3, 2))
  # events in the shared gap are dated to the gap itself
  adm = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 1, 1, 2))
  res = diss_dating_error(adm, adm)
  expect_equal(comps(res, c("mae", err_parts)), rep(0, 5))
  expect_equal(comps(diss_dating_error(adm, adm, t = c(0.5, 2, 3.5)), c("mae", err_parts)), rep(0, 5))
})

test_that("constant shift gives error without variance", {
  x = tp_to_adm(t = 1:3, h = 1:3)
  y = tp_to_adm(t = 0:2, h = 1:3)
  res = diss_dating_error(x, y)
  expect_equal(res[["mu"]], 1)
  expect_equal(res[["mae"]], 1)
  expect_equal(res[["variance"]], 0)
  expect_equal(diss_dating_error(y, x)[["mu"]], -1)
})

test_that("exact values for adm with hiatus match hand calculation", {
  # x: h = t on [0,1], hiatus from 1 to 3 at h = 1, h = t - 2 on [3,4]; y: t = 2h
  # e(t) = -t on [0,1], t - 2 on [1,3], 4 - t on [3,4]
  x = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 1, 1, 2))
  y = tp_to_adm(t = c(0, 4), h = c(0, 2))
  res = diss_dating_error(x, y)
  expect_equal(res[["mu"]], 0)
  expect_equal(res[["msd"]], 1/3)
  expect_equal(res[["variance"]], 1/3)
  expect_equal(res[["mae"]], 0.5)
  expect_equal(comps(res, c("t_start", "t_end", "duration")), c(0, 4, 4))

  # restricted to accumulation
  res = diss_dating_error(x, y, t_range = c(0, 1))
  expect_equal(res[["mu"]], -0.5)
  expect_equal(res[["msd"]], 1/3)
  expect_equal(res[["mae"]], 0.5)
  expect_equal(res[["duration"]], 1)

  # restricted to within the hiatus: e(t) = t - 2 on [1.5, 2.5]
  res = diss_dating_error(x, y, t_range = c(1.5, 2.5))
  expect_equal(res[["mu"]], 0)
  expect_equal(res[["msd"]], 1/12)
  expect_equal(res[["mae"]], 0.25)
  expect_equal(comps(res, c("t_start", "t_end", "duration")), c(1.5, 2.5, 1))
})

test_that("absolute error is exact for sign changes within segments", {
  # t_y(h) = 2h - 1, so e(t) = 1 - t on [0, 3]: |e| integrates to 0.5 + 2 = 2.5
  x = tp_to_adm(t = c(0, 3), h = c(0, 3))
  y = tp_to_adm(t = c(-1, 5), h = c(0, 3))
  res = diss_dating_error(x, y)
  expect_equal(res[["mu"]], -0.5)
  expect_equal(res[["mae"]], 2.5 / 3)
})

test_that("shared hiatus surfaces use the set-valued dating error", {
  # both adms have a hiatus at h = 1: x with gap [1,3], y with gap [1,2]
  # e(t) = 0 on [0,1], 0 on the intersection [1,2], t - 2 on [2,3], 1 on [3,4]
  x = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 1, 1, 2))
  y = tp_to_adm(t = c(0, 1, 2, 3), h = c(0, 1, 1, 2))
  res = diss_dating_error(x, y)
  expect_equal(res[["mu"]], 3/8)
  expect_equal(res[["msd"]], 1/3)
  expect_equal(res[["mae"]], 3/8)
  expect_equal(res[["duration"]], 4)
  expect_equal(comps(diss_dating_error(x, y, t_range = c(1, 2)), c("mae", err_parts)), rep(0, 5))

  # gap of y [2,4] starts later: e(t) = -t on [0,1], t - 2 on [1,2], 0 on [2,3], -1 on [3,4]
  y = tp_to_adm(t = c(0, 2, 4, 5), h = c(0, 1, 1, 2))
  res = diss_dating_error(x, y)
  expect_equal(res[["mu"]], -1/2)
  expect_equal(res[["msd"]], 5/12)
  expect_equal(res[["mae"]], 1/2)
  # agrees with dense sampling
  dense = diss_dating_error(x, y, t = seq(0, 4, length.out = 1e5 + 1))
  expect_equal(comps(res, num_parts), comps(dense, num_parts), tolerance = 1e-4)

  # gap of x contained in gap of y: no error in the gap
  y = tp_to_adm(t = c(0, 0.5, 3.5, 4.5), h = c(0, 1, 1, 2))
  expect_equal(comps(diss_dating_error(x, y, t_range = c(1, 3)), c("mae", err_parts)), rep(0, 5))
})

test_that("coincides with diss_age_offset for constant sedimentation rate in x", {
  x = tp_to_adm(t = c(0, 3), h = c(0, 2))
  y = tp_to_adm(t = c(0.5, 1.5, 3, 4.5), h = c(0, 1, 1, 2)) # hiatus in y
  expect_equal(comps(diss_dating_error(x, y), c("mae", err_parts)), comps(diss_age_offset(x, y), c("mae", err_parts)))
})

test_that("effective time interval is limited by the range of y", {
  x = tp_to_adm(t = c(0, 4), h = c(0, 4))
  y = tp_to_adm(t = c(0, 2), h = c(1, 3))
  res = diss_dating_error(x, y)
  expect_equal(comps(res, c("t_start", "t_end", "duration")), c(1, 3, 2))
})

test_that("decomposition holds and exact values agree with dense sampling", {
  set.seed(4)
  rand_adm = function(){
    n = sample(3:8, 1)
    dh = stats::runif(n - 1) * (stats::runif(n - 1) > 0.3)
    dh[1] = dh[1] + 0.1 # at least one accumulating interval
    tp_to_adm(t = sort(stats::runif(n, 0, 10)), h = cumsum(c(0, dh)) / sum(dh))
  }
  for (k in 1:20){
    x = rand_adm()
    y = rand_adm()
    res = diss_dating_error(x, y)
    expect_equal(res[["mu"]]^2 + res[["variance"]], res[["msd"]])
    expect_lte(res[["mae"]], res[["rms"]] + 1e-12)
    expect_equal(comps(res, c("t_start", "t_end", "duration")),
                 c(min(x$t), max(x$t), diff(range(x$t))))
    t = seq(min(x$t), max(x$t), length.out = 1e5 + 1)
    dense = diss_dating_error(x, y, t = t)
    expect_equal(comps(res, num_parts), comps(dense, num_parts), tolerance = 1e-3)
  }
})

test_that("discrete times give population moments", {
  x = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 1, 1, 2))
  y = tp_to_adm(t = c(0, 4), h = c(0, 2))
  t = c(0.5, 1.5, 3.5) # second time is in the hiatus of x
  e = c(-0.5, -0.5, 0.5)
  res = diss_dating_error(x, y, t = t)
  expect_equal(res[["mu"]], mean(e))
  expect_equal(res[["variance"]], mean((e - mean(e))^2))
  expect_equal(res[["msd"]], mean(e^2))
  expect_equal(res[["mae"]], mean(abs(e)))
  expect_equal(comps(res, c("t_start", "t_end", "duration")), c(0.5, 3.5, 3))
})

test_that("times out of domain are removed with warning", {
  x = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 1, 1, 2))
  y = tp_to_adm(t = c(0, 4), h = c(0, 2))
  expect_warning(res <- diss_dating_error(x, y, t = c(0.5, 3.5, 10)))
  expect_equal(res[["mu"]], 0)
  expect_equal(res[["t_end"]], 3.5)
  expect_error(suppressWarnings(diss_dating_error(x, y, t = 10)))
})

test_that("discrete times at hiatus surfaces of y use the closest time in the gap", {
  x = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 1, 1, 2))
  y = tp_to_adm(t = c(0, 2, 4, 5), h = c(0, 1, 1, 2)) # gap [2,4] at h = 1
  res = diss_dating_error(x, y, t = c(1.5, 2.5))
  expect_equal(res[["mu"]], (-0.5 + 0) / 2)
})

test_that("invalid inputs are rejected", {
  x = tp_to_adm(t = 1:3, h = 1:3, T_unit = "Myr", L_unit = "m")
  y = tp_to_adm(t = 1:3, h = 1:3, T_unit = "kyr", L_unit = "m")
  expect_error(diss_dating_error(x, y))
  expect_error(diss_dating_error(x, x, t_range = c(0, 2)))
  expect_error(diss_dating_error(x, x, t_range = c(2, 2)))
  expect_error(diss_dating_error(x, list()))
  # t_range maps outside of the range of y
  z = tp_to_adm(t = 1:3, h = c(1, 1.5, 2), T_unit = "Myr", L_unit = "m")
  expect_error(diss_dating_error(x, z, t_range = c(1, 3)))
  # no overlap
  expect_error(diss_dating_error(x, tp_to_adm(t = 1:2, h = 5:6, T_unit = "Myr", L_unit = "m")))
})

test_that("S3 class, print and summary work", {
  x = tp_to_adm(t = c(0, 1, 3, 5), h = c(0, 1, 1, 2), T_unit = "Myr", L_unit = "m")
  y = tp_to_adm(t = c(0, 5), h = c(0, 2), T_unit = "Myr", L_unit = "m")
  res = diss_dating_error(x, y)
  expect_s3_class(res, "diss_dating_error")
  expect_equal(res$method, "exact")
  expect_true(is.na(res$n_times))
  expect_equal(res$T_unit, "Myr")
  expect_equal(res$rms, sqrt(res$msd))
  expect_output(expect_invisible(print(res)), "mae")
  expect_output(print(res), "Myr")

  s = summary(res)
  expect_s3_class(s, "summary.diss_dating_error")
  expect_equal(s$table["mae", "value"], res$mae)
  expect_equal(s$table["sd", "value"], sqrt(res$variance))
  expect_equal(s$table["msd", "unit"], "Myr^2")
  expect_equal(s$table["bias_share", "value"] + s$table["variance_share", "value"], 1)
  expect_equal(s$table["bias_share", "value"], res$mu^2 / res$msd)
  expect_output(print(s), "Exact average")
  expect_output(print(s), "duration 5 Myr")

  # discrete times
  s = summary(diss_dating_error(x, y, t = c(0.5, 2, 4)))
  expect_equal(s$method, "discrete")
  expect_equal(s$n_times, 3)
  expect_output(print(s), "3 provided times")

  # shares are NA without error, units may be missing
  a = tp_to_adm(t = 1:3, h = 1:3)
  s = summary(diss_dating_error(a, a))
  expect_true(is.na(s$table["bias_share", "value"]))
  expect_equal(s$table["mae", "unit"], "time unit")
  expect_output(print(s), "time units")
  expect_output(print(diss_dating_error(a, a)), "mae")
})
