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

No information on uncertainty will be stored with an individual adm. A data structure combining multiple adms will be used to account for uncertainty and store outputs of Bayesian analyses (similar to the [multiPhylo class](https://rdrr.io/cran/ape/man/multiphylo.html) in the R package "ape").  
This is because uncertainties in ADMs require assumption on the (in)dependence of uncertainties and tie points (e.g. to resolve age inversions). They can be difficult to make explicit, and require a separate discussion. Here, we rather focus on deterministic ADMs, which can be understood as realizations (see [Wikipedia](https://en.wikipedia.org/wiki/Realization_(probability)) ) of ADMs with uncertainty.

## Empirical Aspects

The adms should be able to hold information on hiatuses, ommission intervals (zero sediment input), and times with removal of sediment (negative sediment accumulation) including the resulting hiatuses.
No information on the results of sediment mixing (time avaraging, stratigraphic disorder, different age distribution of particles of different sizes at the same location) will be included.

## Construction

Basic adm objects will be constructed from

* Tie points
* Sedimentation rates
* Condensation rates (dimension T/L, time per increment sediment)
* Other ADM formats used by the community

## Modification

ADMs will be modified in the following ways:

* Linear resacling. This includes

    1. adjusting the first / last time point
    2. adjusting highest / lowest stratigraphic position
    3. lengthening / shortening the time interval covered
    4. increasing / decreasing the total thickness
* Insertion of Hiatuses
* Concatenation of ADMs
* Removing parts of an ADM
* (Insertion of ommission surfaces)
* (Insertion of ADMs into other ADMs)

## Extraction

The following information can be extracted from ADMs:

* Time of deposition of a stratigraphic position
* Stratigraphic position deposited at a given time
* Hiatuses (stratigraphic position & time intervals)
* Omission surfaces (stratigraphic position & time intervals)
* Intervals of erosion
* Sedimentation rates (instantaneous & over a prescribed thickness / time interval)
* Condensation (instantaneous & over a prescribed thickness / time interval)

## Depth vs. Height, Time vs. Age, and Units

ADMs can be considered coordinate transformation between the time domain (T dimension) and the depth domain (L dimension). Different communities use different conventions on the directionality of these dimensions. Historical disciplines use age as T dimension, whereas modelers use time, while the L dimension is depth for cores and height for outcrops. The ADM object will accomodate all such combinations (age-depth, time-depth, age-height, time-height).  
Physical units (e.g. _m_, _dm_, _cm_ for T, _a_, _kyr_, _Myr_ for L) can be associated with the ADM if wanted.
