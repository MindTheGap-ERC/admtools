# Estimate age-depth model from sedimentation rates & tie points

Combines information on tie points and sedimentation rates to estimate
age-depth models and their associated uncertainty. For an example, see
[`vignette("adm_from_sedrate")`](https://mindthegap-erc.github.io/admtools/articles/adm_from_sedrate.md).

## Usage

``` r
sedrate_to_multiadm(
  h_tp,
  t_tp,
  sed_rate_gen,
  h,
  no_of_rep = 100L,
  subdivisions = 100L,
  stop.on.error = TRUE,
  T_unit = NULL,
  L_unit = NULL
)
```

## Arguments

- h_tp:

  : function, returns stratigraphic positions of tie points

- t_tp:

  : function, returns times of tie points

- sed_rate_gen:

  : function, returns function describing sedimentation rate

- h:

  : numeric, heights where the adm is calculated

- no_of_rep:

  : integer, number of repetitions

- subdivisions:

  maximum no of subintervals used in numeric integration. passed to
  *integrate*, see ?stats::integrate for details

- stop.on.error:

  logical passed to *integrate*, see ?stats::integrate for details

- T_unit:

  time unit

- L_unit:

  length unit

## Value

object of class multiadm

## Examples

``` r
if (FALSE) { # \dontrun{
# see this vignette for an example
vignette("adm_from_sedrate")
} # }
```
