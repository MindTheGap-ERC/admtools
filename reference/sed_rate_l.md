# sedimentation rate in stratigraphic height

determines instantaneous sedimentation rate at a specified stratigraphic
position

## Usage

``` r
sed_rate_l(x, h, mode = "rcll", ...)
```

## Arguments

- x:

  adm object

- h:

  numeric vector, stratigraphic positions

- mode:

  string, handed over to *sed_rate_t*, see ?sed_rate_t for details

- ...:

  parameters passed to *get_time*, see ?get_time for details

## Value

a vector of sed rates (if x is an adm object), or a list of
sedimentation rates
