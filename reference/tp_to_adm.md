# Construct age-depth model from tie points

Turns tie points into an `adm` object that represents an age-depth model

## Usage

``` r
tp_to_adm(t, h, T_unit = NULL, L_unit = NULL)
```

## Arguments

- t:

  Vector, tie points in time

- h:

  Vector, tie points in height

- T_unit:

  character, time unit

- L_unit:

  character, length unit

## Value

object of class `adm`

## Details

by default, intervals with no sediment accumulation are marked as
destructive. `tp_to_adm` does not check whether the inputs define a
valid age-depth model. For this, use `is_adm`

## See also

[`is_adm()`](https://mindthegap-erc.github.io/admtools/reference/is_adm.md)
to check validity of `adm` objects,
[`get_T_tp()`](https://mindthegap-erc.github.io/admtools/reference/get_T_tp.md)
and
[`get_L_tp()`](https://mindthegap-erc.github.io/admtools/reference/get_L_tp.md)
to extract time and height/length tie points

## Examples

``` r
my_adm = tp_to_adm(t = 1:4, h = c(1,2,2,3), T_unit = "kyr", L_unit = "m")
plot(my_adm)

# see vignette("admtools") for other examples

 
```
