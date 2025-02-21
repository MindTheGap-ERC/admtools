test_that(" for phylo objects, tree topology is unaffected by transformation",
          {
            adm = tp_to_adm(t = c(0,1,2), h = c(0,2,3))
            set.seed(1)
            tree = ape::rlineage(birth = 1,
                                 death = 0.1,
                                 Tmax = 2)
            
            tree_trans = time_to_strat(obj = tree,
                                       x = adm)
            
            expect_equal(tree$edge, tree_trans$edge)
            expect_equal(tree$tip.label, tree_trans$tip.label)
            expect_equal(tree$Nnode, tree_trans$Nnode)
            
          })

test_that("transformation of lists works", {
  t = 1:3
  h = 4:6
  adm = tp_to_adm(t,h)
  li = list("t" = t, "r" = "a")
  expect_equal(time_to_strat(li, adm)$h, h)
})

test_that("transformation for fossils objects works", {
  # check class is preserved
  # object is preserved under identity
})

test_that("transformation for taxonomy objects works", {
  # check class is preserved
  # object is preserved under identity transformation
})
