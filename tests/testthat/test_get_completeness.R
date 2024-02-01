test_that("Completeness of 1 for continuous accumulation", {
  t = 1:3
  h = 2:4
  adm = tp_to_adm(t = t, h = h )
  expect_equal( get_completeness(adm), 1)
  expect_equal(get_incompleteness(adm), 0)
})

test_that("Completeness of 0.5 for accumulation half of time", {
  t = 1:3
  h = c(2,2,3)
  adm = tp_to_adm(t = t, h = h)
  expect_equal( get_completeness( adm), 0.5)
  expect_equal( get_incompleteness( adm), 0.5)
})

test_that("Completeness of 1?3 for accumulation half of time", {
  t = 1:4
  h = c(2,2,3,4)
  adm = tp_to_adm(t = t, h = h)
  expect_equal( get_completeness( adm), 2/3)
  expect_equal( get_incompleteness( adm), 1/3)
})

test_that("Completeness of 0 for non-accumulation", {
  t = 1:3
  h = c(2,2,2)
  adm = tp_to_adm(t = t, h = h)
  expect_equal( get_completeness( adm), 0)
  expect_equal( get_incompleteness( adm), 1)
})
