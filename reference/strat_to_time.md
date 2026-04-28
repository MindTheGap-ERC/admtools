# transform objects from strat. to time domain

Takes an object and transforms it from the time domain into the
stratigraphic domain using the provided age-depth model. Currently
implemented for the "phylo", "list", and "numeric" class. Wraps around
`get_time`.

## Usage

``` r
strat_to_time(obj, x, ...)
```

## Arguments

- obj:

  the object to be transformed

- x:

  age-depth model

- ...:

  other parameters

## Value

an object of the same type as obj

## See also

[`time_to_strat()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.md)
to transform data from the time to the stratigraphic domain,
[`strat_to_time.phylo()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.phylo.md),
[`strat_to_time.numeric()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.numeric.md)
and
[`strat_to_time.list()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.list.md)
for details on how to transform phylogenetic trees, vectors, and lists.
See
[`get_time()`](https://mindthegap-erc.github.io/admtools/reference/get_time.md)
for the underlying procedure.
