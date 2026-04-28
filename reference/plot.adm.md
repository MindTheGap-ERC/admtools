# plotting adm objects

plotting adm objects

## Usage

``` r
# S3 method for class 'adm'
plot(
  x,
  lwd_destr = 1,
  lwd_acc = 1,
  lty_destr = 3,
  lty_acc = 1,
  col_destr = "black",
  col_acc = "black",
  ...
)
```

## Arguments

- x:

  an adm object

- lwd_destr:

  line width of hiatuses

- lwd_acc:

  line width of conservative intervals

- lty_destr:

  linetype of hiatuses

- lty_acc:

  line type of conservative intervals

- col_destr:

  color of erosive intervals

- col_acc:

  color of conservative intervals

- ...:

  arguments passed to plot

## See also

[`L_axis_lab()`](https://mindthegap-erc.github.io/admtools/reference/L_axis_lab.md)
and
[`T_axis_lab()`](https://mindthegap-erc.github.io/admtools/reference/T_axis_lab.md)
for plotting time and axis labels, the vignette on plotting available
via `browseVignettes(package = "admtools")`
