# Specifications for Age-Depth-Model Data Format & Class

This document specifies the properties that an age-depth model (adm) data structure and class/object should have. Everything listed here is preliminary and up for discussion, nothing is set in stone.

## Use Cases  

The adm should be usable in the following ways  

1. Store adms (archivability)
2. Exchange adms between different platforms (interoperability)  
3. Transform data between time and depth domain  

## Archivability & interoperability

A file format for individual adms will be defined based on .txt with added structure. These files wil be human radable and can be read into different software. The format will be modeled after NEXUS (see [Wikipedia](https://en.wikipedia.org/wiki/Nexus_file) and  [Maddison et al. 1997](https://doi.org/10.1093/sysbio%2F46.4.590)).

## Transformation

Adms should be able to transform data. The following data should be transformed (with increasing complexity):

* Time points -> stratigraphic positions
* Stratigraphic positions -> time points
* Time / stratigraphic series -> stratigraphic / time series
* Phylogenetic trees
* Functions generating time / stratigraphic series (e.g. simulations of Brownian motion)
* Probability densities & rates (see [Hohmann 2021](https://doi.org/10.2110/palo.2020.038))

## Uncertainty

No information on uncertainty will be stored with an individual adm (deterministic adm). A data structure combining multiple adms will be used to account for uncertainty and store outputs of Bayesian analyses (similar to the [multiPhylo class](https://rdrr.io/cran/ape/man/multiphylo.html) in the R package "ape" ).