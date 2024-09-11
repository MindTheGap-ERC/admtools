test_that("incorrect input for index paramter is caught", {
  t_anchor = function() rnorm(n = 1)
  x = tp_to_adm(c(0,1), c(0,1), "Myr", "m")
  expect_no_condition(anchor(x, index = "last", t_anchor, n = 10))
  expect_no_condition(anchor(x, index = "first", t_anchor, n = 10))
  expect_error(anchor(x, index = 2, t_anchor, n = 10))
})

test_that("incorrect input for t_anchor parameter is caught", {
  x = tp_to_adm(c(0,1), c(0,1), "Myr", "m")
  t_anchor = 2
  expect_error(anchor(x, "last", t_anchor, n = 10))
})
