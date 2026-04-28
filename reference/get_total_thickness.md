# get total thickness

for sediment accumulation curves, returns the difference between the
highest and lowest point of the curve. For age-depth models, returns the
total thickness of sediment accumulated.

## Usage

``` r
get_total_thickness(x, ...)
```

## Arguments

- x:

  an age-depth model (adm/multiadm) or a sediment accumulation curve
  (sac)

- ...:

  other options, currently unused

## Value

numeric, total sediment thickness accumulated

## See also

[`max_height()`](https://mindthegap-erc.github.io/admtools/reference/max_height.md)
and
[`min_height()`](https://mindthegap-erc.github.io/admtools/reference/min_height.md)
to extract the highest/lowest stratigraphic point,
[`get_total_thicknesses()`](https://mindthegap-erc.github.io/admtools/reference/get_total_thicknesses.md)
to extract thicknesses from depth-depth curves
