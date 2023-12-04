test_that("Correct answer for adms with 0 hiatuses",{
  adm = tp_to_adm(t = c(1,2), h = c(1,2))
  expect_equal(length(get_hiat_pos(adm)),0)
})


test_that("Correct answer for 1 hiatus", {
  adm = tp_to_adm(t = 1:4, h = c(1,2,2,3))
  expect_equal(get_hiat_pos(adm), 2)
  # start with hiatus
  adm = tp_to_adm(t = 1:4, h = c(1,1,2,3))
  expect_equal(get_hiat_pos(adm), 1)
  # end with hiatus
  adm = tp_to_adm(t = 1:4, h = c(1,2,3,3))
  expect_equal(get_hiat_pos(adm), 3)
})

test_that("Hiatuses with multiple tie points are counted as one", {
  adm = tp_to_adm(t = 1:5, h = c(1,2,2,2,3))
  expect_equal(get_hiat_pos(adm), 2)
})

test_that("Correct answer for multiple hiatuses", {
  h = c(1,1,2,2,3,3)
  t = seq_along(h)
  adm = tp_to_adm(t = t, h = h)
  expect_equal(get_hiat_pos(adm), c(1,2,3))
})

