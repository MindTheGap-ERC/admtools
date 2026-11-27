# admtools (development version)

* new function `diss_dating_error` to quantify the error when events placed in the section by one age-depth model are dated with another: mean absolute error, RMS error with its decomposition into mean error and variance, and the effective time interval

* new function `diss_KL` to quantify how differently two age-depth models distribute time over the section, via a KL divergence split into a volume component (how much time is preserved) and a position component (where it is preserved)

* new function `diss_age_offset` to quantify the age offset between two age-depth models: mean absolute offset, RMS offset with its decomposition into mean offset and variance, and the stratigraphic interval

* `diss_age_offset`, `diss_dating_error`, and `diss_KL` return S3 objects with `print` and `summary` methods

* bugfix for `get_time`: times in sections adjacent to hiatuses were interpolated incorrectly, so `strat_to_time` and `time_to_strat` were not inverses of each other (#37)

# admtools 0.7.0

* transfer maintainer role from Niklas Hohmann to Emilia Jarochowska

* bugfix for `strat_to_time.fossils`

# admtools 0.6.0

* transformation between age and time for integration with `FossilSim`

* vignette for connection between `admtools` and `FossilSim`

# admtools 0.5.0

* new helper functions for estimation of age-depth models

* basic functionality for depth-depth models

* integration with the `FossilSim` package, specifically transformation of `taxonomy` and `fossils` objects between time and stratigraphic domain

# admtools 0.4.0

* added transformations for S3 class `pre_paleoTS` to integrate with `StratPal` and `paleoTS` package

* added anchoring of age-depth models via `anchor`

# admtools 0.3.1

* more options for sedimentation rate generator `sed_rate_from_matrix`

* abstracted extraction of tie points

* added utility functions for S3 class `sac`

# admtools 0.3.0

* removed dependency from `ape` package

* defined S3 class `timelist` and `stratlist` for data associated with time/height

* unified syntax for time-depth transformation

* add CONTRIBUTING.md

# admtools 0.2.0

* expanded documentation of defined S3 classes

* added S3 class `sac` for sediment accumulation curves

* methods for objects of class `phylo` and `list`

* expanded estimation procedures to multiple tie points

* improved plotting

* estimation of sedimentation rates

# admtools 0.1.0

* Updated vignettes

* Added generics `time_to_strat` and `strat_to_time` to transform objects between time and stratigraphic domain

* Added package help

# admtools 0.0.1

* Initial release
