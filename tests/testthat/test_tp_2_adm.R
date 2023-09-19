test_that("basic adm generation works", {
  adm = tp_2_adm(t = 1:3, h = 2:4)
  expect_s3_class(adm,"adm")
})




