# plot condensation in height

plots condensation (time per stratigraphic increment) throughout the
section

## Usage

``` r
plot_condensation(x, h = "default", mode = "rcll", ...)
```

## Arguments

- x:

  an adm object

- h:

  "default" or a numeric vector of height where the sed rate is
  evaluated

- mode:

  string, handed over to *sed_rate_t*, see ?sed_rate_t for details

- ...:

  parameters passed to *get_time*, see ?get_time for details

## Value

invisible null
