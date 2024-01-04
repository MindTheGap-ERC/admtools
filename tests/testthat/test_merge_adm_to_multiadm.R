test_that("Produces multiadm object",{
  adm1 = tp_to_adm(t = 1:3, h = 2:4)
  adm2 = tp_to_adm(t = 1:3, h = 2:5)
  multiadm = merge_adm_to_multiadm(adm1, adm2)
  expect_true(is_multiadm(multiadm))
})

test_that("Inconsistent time units throw error", {
  adm1 = tp_to_adm(t = 1:3, h = 2:4, T_unit = "cats")
  adm2 = tp_to_adm(t = 1:3, h = 2:5, T_unit = "dogs")
  expect_error(merge_adm_to_multiadm(adm1, adm2))
  
})

test_that("Inconsistent length units throw error", {
  adm1 = tp_to_adm(t = 1:3, h = 2:4, L_unit = "cats")
  adm2 = tp_to_adm(t = 1:3, h = 2:5, L_unit = "dogs")
  expect_error(merge_adm_to_multiadm(adm1, adm2))
  
})
