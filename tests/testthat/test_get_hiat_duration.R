test_that("Correct response for no hiatuses", {
  adm = tp_2_adm(t = c(1,2), h = c(1,2))
  expect_length(get_hiat_duration(adm), 0)
  expect_true(inherits(get_hiat_duration(adm), "numeric"))
})

test_that("Correct answer for 1 hiatus", {
  adm = tp_2_adm(t = 1:4, h = c(1,2,2,3))
  
  expect_equal(get_hiat_duration(adm), 1)
  # start with hiatus
  adm = tp_2_adm(t = 1:4, h = c(1,1,2,3))
  hiat_li = get_hiat_list(adm)
  expect_equal(get_hiat_duration(adm), 1)
  
  # end with hiatus
  adm = tp_2_adm(t = 1:4, h = c(1,2,3,3))
  hiat_li = get_hiat_list(adm)
  expect_equal(get_hiat_duration(adm), 1)
})


test_that("Hiatuses with multiple tie points", {
  adm = tp_2_adm(t = 1:5, h = c(1,2,2,2,3))
  expect_equal(get_hiat_duration(adm), 2)
})

test_that("Correct answer for multiple hiatuses", {
  h = c(1,1,2,2,3,3)
  t = 1:6
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_hiat_duration(adm), c(1,1,1))
})
