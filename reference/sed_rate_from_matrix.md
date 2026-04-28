# make sed rate gen from matrix

Construct a sedimentation rate generator (function factory) from a
matrix, e.g. one returned from `get_data_from_eTimeOpt`. This generator
can be passed on to `sedrate_to_multiadm` to estimate age-depth models
from it. If mode is "deterministic", the generator evaluates the
sedimentation rates at heights specified by `height`, if the mode is
"poisson" it is evaluated at heights that are determined based on a
poisson point process. At these heights, the value of the sedimentation
rate is determined based on the (pseudo) pdf that is determined by the
matrix values.

## Usage

``` r
sed_rate_from_matrix(
  height,
  sedrate,
  matrix,
  mode = "deterministic",
  rate = 1,
  expand_domain = TRUE,
  transform = identity
)
```

## Arguments

- height:

  vector of heights

- sedrate:

  vector of sed. rates x values

- matrix:

  matrix of sed rate y values. Must have as many columns as
  length(height) and as many rows as length(sedrate).

- mode:

  character, "deterministic" or "poisson". Determines at which
  stratigraphic heights the sed rate is determined. If "deterministic"
  this will be the heights in `height`, if "poisson" the heights where
  the sed rate is determined follows a poisson point process with rate
  specified by `rate`

- rate:

  numeric, rate of the Poisson point process determining frequency of
  sedimentation rate changes.

- expand_domain:

  should sedimentation rates be defined below/above the highest/lowest
  height in the section? If TRUE, the sed rate values are the values at
  the closest interpolated point, if FALSE it will be NA

- transform:

  a function, the identity function by default. How should the values of
  the (pseudo)pdf defined by the entries of `matrix` be transformed?
  Using this function allows to (nonlinearly) rescale the values in
  matrix to put more emphasis on higher/lower values

## Value

a function factory for usage with `sedrate_to_multiadm`

## See also

[`sedrate_to_multiadm()`](https://mindthegap-erc.github.io/admtools/reference/sedrate_to_multiadm.md)
for estimating sedimentation rates based on the outputs,
[`get_data_from_eTimeOpt()`](https://mindthegap-erc.github.io/admtools/reference/get_data_from_eTimeOpt.md)
for extracting data from the `eTimeOpt` function of the astrochron
package.
[`sed_rate_gen_from_bounds()`](https://mindthegap-erc.github.io/admtools/reference/sed_rate_gen_from_bounds.md)
for construction sedimentation rate generators from simple bounds. See
also the vignettes for details on how arbitrary sedimentation rates can
be constructed.

## Examples

``` r
# see vignette 
# vignette("adm_from_sedrate")
# for more general examples
```
