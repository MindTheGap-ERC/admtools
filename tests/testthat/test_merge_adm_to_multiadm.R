test_that("Produces multiadm object",{
  adm1 = tp_2_adm(t = 1:3, h = 2:4)
  adm2 = tp_2_adm(t = 1:3, h = 2:5)
  multiadm = merge_adm_to_multiadm(adm1, adm2)
  expect_true(is_multiadm(multiadm))
})
