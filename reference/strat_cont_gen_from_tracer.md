# proxy values in strat domain

Generates a function factory for usage with *strat_cont_to_multiadm*
based on empirical tracer measurements in the section

## Usage

``` r
strat_cont_gen_from_tracer(
  bin_borders,
  df,
  distribution = "normal",
  cap = TRUE,
  cap_val = 0
)
```

## Arguments

- bin_borders:

  borders of sampling bins

- df:

  data frame with proxy records

- distribution:

  character, currently only "normal" implemented. Specifies the
  distribution of proxies

- cap:

  logical. Should values below `cap_val`be replaced?

- cap_val:

  numeric. If `cap = TRUE`, values below `cap_val`will be replaced by
  `cap_val`

## Value

a functional for usage with strat_cont_to_multiadm

## See also

[`flux_const()`](https://mindthegap-erc.github.io/admtools/reference/flux_const.md),
[`flux_linear()`](https://mindthegap-erc.github.io/admtools/reference/flux_linear.md),
[`flux_quad()`](https://mindthegap-erc.github.io/admtools/reference/flux_quad.md)
to define tracer fluxes

## Examples

``` r
if (FALSE) { # \dontrun{
# see this vignette for a use case
vignette("adm_from_trace_cont")
} # }
```
