# estimate age-depth model from tracer

Estimates age-depth models by comparing observed tracer values in a
section with assumptions on tracer flux in time. See
[`vignette("adm_from_trace_cont")`](https://mindthegap-erc.github.io/admtools/articles/adm_from_trace_cont.md)
for a full example.

## Usage

``` r
strat_cont_to_multiadm(
  h_tp,
  t_tp,
  strat_cont_gen,
  time_cont_gen,
  h,
  no_of_rep = 100L,
  subdivisions = 100L,
  stop.on.error = TRUE,
  T_unit = NULL,
  L_unit = NULL
)
```

## Arguments

- h_tp:

  function, returning tie point heights

- t_tp:

  function, returning tie points times

- strat_cont_gen:

  function, describing tracer data observed in the section

- time_cont_gen:

  function, describing tracer changes in time

- h:

  numeric vector, heights where the age depth model is described

- no_of_rep:

  integer, number of age depth models generated

- subdivisions:

  integer, max no. of subintervals used by integration procedure. passed
  to *integrate*, see ?stats::integrate for details

- stop.on.error:

  logical passed to *integrate*, see ?stats::integrate for details

- T_unit:

  NULL or character, time unit

- L_unit:

  NULL or character, length unit

## Value

Object of class multiadm

## Examples

``` r
if (FALSE) { # \dontrun{
# see this vignette for an example
vignette("adm_from_trace_cont")
} # }
```
