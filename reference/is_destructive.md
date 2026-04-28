# Is deposition destructive?

Determines whether specified time is destructive or not

## Usage

``` r
is_destructive(x, t, mode = "rcll", 
bdry_pts_hiat = "destructive", out_dom_mode = "default")
```

## Arguments

- x:

  an *adm* or *multiadm* object

- t:

  vector of times

- mode:

  string, either "rcll", "lcrl", "open", or "closed"

- bdry_pts_hiat:

  string, "destructive" or "consistent". If the adm starts/ends with a
  hiatus, should the start/end be removed, or treated consistently with
  mode?

- out_dom_mode:

  ""default", "destructive", or "conservative"

## Value

logical vector of same length as t. Is deposition at time t destructive?
