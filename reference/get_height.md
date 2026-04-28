# determine stratigraphic height deposited at specific time

Takes an adm object and a vector of times, and returns the stratigraphic
heights deposited at said times

## Usage

``` r
get_height(x, t, destructive = TRUE, out_dom_val_h = "default", ...)
```

## Arguments

- x:

  an *adm* or *multiadm* object

- t:

  vector of times

- destructive:

  logical - should destructive intervals be considered? See Details

- out_dom_val_h:

  "strat_limits", "default", or a vector with one or two entries. What
  value is assigned to times that are not covered by the age-depth
  model?

- ...:

  parameters handed over to is_destructive

## Value

a vector with same length as t, containing the strat heights deposited

## Details

if destructive is true, NA is returned for times that coincide with
destructive intervals. This is achieved by calling *is_destructive* with
arguments passed by *...*.

*out_dom_val* specified the return value for times that are not covered
by the age-depth model. For "default", NA is returned. For
"strat_limits", the lowest resp. highest stratigraphic position is
returned. For a vector of length one, this value is assigned to both
sides. For a vector or length 2 or more, the first and second entries
are assigned on the left (resp. right) side
