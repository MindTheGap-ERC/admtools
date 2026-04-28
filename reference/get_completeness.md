# Determine stratigraphic (in)completeness

Determine stratigraphic (in)completeness

## Usage

``` r
get_completeness(x)
get_incompleteness(x)
```

## Arguments

- x:

  an adm object

## Value

Number between 0 and 1, the stratigraphic (in)completeness

## Details

Stratigraphic (in)completeness is expressed as a proportion, i.e. a
number between 0 and 1

## Examples

``` r
my_adm = tp_to_adm(t = 1:4, h = c(1,2,2,4))
get_completeness(my_adm)
#> [1] 0.6666667
get_incompleteness(my_adm)
#> [1] 0.3333333
```
