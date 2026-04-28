# seg rate gen from upper/lower bounds

constructs a sedimentation rate generator for usage with
`sedrate_to_multiadm` based on the following procedure: (1) determine
stratigraphic points based on a Poisson point process with rate `rate`
(2) at these points, determine the sedimentation rate based on a uniform
distribution between the bounds provided by the input parameters (3)
linearly interpolate between those points with sedimentation rate
determined in step 2. This approach can be used to estimate age-depth
models when only rough boundaries on sedimentation rates are available.
Here, the uniform distribution is chosen to reflect that no other
information other than maximum and minimum sed. rate is available.

## Usage

``` r
sed_rate_gen_from_bounds(h_l, s_l, h_u, s_u, rate = 1)
```

## Arguments

- h_l:

  height values for lower bounds

- s_l:

  sed rate values for lower bounds

- h_u:

  height values for upper bounds

- s_u:

  sed rate values for upper bounds

- rate:

  rate of poisson point process

## Value

a function factory for usage with `sedrate_to_multiadm`

## See also

- [`sedrate_to_multiadm()`](https://mindthegap-erc.github.io/admtools/reference/sedrate_to_multiadm.md)
  for estimating age-depth models using the outputs

- [`sed_rate_from_matrix()`](https://mindthegap-erc.github.io/admtools/reference/sed_rate_from_matrix.md)
  for other means of defining sedimentation rates

- [`sed_rate_gen_gamma()`](https://mindthegap-erc.github.io/admtools/reference/sed_rate_gen_gamma.md)
  for sed. rate generator based on a gamma distribution

[`sedrate_to_multiadm()`](https://mindthegap-erc.github.io/admtools/reference/sedrate_to_multiadm.md)
for estimating age-depth models using the outputs,
[`sed_rate_from_matrix()`](https://mindthegap-erc.github.io/admtools/reference/sed_rate_from_matrix.md)
for other means of defining sedimentation rates, the vignette on how to
construct arbitrary sedimentation rate generators.

## Examples

``` r
# see vignette 
# vignette("adm_from_sedrate")
# for an example
```
