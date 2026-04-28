# transform objects from time domain to strat. domain

Takes an object and transforms it from the time domain into the
stratigraphic domain using the provided age-depth model. Currently
implemented for the "phylo", "list", and "numeric" class.

## Usage

``` r
time_to_strat(obj, x, ...)
```

## Arguments

- obj:

  the object to be transformed

- x:

  age-depth model for the transformation

- ...:

  other parameters

## Value

an object of the same type as obj

## See also

[`strat_to_time()`](https://mindthegap-erc.github.io/admtools/reference/strat_to_time.md)
to transform data from the stratigraphic domain to the time domain,
[`time_to_strat.phylo()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.phylo.md),
[`time_to_strat.numeric()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.numeric.md)
and
[`time_to_strat.list()`](https://mindthegap-erc.github.io/admtools/reference/time_to_strat.list.md)
for details on how to transform phylo objects, vectors, and lists. See
[`get_height()`](https://mindthegap-erc.github.io/admtools/reference/get_height.md)
for the underlying procedure.
