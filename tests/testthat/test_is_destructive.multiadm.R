test_that("Correct values are returned",{
  
  a1 = tp_to_adm(t = c(1,2,3,4), h = c(1,2,3,3))
  a2 = tp_to_adm(t = c(1,2,3,4), h = c(1,1,2,3))
  a3 = tp_to_adm(t = c(1,2,3,4), h = c(1,2,2,3))
  ma = merge_adm_to_multiadm(a1,a2,a3)
  li = is_destructive.multiadm(ma, c(1:3) + 0.5)
  
  expect_equal(li, list(c(FALSE, FALSE, TRUE), c(TRUE, FALSE, FALSE), c(FALSE, TRUE, FALSE)))
  
})
