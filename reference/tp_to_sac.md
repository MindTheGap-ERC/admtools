# define sed. acc. curve

defines *sac* (sediment accumulation curve) object from tie points

## Usage

``` r
tp_to_sac(t, h, T_unit = NULL, L_unit = NULL)
```

## Arguments

- t:

  numeric vector, time coordinates of tie points

- h:

  numeric vector, height coordinates of tie points

- T_unit:

  time unit

- L_unit:

  length unit

## Value

a *sac* object reflecting a sediment accumulation curve

## See also

[`sac_to_adm()`](https://mindthegap-erc.github.io/admtools/reference/sac_to_adm.md)
to transform sediment accumulation curves into age-depth models,
[`get_T_tp()`](https://mindthegap-erc.github.io/admtools/reference/get_T_tp.md)
and
[`get_L_tp()`](https://mindthegap-erc.github.io/admtools/reference/get_L_tp.md)
to extract time and height/length tie points
