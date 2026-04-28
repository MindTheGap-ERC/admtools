# transform phylo object

transform phylo object from the time domain to the stratigraphic domain

## Usage

``` r
# S3 method for class 'phylo'
time_to_strat(obj, x, ...)
```

## Arguments

- obj:

  the phylo object to be transformed

- x:

  age-depth model

- ...:

  other parameters, currently ignored

## Value

a phylo object, representation of the tree in the strat domain

## See also

[`get_height()`](https://mindthegap-erc.github.io/admtools/reference/get_height.md)
for the underlying procedure,
[`time_to_strat()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.md)
for the higher level function, and
[`strat_to_time.phylo()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.phylo.md)
for the transformation of phylo objects from strat domain to the time
domain. See
[`time_to_strat.list()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.list.md)
and
[`time_to_strat.numeric()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.numeric.md)
for the transformation of lists and numeric vectors
