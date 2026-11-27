comps = function(res, nms = c("kl", "volume", "position")) unlist(res[nms], use.names = FALSE)

test_that("identical adms have zero divergence", {
  adm = tp_to_adm(t = c(0, 1, 3, 4), h = c(0, 1, 1, 2))
  res = diss_KL(adm, adm)
  expect_equal(comps(res, c("kl", "volume", "position", "shape", "kl_reverse", "kl_sym")), rep(0, 6))
  # Lambda is the preserved time
  expect_equal(res[["Lambda_x"]], 2)
})

test_that("exact values match hand calculation", {
  # x: condensation 1 on [0,1], 2 on (1,1.5], 4 on (1.5,2], hiatus of 2 Myr at 1 m
  # y: condensation 2 on [0,1], 3 on (1,2]
  x = tp_to_adm(t = c(0, 1, 3, 4, 6), h = c(0, 1, 1, 1.5, 2))
  y = tp_to_adm(t = c(0, 2, 5), h = c(0, 1, 2))
  res = diss_KL(x, y)
  kl = 1 * (log(1/2) - 1 + 2) + 0.5 * (2 * log(2/3) - 2 + 3) + 0.5 * (4 * log(4/3) - 4 + 3)
  expect_equal(res[["kl"]], kl)
  expect_equal(res[["Lambda_x"]], 4)
  expect_equal(res[["Lambda_y"]], 5)
  expect_equal(res[["volume"]], 4 * log(4/5) - 4 + 5)
  expect_equal(res[["kl"]], res[["volume"]] + res[["position"]])
})

test_that("components scale with rate, except position per event", {
  x = tp_to_adm(t = c(0, 1, 3, 4, 6), h = c(0, 1, 1, 1.5, 2))
  y = tp_to_adm(t = c(0, 2, 5), h = c(0, 1, 2))
  r1 = diss_KL(x, y)
  r10 = diss_KL(x, y, rate = 10)
  for (nm in c("kl", "volume", "position", "kl_reverse", "kl_sym", "Lambda_x", "Lambda_y")) expect_equal(r10[[nm]], 10 * r1[[nm]])
  expect_equal(r10$shape, r1$shape)
  expect_equal(r1$position, r1$Lambda_x * r1$shape)
})

test_that("only preserved time differs: pure volume component", {
  # same shape of condensation, y preserves twice as much time
  x = tp_to_adm(t = c(0, 1, 3), h = c(0, 1, 2))
  y = tp_to_adm(t = c(0, 2, 6), h = c(0, 1, 2))
  res = diss_KL(x, y)
  expect_equal(res[["position"]], 0)
  expect_equal(res[["kl"]], 3 * log(3/6) - 3 + 6)
})

test_that("decomposition holds and agrees with numerical integration", {
  set.seed(2)
  rand_adm = function(){
    n = sample(3:8, 1)
    dh = stats::runif(n - 1) * (stats::runif(n - 1) > 0.3)
    dh[1] = dh[1] + 0.1 # at least one accumulating interval
    tp_to_adm(t = sort(stats::runif(n, 0, 10)), h = cumsum(c(0, dh)) / sum(dh))
  }
  for (k in 1:30){
    a = rand_adm()
    b = rand_adm()
    res = diss_KL(a, b)
    expect_equal(res[["kl"]], res[["volume"]] + res[["position"]])
    la = function(h) condensation(a, h, hiat_mode = "end")
    lb = function(h) condensation(b, h, hiat_mode = "end")
    kn = sort(unique(c(a$h, b$h)))
    num = sum(sapply(seq_len(length(kn) - 1), function(i){
      stats::integrate(function(h) la(h) * log(la(h) / lb(h)) - la(h) + lb(h),
                       kn[i], kn[i + 1], rel.tol = 1e-10)$value
    }))
    expect_equal(res[["kl"]], num, tolerance = 1e-8)
  }
})

test_that("zero intensities outside of the adms are handled", {
  x = tp_to_adm(t = c(0, 1), h = c(0, 1))       # covers [0,1]
  y = tp_to_adm(t = c(0, 2, 3), h = c(0, 1, 2)) # covers [0,2]

  # lambda_x = 0 < lambda_y on (1,2]: contributes Lambda_y on (1,2] = 1
  res = diss_KL(x, y, h_range = c(0, 2))
  expect_equal(res[["kl"]], 2 - log(2))
  expect_equal(res[["volume"]], 2 - log(3))
  expect_equal(res[["position"]], log(3/2))

  # lambda_x > 0 = lambda_y on (1,2]: impossible events under x
  res = diss_KL(y, x, h_range = c(0, 2))
  expect_equal(res[["kl"]], Inf)
  expect_equal(res[["position"]], Inf)
  expect_true(is.finite(res[["volume"]]))

  # Lambda_x = 0: x produces no events in the interval
  res = diss_KL(x, y, h_range = c(1, 2))
  expect_equal(comps(res, c("kl", "volume", "position", "Lambda_x", "Lambda_y")), c(1, 1, 0, 0, 1))
  expect_true(is.na(res$shape))
  expect_equal(res$kl_sym, Inf)

  # Lambda_y = 0 < Lambda_x
  res = diss_KL(y, x, h_range = c(1, 2))
  expect_equal(comps(res, c("kl", "volume", "position", "shape")), rep(Inf, 4))

  # both empty
  res = diss_KL(x, y, h_range = c(5, 6))
  expect_equal(comps(res, c("kl", "volume", "position", "Lambda_x", "Lambda_y", "kl_sym")), rep(0, 6))
  expect_true(is.na(res$shape) && is.na(res$reverse$shape))
})

test_that("default is finite for adms of different extent", {
  x = tp_to_adm(t = c(0, 1), h = c(0, 1))
  y = tp_to_adm(t = c(0, 2, 3), h = c(0, 1, 2))
  expect_true(is.finite(diss_KL(y, x)[["kl"]]))
})

test_that("invalid inputs are rejected", {
  x = tp_to_adm(t = 1:3, h = 1:3, T_unit = "Myr", L_unit = "m")
  y = tp_to_adm(t = 1:3, h = 1:3, T_unit = "kyr", L_unit = "m")
  expect_error(diss_KL(x, y))
  expect_error(diss_KL(x, x, rate = 0))
  expect_error(diss_KL(x, x, rate = c(1, 2)))
  expect_error(diss_KL(x, x, h_range = c(2, 2)))
  expect_error(diss_KL(x, list()))
  expect_error(diss_KL(x, tp_to_adm(t = 1:2, h = 5:6, T_unit = "Myr", L_unit = "m")))
})

test_that("shape, reverse and symmetrized divergences are consistent", {
  x = tp_to_adm(t = c(0, 1, 3, 4, 6), h = c(0, 1, 1, 1.5, 2))
  y = tp_to_adm(t = c(0, 2, 5), h = c(0, 1, 2))
  fwd = diss_KL(x, y)
  bwd = diss_KL(y, x)
  # shape is KL of normalized densities: p_x = (1/4, 2/4, 4/4) on widths (1, 0.5, 0.5), p_y = (2/5, 3/5, 3/5)
  px = c(1, 2, 4) / 4
  py = c(2, 3, 3) / 5
  w = c(1, 0.5, 0.5)
  expect_equal(fwd$shape, sum(w * px * log(px / py)))
  expect_equal(fwd$position, fwd$Lambda_x * fwd$shape)
  # reverse direction
  expect_equal(fwd$kl_reverse, bwd$kl)
  expect_equal(fwd$reverse, bwd[c("kl", "volume", "position", "shape")])
  # Jeffreys divergence: int (lx - ly) log(lx / ly)
  lx = c(1, 2, 4)
  ly = c(2, 3, 3)
  expect_equal(fwd$kl_sym, sum(w * (lx - ly) * log(lx / ly)))
  expect_equal(fwd$kl_sym, bwd$kl_sym)
})

test_that("S3 class, print and summary work", {
  x = tp_to_adm(t = c(0, 1, 3, 4, 6), h = c(0, 1, 1, 1.5, 2), T_unit = "Myr", L_unit = "m")
  y = tp_to_adm(t = c(0, 2, 5), h = c(0, 1, 2), T_unit = "Myr", L_unit = "m")
  res = diss_KL(x, y)
  expect_s3_class(res, "diss_KL")
  expect_equal(res$h_range, c(0, 2))
  expect_equal(res$T_unit, "Myr")
  expect_output(print(res), "kl_sym")
  expect_output(expect_invisible(print(res)), "position")

  s = summary(res)
  expect_s3_class(s, "summary.diss_KL")
  expect_equal(s$table["kl", "x_from_y"], res$kl)
  expect_equal(s$table["kl", "y_from_x"], res$kl_reverse)
  expect_equal(s$table["volume_share", "x_from_y"] + s$table["position_share", "x_from_y"], 1)
  expect_output(print(s), "Myr")
  expect_output(print(s), "Symmetrized")

  # shares are NA for zero or infinite divergences, units may be missing
  a = tp_to_adm(t = c(0, 1), h = c(0, 1))
  b = tp_to_adm(t = c(0, 2, 3), h = c(0, 1, 2))
  s = summary(diss_KL(b, a, h_range = c(0, 2)))
  expect_true(is.na(s$table["volume_share", "x_from_y"]))
  expect_output(print(s), "time unit")
  s = summary(diss_KL(a, a))
  expect_true(is.na(s$table["position_share", "x_from_y"]))
})
