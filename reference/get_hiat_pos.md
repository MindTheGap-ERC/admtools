# get hiatus positions

Determines stratigraphic position of hiatuses

## Usage

``` r
get_hiat_pos(x)
```

## Arguments

- x:

  an adm object

## Value

numeric vector with stratigraphic positions of hiatuses

## See also

- [`get_hiat_list()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_list.md)
  to get hiatus positions and durations

- [`get_hiat_no()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_no.md)
  to determine number of hiatuses

- [`get_hiat_duration()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_duration.md)
  to determine duration of hiatuses

## Examples

``` r
my_adm = tp_to_adm(t = 1:4, h = c(1,2,2,3)) # one hiatus at height 2
get_hiat_pos(my_adm)
#> [1] 2
```
