# summary of age-depth model

Displays some summary numbers of an age-depth models

## Usage

``` r
# S3 method for class 'adm'
summary(object, ...)
```

## Arguments

- object:

  an adm object

- ...:

  other variables, are ignored

## Value

Invisible NULL, prints summary to the console

## Examples

``` r
my_adm = tp_to_adm(t = 1:5, h = c(2,2,3), L_unit = "m", T_unit = "Myr" )
summary(my_adm)
#> age-depth model 
#> Total duration: 4 Myr
#> Total thickness: 1 m
#> Stratigraphic completeness: 50 % 
#> 1 hiatus(es)

```
