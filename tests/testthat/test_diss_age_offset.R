err_parts = c("rms", "msd", "mu", "variance")
num_parts = c("mae", err_parts, "h_start", "h_end", "thickness")
comps = function(res, nms) unlist(res[nms], use.names = FALSE)

test_that("identical adms have zero offset", {
  adm = tp_to_adm(t = 1:4, h = c(1,2,2,3))
  expect_equal(comps(diss_age_offset(adm, adm), c("mae", err_parts)), rep(0, 5))
})

test_that("constant shift gives offset without variance", {
  x = tp_to_adm(t = 1:3, h = 1:3)
  y = tp_to_adm(t = 0:2, h = 1:3)
  res = diss_age_offset(x, y)
  expect_equal(res[["mu"]], 1)
  expect_equal(res[["variance"]], 0)
  expect_equal(res[["rms"]], 1)
  expect_equal(diss_age_offset(y, x)[["mu"]], -1)
})

test_that("exact values for adms with hiatus match hand calculation", {
  # d(h) = h - 0.5 on [0,1], d(h) = 0.5 h - 1.5 on [1,2]
  x = tp_to_adm(t = c(0, 2, 4), h = c(0, 1, 2))
  y = tp_to_adm(t = c(0.5, 1.5, 3, 4.5), h = c(0, 1, 1, 2))
  res = diss_age_offset(x, y)
  expect_equal(res[["mu"]], -0.375)
  expect_equal(res[["msd"]], 1/3)
  expect_equal(res[["variance"]], 1/3 - 0.375^2)
  expect_equal(res[["rms"]], sqrt(1/3))
  expect_equal(res[["mae"]], (1/4 + 3/4) / 2)
  expect_equal(comps(res, c("h_start", "h_end", "thickness")), c(0, 2, 2))

  # restricted interval: only [0,1], where d(h) = h - 0.5
  res = diss_age_offset(x, y, h_range = c(0, 1))
  expect_equal(res[["mu"]], 0)
  expect_equal(res[["msd"]], 1/12)
  expect_equal(res[["mae"]], 1/4)
})

test_that("decomposition holds", {
  set.seed(1)
  for (k in 1:50){
    x = tp_to_adm(t = sort(stats::runif(5)), h = c(0, cumsum(stats::runif(4) * (stats::runif(4) > 0.3))))
    y = tp_to_adm(t = sort(stats::runif(6)), h = c(0, cumsum(stats::runif(5) * (stats::runif(5) > 0.3))))
    if (max(x$h) == 0 || max(y$h) == 0) next
    res = diss_age_offset(x, y)
    expect_equal(res[["mu"]]^2 + res[["variance"]], res[["msd"]])
    expect_equal(res[["rms"]]^2, res[["msd"]])
    expect_lte(res[["mae"]], res[["rms"]] + 1e-12)
  }
})

test_that("exact integration agrees with dense sampling", {
  x = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 0.5, 0.5, 1))
  y = tp_to_adm(t = c(0, 2, 3, 5), h = c(0, 0.3, 0.8, 1))
  exact = diss_age_offset(x, y)
  dense = suppressWarnings(diss_age_offset(x, y, h = seq(0, 1, length.out = 1e5 + 1)))
  expect_equal(comps(exact, num_parts), comps(dense, num_parts), tolerance = 1e-4)
})

test_that("discrete positions give population moments", {
  x = tp_to_adm(t = 1:3, h = 1:3)
  y = tp_to_adm(t = c(1, 1.5, 3), h = 1:3)
  h = c(1, 2, 3)
  d = c(0, 0.5, 0)
  res = diss_age_offset(x, y, h = h)
  expect_equal(res[["mu"]], mean(d))
  expect_equal(res[["variance"]], mean((d - mean(d))^2))
  expect_equal(res[["msd"]], mean(d^2))
  expect_equal(res[["mae"]], mean(abs(d)))
  expect_equal(res$n_positions, 3)
})

test_that("positions at hiatuses or out of domain are removed with warning", {
  x = tp_to_adm(t = 1:4, h = c(1,2,2,3))
  y = tp_to_adm(t = 1:3, h = c(1,2,3))
  expect_warning(res <- diss_age_offset(x, y, h = c(1.5, 2, 5)))
  expect_equal(res[["mu"]], 0)
  expect_error(suppressWarnings(diss_age_offset(x, y, h = 5)))
})

test_that("invalid inputs are rejected", {
  x = tp_to_adm(t = 1:3, h = 1:3, T_unit = "Myr", L_unit = "m")
  y = tp_to_adm(t = 1:3, h = 1:3, T_unit = "kyr", L_unit = "m")
  expect_error(diss_age_offset(x, y))
  expect_error(diss_age_offset(x, x, h_range = c(0, 2)))
  expect_error(diss_age_offset(x, x, h_range = c(2, 2)))
  expect_error(diss_age_offset(x, list()))
})

test_that("S3 class, print and summary work", {
  x = tp_to_adm(t = c(0, 2, 4), h = c(0, 1, 2), T_unit = "Myr", L_unit = "m")
  y = tp_to_adm(t = c(0.5, 1.5, 3, 4.5), h = c(0, 1, 1, 2), T_unit = "Myr", L_unit = "m")
  res = diss_age_offset(x, y)
  expect_s3_class(res, "diss_age_offset")
  expect_equal(res$method, "exact")
  expect_true(is.na(res$n_positions))
  expect_equal(res$L_unit, "m")
  expect_output(expect_invisible(print(res)), "mae")
  expect_output(print(res), "over h in [0, 2] m", fixed = TRUE)

  s = summary(res)
  expect_s3_class(s, "summary.diss_age_offset")
  expect_equal(s$table["mu", "value"], res$mu)
  expect_equal(s$table["variance", "unit"], "Myr^2")
  expect_equal(s$table["bias_share", "value"] + s$table["variance_share", "value"], 1)
  expect_output(print(s), "Exact average")
  expect_output(print(s), "thickness 2 m")

  s = summary(diss_age_offset(x, y, h = c(0.2, 0.7, 1.5)))
  expect_equal(s$method, "discrete")
  expect_output(print(s), "3 provided stratigraphic positions")

  a = tp_to_adm(t = 1:3, h = 1:3)
  s = summary(diss_age_offset(a, a))
  expect_true(is.na(s$table["bias_share", "value"]))
  expect_output(print(s), "length units")
})
