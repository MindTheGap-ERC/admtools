# transform `taxomony` from time to strat domain

transforms `taxonomy` objects from time to strat domain. Ignored the
`destructive` argument of *get_height*, which is automatically set to
FALSE

## Usage

``` r
# S3 method for class 'taxonomy'
time_to_strat(obj, x, ...)
```

## Arguments

- obj:

  a `taxonomy` object used by `FossilSim`

- x:

  an age-depth model object

- ...:

  further parameters passed to `get_height`, e.g., *is_destructive*
