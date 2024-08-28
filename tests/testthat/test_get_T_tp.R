test_that("correct times are returned",{
  h = 1:4
  t = 1:4
  adm = tp_to_adm(t, h)
  expect_equal(get_T_tp(adm), t)
  
  h = rev(h)
  sac = tp_to_sac(t, h)
  expect_equal(get_T_tp(sac), t)
})
