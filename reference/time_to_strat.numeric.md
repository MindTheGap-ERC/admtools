# transform vectors from time to height domain

This function transforms numeric vectors from the time to the
stratigraphic domain Fundamentally a wrapper around get_height for
consistent syntax

## Usage

``` r
# S3 method for class 'numeric'
time_to_strat(obj, x, ...)
```

## Arguments

- obj:

  a numeric vector, interpreted as timing of events

- x:

  an *adm* object

- ...:

  options passed to *get_height*

## Value

a numeric vector - stratigraphic position of the events

## See also

[`strat_to_time.numeric()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.numeric.md)
for the transformation from height to time domain,
[`time_to_strat.phylo()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.phylo.md)
and
[`time_to_strat.list()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.list.md)
for transformations of phylogenetic trees and lists. See
[`get_height()`](https://mindthegap-erc.github.io/admtools/reference/get_height.md)
for the underlying procedure.

## Examples

``` r
# see vignette("admtools") for an example
```
