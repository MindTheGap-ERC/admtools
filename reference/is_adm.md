# Is an adm object a valid age-depth model

Constructors for adm objects such as *tp_to_adm* do not check whether
the inputs define a valid age-depth mode, e.g. one where the law of
superposition holds. This function performs these checks

## Usage

``` r
is_adm(x, quietly = TRUE)
```

## Arguments

- x:

  an object

- quietly:

  logical. should descriptive warnings be shown?

## Value

logical. Is the input a valid adm object?

## Examples

``` r
x = tp_to_adm(t = c(2,1), h = c(1,2)) # reversed order of time tie points
is_adm(x) # returns FALSE
#> [1] FALSE

```
