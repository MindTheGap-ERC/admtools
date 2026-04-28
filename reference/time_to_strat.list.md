# transform list from time to height domain

Lists are useful to keep data closely associated. This function
transforms a list that contains observations associated with a time
(recorded in the element with name "t") into a list where the
observations are associated with stratigraphic position.

## Usage

``` r
# S3 method for class 'list'
time_to_strat(obj, x, ...)
```

## Arguments

- obj:

  a list with one element named "t", which will be interpreted as time

- x:

  an *adm* object

- ...:

  options passed to *get_height*

## Value

a `stratlist` (inherits from `list`): A list with one named element "h"
instead of the element "t", containing the stratigraphic positions
corresponding to the times inf "t"

## See also

[`strat_to_time.list()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.list.md)
for the transformation from height to time domain,
[`time_to_strat.phylo()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.phylo.md)
and
[`time_to_strat.numeric()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.numeric.md)
for transformations of phylogenetic trees and vectors. See
[`get_height()`](https://mindthegap-erc.github.io/admtools/reference/get_height.md)
for the underlying procedure.

## Examples

``` r
# see vignette("admtools") for an example
```
