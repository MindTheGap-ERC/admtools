test_that("correct sed rate is returned between TPs",{
  adm = tp_to_adm(t = c(1,2), h = c(1,2))
  expect_equal(sed_rate_t(adm,1.5),1)
})

test_that("right and left continuity is correct",{
  adm = tp_to_adm(t = c(1:4), h = c(1,2,2,3))
  expect_equal(sed_rate_l(adm,2, mode = "rcll"), 0)
  expect_equal(sed_rate_l(adm,2, mode = "lcrl"), 1)
})
  