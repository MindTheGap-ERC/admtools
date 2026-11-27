test_that("identical adms have zero offset", {
  adm = tp_to_adm(t = 1:4, h = c(1,2,2,3))
  expect_equal(unname(rms_age_offset(adm, adm)), c(0, 0, 0, 0))
})

test_that("constant shift gives offset without variance", {
  x = tp_to_adm(t = 1:3, h = 1:3)
  y = tp_to_adm(t = 0:2, h = 1:3)
  res = rms_age_offset(x, y)
  expect_equal(res[["mu"]], 1)
  expect_equal(res[["variance"]], 0)
  expect_equal(res[["rms"]], 1)
  expect_equal(rms_age_offset(y, x)[["mu"]], -1)
})

test_that("exact values for adms with hiatus match hand calculation", {
  # d(h) = h - 0.5 on [0,1], d(h) = 0.5 h - 1.5 on [1,2]
  x = tp_to_adm(t = c(0, 2, 4), h = c(0, 1, 2))
  y = tp_to_adm(t = c(0.5, 1.5, 3, 4.5), h = c(0, 1, 1, 2))
  res = rms_age_offset(x, y)
  expect_equal(res[["mu"]], -0.375)
  expect_equal(res[["msd"]], 1/3)
  expect_equal(res[["variance"]], 1/3 - 0.375^2)
  expect_equal(res[["rms"]], sqrt(1/3))

  # restricted interval: only [0,1], where d(h) = h - 0.5
  res = rms_age_offset(x, y, h_range = c(0, 1))
  expect_equal(res[["mu"]], 0)
  expect_equal(res[["msd"]], 1/12)
})

test_that("decomposition holds", {
  set.seed(1)
  for (k in 1:50){
    x = tp_to_adm(t = sort(stats::runif(5)), h = c(0, cumsum(stats::runif(4) * (stats::runif(4) > 0.3))))
    y = tp_to_adm(t = sort(stats::runif(6)), h = c(0, cumsum(stats::runif(5) * (stats::runif(5) > 0.3))))
    if (max(x$h) == 0 || max(y$h) == 0) next
    res = rms_age_offset(x, y)
    expect_equal(res[["mu"]]^2 + res[["variance"]], res[["msd"]])
    expect_equal(res[["rms"]]^2, res[["msd"]])
  }
})

test_that("exact integration agrees with dense sampling", {
  x = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 0.5, 0.5, 1))
  y = tp_to_adm(t = c(0, 2, 3, 5), h = c(0, 0.3, 0.8, 1))
  exact = rms_age_offset(x, y)
  dense = suppressWarnings(rms_age_offset(x, y, h = seq(0, 1, length.out = 1e5 + 1)))
  expect_equal(exact, dense, tolerance = 1e-4)
})

test_that("discrete positions give population moments", {
  x = tp_to_adm(t = 1:3, h = 1:3)
  y = tp_to_adm(t = c(1, 1.5, 3), h = 1:3)
  h = c(1, 2, 3)
  d = c(0, 0.5, 0)
  res = rms_age_offset(x, y, h = h)
  expect_equal(res[["mu"]], mean(d))
  expect_equal(res[["variance"]], mean((d - mean(d))^2))
  expect_equal(res[["msd"]], mean(d^2))
})

test_that("positions at hiatuses or out of domain are removed with warning", {
  x = tp_to_adm(t = 1:4, h = c(1,2,2,3))
  y = tp_to_adm(t = 1:3, h = c(1,2,3))
  expect_warning(res <- rms_age_offset(x, y, h = c(1.5, 2, 5)))
  expect_equal(res[["mu"]], 0)
  expect_error(suppressWarnings(rms_age_offset(x, y, h = 5)))
})

test_that("invalid inputs are rejected", {
  x = tp_to_adm(t = 1:3, h = 1:3, T_unit = "Myr", L_unit = "m")
  y = tp_to_adm(t = 1:3, h = 1:3, T_unit = "kyr", L_unit = "m")
  expect_error(rms_age_offset(x, y))
  expect_error(rms_age_offset(x, x, h_range = c(0, 2)))
  expect_error(rms_age_offset(x, x, h_range = c(2, 2)))
  expect_error(rms_age_offset(x, list()))
})
