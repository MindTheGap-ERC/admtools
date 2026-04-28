# condensation with height

returns (instantaneous) condensation (time preserved per length
increment) for a section

## Usage

``` r
condensation(x, h, mode = "rcll", ...)
```

## Arguments

- x:

  adm or multiadm object

- h:

  numeric vector, positions where condensation is determined

- mode:

  string, handed over to *sed_rate_t*, see ?sed_rate_t for details

- ...:

  parameters passed to *get_time*, see ?get_time for details

## Value

if x is an adm object, a numeric vector of condensations. if x is a
multiadm object, a list of condensations
