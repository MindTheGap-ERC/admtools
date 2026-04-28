# time tie points with normal distribution

defines a function factory that returns normally distributed times. FOr
usage with `sedrate_to_multiadm` and `strat_cont_to_multiadm`.

## Usage

``` r
tp_time_norm(mean, sd, force_order = TRUE)
```

## Arguments

- mean:

  numeric vector, mean age of tie points

- sd:

  numeric vector, standard deviation of tie points

- force_order:

  logical, enforce strictly increasing times

## Value

function for usage with *strat_cont_to_multiadm* and
*sedrate_to_multiamd* as t_tp input

## See also

[`tp_time_floating_scale()`](https://mindthegap-erc.github.io/admtools/reference/tp_time_floating_scale.md)
for tie points for a floating scale,
[`tp_height_det()`](https://mindthegap-erc.github.io/admtools/reference/tp_height_det.md)
for deterministic height tie points
