test_that("height interpolation at tie points returns tie points", {
  t = 1:3
  h = 2:4
  adm = tp_2_adm(t = t, h = h)
  expect_equal(get_time(adm = adm, h = h), t)
})

t = 1:3
h = c(2,2,4)
adm = tp_2_adm(t = t, h = h)

plot(adm)

get_time(adm = adm, h = 2.1)
