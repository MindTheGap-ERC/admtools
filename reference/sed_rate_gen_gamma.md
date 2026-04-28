# sed. rate gen based on gamma distribution

generates a function factory for usage with `sedrate_to_multiadm`. At
`h[i]`, the sedimentation rate is given by a gamma distribution with
parameters `shapes[i]` and `rates[i]`. Between those values,
sedimentation rate is linearly interpolated Outside of the range of `h`,
behavior is determined by the argument `rule` which is passed to
`approxfun`. See there for details.

## Usage

``` r
sed_rate_gen_gamma(h, shapes, rates, rule = 1)
```

## Arguments

- h:

  heights at which sedimentation rate is determined

- shapes:

  shape parameters for the gamma distribution

- rates:

  rate parameter for the gamma distribution

- rule:

  an integer of length 1 or 2, see description for details

## Value

a function factory for usage with `sedrate_to_multiadm`

## See also

- [`sedrate_to_multiadm()`](https://mindthegap-erc.github.io/admtools/reference/sedrate_to_multiadm.md)
  for estimating age-depth models using the outputs

- [`sed_rate_from_matrix()`](https://mindthegap-erc.github.io/admtools/reference/sed_rate_from_matrix.md)
  for other means of defining sedimentation rates

- [`sed_rate_gen_from_bounds()`](https://mindthegap-erc.github.io/admtools/reference/sed_rate_gen_from_bounds.md)
  for sed. rate generator based on bounds on sedimentation rates.
