# reverse direction of time/depth axis

The `FossilSim` package simulates fossils, trees, and taxonomies using
age meaning 0 represents the present and larger numbers indicate older
ages To interact with `admtools`, the direction of time must be reversed
effectively replaces the time component `t` of an object by `ref - t`

## Usage

``` r
rev_dir(x, ref)
```

## Arguments

- x:

  object to transform - typically a `fossil` or `taxonomy` object

- ref:

  reference point used for reversal

## Examples

``` r
if (FALSE) { # \dontrun{
  # for usage example, see
  vignette("FossilSim_integration")
} # }

```
