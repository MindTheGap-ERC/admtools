test_that("for phylo object, tree topology is unaffected by transformation",{
  adm = tp_to_adm(t = c(0,1,2), h = c(0,2,3))
  set.seed(1)
  tree = ape::rlineage(birth = 1,
                       death = 0.1,
                       Tmax = 2)
  
  tree_trans = strat_to_time(obj = tree,
                             x = adm)
  
  expect_equal(tree$edge, tree_trans$edge)
  expect_equal(tree$tip.label, tree_trans$tip.label)
  expect_equal(tree$Nnode, tree_trans$Nnode)
  
})

test_that("transformation of lists work",{
  t = 1:3
  h = 4:6
  adm = tp_to_adm(t,h)
  li = list("h" = h, "r" = "a")
  expect_equal(strat_to_time(li, adm)$t, t)
})

test_that("transformation for fossils objects works", {
  t = ape::rlineage(birth = 1, death = 0, Tmax = 1)
  rate = 2
  f = FossilSim::sim.fossils.poisson(rate = rate, tree = t)
  adm = tp_to_adm(t = c(0,1), h = c(0,1))
  expect_equal(strat_to_time(f, adm), f)
  expect_s3_class(strat_to_time(f, adm), "fossils")
})

test_that("transformation for taxonomy objects works", {
  t = ape::rlineage(birth = 1, death = 0, Tmax = 1)
  adm = tp_to_adm(t = c(0,1), h = c(0,1))
  s = FossilSim::sim.taxonomy(tree = t) 
  expect_equal(strat_to_time(s, adm), s)
  expect_s3_class(strat_to_time(s, adm), "taxonomy")
})


