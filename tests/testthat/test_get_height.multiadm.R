test_that("Correct height values are returned", {
  a1 = tp_to_adm(t = c(1,2,3), h = c(1,2,3))
  a2 = tp_to_adm(t = c(1,2,3), h = c(1,2,3) - 0.2)
  ma = merge_adm_to_multiadm(a1,a2)
  li = get_height.multiadm(ma, 1:3)
  
  expect_equal(li, list(c(1,2,3), c(1,2,3) - 0.2))
  
})


