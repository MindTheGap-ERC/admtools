test_that("interpolation at tie points returns tie points", {
  t = 1:3
  h = 2:4
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_height(adm = adm, t = t), h)
})

test_that("Assignement of values outside of domain are correct", {
  t = 1:3
  h = 2:4
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_height(adm = adm, t = c(0,4), outside_domain = 5), c(5,5))
  expect_true(is.na(get_height(adm = adm, t = max(t) + 1, outside_domain = "default")))
  expect_true(is.na(get_height(adm = adm, t = min(t) - 1, outside_domain = "default")))
  expect_equal(get_height(adm = adm, t = max(t) + 1, outside_domain = "strat_limits"), max(adm$h))
  expect_equal(get_height(adm = adm, t = min(t) - 1, outside_domain = "strat_limits"), min(adm$h))
})


