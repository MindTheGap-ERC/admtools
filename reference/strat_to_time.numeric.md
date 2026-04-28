# transform numeric vectors from height to time domain

This function transforms numeric vectors from the stratigraphic to the
time domain Fundamentally a wrapper around get_time for consistent
syntax

## Usage

``` r
# S3 method for class 'numeric'
strat_to_time(obj, x, ...)
```

## Arguments

- obj:

  a numeric vector representing stratigraphic positions.

- x:

  an *adm* object

- ...:

  options passed to `get_time`

## Value

A numeric vector with times of deposition of the entries in `obj`

## See also

[`time_to_strat.numeric()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.numeric.md)
for the transformation from time to height domain,
[`get_time()`](https://mindthegap-erc.github.io/admtools/reference/get_time.md)
for the underlying procedure,
[`time_to_strat()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.md)
for the higher level function,
[`strat_to_time.list()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.list.md)
and
[`strat_to_time.phylo()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.phylo.md)
for the transformation of lists and phylogenetic trees.

## Examples

``` r
# see vignette("admtools") for an example
```
