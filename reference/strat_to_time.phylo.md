# transform phylo object

transform phylo object from the stratigraphic domain to the time domain

## Usage

``` r
# S3 method for class 'phylo'
strat_to_time(obj, x, ...)
```

## Arguments

- obj:

  the phylo object to be transformed

- x:

  age-depth model

- ...:

  parameters passed to get_time

## Value

a phylo object, representation of the tree in the time domain

## See also

[`get_time()`](https://mindthegap-erc.github.io/admtools/reference/get_time.md)
for the underlying procedure,
[`strat_to_time()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.md)
for the higher level function, and
[`time_to_strat.phylo()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.phylo.md)
for the transformation of phylo objects from the time to the strat
domain.
