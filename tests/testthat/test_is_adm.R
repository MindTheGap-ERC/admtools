test_that("Returns False for non adm objects",
          {
            expect_false(suppressWarnings(is_adm(2)))
          })

test_that("Requires all name fields",
          {
            # correct adm
            adm = tp_2_adm(t = 1:3, h = 2:4)
            expect_true(is_adm(adm))
            # incorrect number of name fields
            adm_mod = adm
            adm_mod[["a"]] = "foo"
            expect_false(suppressWarnings(is_adm(adm_mod)))
            # missing name field
            adm_mod = adm
            adm_mod[["T_unit"]] = NULL
            expect_false(suppressWarnings(is_adm(adm_mod)))
          })
