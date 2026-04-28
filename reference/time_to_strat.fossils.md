# transform `fossils` from FossilSim from time to strat domain

The `fossils` object of the `FossilSim` package describe the location of
fossil occurrences along a phylogeny. This function transforms the
objects from the time to the stratigraphic domain.

## Usage

``` r
# S3 method for class 'fossils'
time_to_strat(obj, x, ...)
```

## Arguments

- obj:

  the fossils object

- x:

  the age-depth model to be used, and *adm* object

- ...:

  further parameters to be passed to `to_height`, e.g., `is_destructive`

## Value

a `fossils` object for usage with the `FossilSim` package
