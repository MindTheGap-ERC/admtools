test_that("Completeness of 1 for continuous accumulation", {
  t = 1:3
  h = 2:4
  adm = tp_2_adm(t = t, h = h )
  expect_equal( get_completeness(adm = adm), 1)
})

test_that("Completeness of 0.5 for accumulation half of time", {
  t = 1:3
  h = c(2,2,3)
  adm = tp_2_adm(t = t, h = h)
  expect_equal( get_completeness(adm = adm), 0.5)
})

test_that("Completeness of 0 for non-accumulation", {
  t = 1:3
  h = c(2,2,2)
  adm = tp_2_adm(t = t, h = h)
  expect_equal( get_completeness(adm = adm), 0)
})
