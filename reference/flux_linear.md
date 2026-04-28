# linear deterministic tracer flux

For usage with *strat_cont_to_multiadm* : defines linear tracer flux in
the time domain Tracer flux is the linear function passing through the
points (x0, y0) and (x1, y1)

## Usage

``` r
flux_linear(x0 = 0, y0 = 1, x1 = 1, y1 = 2)
```

## Arguments

- x0:

  numeric, abscissa

- y0:

  numeric, ordinate

- x1:

  numeric, abscissa

- y1:

  numeric, ordinate

## Value

a function factory that takes no arguments. Upon each evaluation, it
returns a linear function passing through the points (x0, y0) and (x1,
y1)

## See also

[`flux_const()`](https://mindthegap-erc.github.io/admtools/reference/flux_const.md),
[`flux_quad()`](https://mindthegap-erc.github.io/admtools/reference/flux_quad.md),
[`strat_cont_gen_from_tracer()`](https://mindthegap-erc.github.io/admtools/reference/strat_cont_gen_from_tracer.md)
