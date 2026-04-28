# extract hiatus info

returns a list with hiatus position and timing (start & end)

## Usage

``` r
get_hiat_list(x)
```

## Arguments

- x:

  an adm object

## Value

a list with one element per hiatus. each element is a named vector with
the following entries:

- "height" : stratigraphic position of hiatus

- "start" : time when hiatus begins

- "end" : time when hiatus ends

## See also

- [`get_hiat_pos()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_pos.md)
  to determine only stratigraphic position of hiatuses

- [`get_hiat_no()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_no.md)
  to determine number of hiatuses in an adm

- [`get_hiat_duration()`](https://mindthegap-erc.github.io/admtools/reference/get_hiat_duration.md)
  to determine duration of hiatuses
