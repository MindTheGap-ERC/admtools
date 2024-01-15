test_that("Setting and getting of T unit for adm works", {
  T_unit = "cats"
  adm = tp_to_adm(t = 1:3, h = 1:3)
  expect_equal(get_T_unit(set_T_unit(x = adm, T_unit = T_unit)), T_unit)
  adm = tp_to_adm(t = 1:3, h = 1:3, T_unit = T_unit)
  expect_equal(get_T_unit(adm), T_unit)
  
})

test_that("Setting and getting of L unit for adm works", {
  L_unit = "dogs"
  adm = tp_to_adm(t = 1:3, h = 1:3)
  expect_equal(get_L_unit(set_L_unit(x = adm, L_unit = L_unit)), L_unit)
  adm = tp_to_adm(t = 1:3, h = 1:3, L_unit = L_unit)
  expect_equal(get_L_unit(adm), L_unit)
  
})

test_that("setting and getting of T unit for multiadm works", {
  T_unit = "cats"
  madm = merge_adm_to_multiadm(tp_to_adm(t = 1:3, h = 1:3))
  expect_equal(get_T_unit.multiadm(set_T_unit.multiadm(x = madm, T_unit = T_unit)), T_unit)
  madm = merge_adm_to_multiadm(tp_to_adm(t = 1:3, h = 1:3, T_unit = T_unit))
  madm$T_unit = T_unit
  expect_equal(get_T_unit(madm), T_unit)
  
})

test_that("setting and getting of L unit for multiadm works", {
  L_unit = "dogs"
  madm = merge_adm_to_multiadm(tp_to_adm(t = 1:3, h = 1:3))
  expect_equal(get_L_unit.multiadm(set_L_unit.multiadm(x = madm, L_unit = L_unit)), L_unit)
  madm = merge_adm_to_multiadm(tp_to_adm(t = 1:3, h = 1:3, L_unit = L_unit))
  madm$L_unit = L_unit
  expect_equal(get_L_unit(madm), L_unit)
  
})
