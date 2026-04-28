# get no. of hiatuses

Determines the number of hiatuses in an age-depth model

## Usage

``` r
get_hiat_no(x)
```

## Arguments

- x:

  an adm object

## Value

An integer, no. of hiatuses in the age-depth model

## See also

- [`get_hiat_pos()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_pos.md)
  to determine stratigraphic positions of hiatuses

- [`get_hiat_list()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_list.md)
  to determine position and timing of hiatuses

- [`get_hiat_duration()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_duration.md)
  to determine duration of hiatuses

## Examples

``` r
my_adm = tp_to_adm(t = 1:4, h = c(1,2,2,3)) # one hiatus
get_hiat_no(my_adm)
#> [1] 1


```
