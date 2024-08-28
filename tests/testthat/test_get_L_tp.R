test_that("correct heights are returned",{
  h = 1:4
  t = 1:4
  adm = tp_to_adm(t, h)
  expect_equal(get_L_tp(adm), h)
  
  h = rev(h)
  sac = tp_to_sac(t, h)
  expect_equal(get_L_tp(sac), h)
})
