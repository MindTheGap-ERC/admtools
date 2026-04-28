# tie points for floating time scale

Defines tie points for a floating (auxiliary) time scale for usage with
*sedrate_to_multiadm* and *strat_cont_to_multiadm* as t_tp input. This
floating time scale consists of two tie points in time, the first at
time t = 0, the second at time t = 1. `tp_time_floating_scale` is a
synonym of `tp_time_det(times = c(0,1))`

## Usage

``` r
tp_time_floating_scale()
```

## Value

function for usage with *strat_cont_to_multiadm* and
*sedrate_to_multiamd* as t_tp input

## See also

[`tp_time_norm()`](https://mindthegap-erc.github.io/admtools/reference/tp_time_norm.md)
for tie points following a normal distribution,
[`tp_height_det()`](https://mindthegap-erc.github.io/admtools/reference/tp_height_det.md)
for deterministic height tie points

## Examples

``` r
if (FALSE) { # \dontrun{
# see this vignette for an example
vignette("adm_from_trace_cont")
} # } 
```
