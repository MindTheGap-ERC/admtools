test_that("conversion of sac to adm works", {
  t = 1:3
  h = 2:4
  sac = tp_to_sac(t = t, h = h)
  adm = sac_to_adm(sac)
  expect_equal(sac$t, adm$t)
  expect_equal(sac$t, adm$t)
})
