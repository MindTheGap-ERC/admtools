# condensation function

returns a function that determines instantaneous condensation (time
preserved per strat. increment)

## Usage

``` r
condensation_fun(x, mode = "rcll", ...)
```

## Arguments

- x:

  adm object

- mode:

  string, handed over to *sed_rate_t*, see ?sed_rate_t for details

- ...:

  parameters passed to *get_time*, see ?get_time for details

## Value

a function
