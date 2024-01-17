test_that("basic sac generation works", {
  sac = tp_to_sac(t = 1:3, h = 2:4)
  expect_s3_class(sac,"sac")
})
