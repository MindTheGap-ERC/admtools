# sedimentation rate in time domain

infers the instantaneous sedimentation rate from adm objects

## Usage

``` r
sed_rate_t(x, t, mode = "rcll")
```

## Arguments

- x:

  adm or multiadm object

- t:

  vector of times at which sedimentation rates are determined

- mode:

  string, "rcll" or "lcrl". at non-differential points, is the sed rate
  left or right continuous?

## Value

for adm objects, a vector giving sed. accumulation rates at time t. For
multiadm objects, a list with accumulation rates
