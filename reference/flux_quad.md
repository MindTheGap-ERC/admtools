# quadratic deterministic tracer flux

For usage with *strat_cont_to_multiadm* : defines quadratic tracer flux
in the time domain defined by the function f(x) = ax^2 + bx + c

## Usage

``` r
flux_quad(a = 1, b = 1, c = 1)
```

## Arguments

- a:

  numeric

- b:

  numeric

- c:

  numeric

## Value

a function factory that takes no arguments. Upon each evaluation, it
returns the quadratic function f(x) = ax^2 + bx + c

## See also

[`flux_linear()`](https://mindthegap-erc.github.io/admtools/reference/flux_linear.md),
[`flux_const()`](https://mindthegap-erc.github.io/admtools/reference/flux_const.md),
[`strat_cont_gen_from_tracer()`](https://mindthegap-erc.github.io/admtools/reference/strat_cont_gen_from_tracer.md)
