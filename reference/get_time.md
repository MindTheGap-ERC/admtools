# Determine times based on age-depth model

Takes an age-depth model and vector of stratigraphic positions to
determine the corresponding time of formation

## Usage

``` r
get_time(x, h, hiat_mode = "start", 
bdry_pts_hiat = "destructive", out_dom_val_t = "default")
```

## Arguments

- x:

  an *adm* or *multiadm* object

- h:

  vector of stratigraphic positions

- hiat_mode:

  "start", "end", or "destroy". If a stratigraphic position coincides
  with a hiatus, what should be returned?

- bdry_pts_hiat:

  "consistent" or "destructive". How are hiatuses at the start/end of
  the adm treated?

- out_dom_val_t:

  :"default", "time_limits", or a numeric value. What value is returned
  for heights not covered by the age-depth model?

## Value

numeric vector. Times of deposition of the provided heights in h

## Details

If a stratigraphic position coincides with a hiatus, should the start
time or the end time of the hiatus be returned? Using "destroy" returns
NA If the adm starts/ends with a hiatus, should the time returned be
consistent with *hiat_mode*, or should it be NA?
