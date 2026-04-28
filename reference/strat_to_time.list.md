# transform list from height to time domain

Lists are useful to keep data closely associated. This function
transforms a list that contains observations associated with a
stratigraphic position (recorded in the element with name "h") into a
list where the observations are associated with time.

## Usage

``` r
# S3 method for class 'list'
strat_to_time(obj, x, ...)
```

## Arguments

- obj:

  a list with one element named "h", which will be interpreted as
  stratigraphic positions

- x:

  an *adm* object

- ...:

  options passed to `get_time`

## Value

a `timelist` (inherits from `list`). A list with one named element "t"
instead of the element "h". This element contains the times of the
stratigraphic positions in "h".

## See also

[`time_to_strat.list()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.list.md)
for the transformation from time to height domain,
[`get_time()`](https://mindthegap-erc.github.io/admtools/reference/get_time.md)
for the underlying procedure,
[`time_to_strat()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.md)
for the higher level function

## Examples

``` r
# see vignette("admtools") for an example
```
