test_that("interpolation at tie points returns tie points", {
  t = 1:3
  h = 2:4
  adm = tp_to_adm(t = t, h = h)
  expect_equal(get_height( adm, t = t), h)
})

test_that("Assignement of values outside of domain are correct", {
  t = 1:3
  h = 2:4
  adm = tp_to_adm(t = t, h = h)
  expect_equal(get_height( adm, t = c(0,4), out_dom_val_h = 5), c(5,5))
  expect_equal(get_height( adm, t = c(0,4), out_dom_val_h = c(1,10)), c(1,10))
  expect_true(is.na(get_height( adm, t = max(t) + 1, out_dom_val_h = "default")))
  expect_true(is.na(get_height( adm, t = min(t) - 1, out_dom_val_h = "default")))
  expect_equal(get_height( adm, t = max(t) + 1, out_dom_val_h = "strat_limits"), max(adm$h))
  expect_equal(get_height( adm, t = min(t) - 1, out_dom_val_h = "strat_limits"), min(adm$h))
})