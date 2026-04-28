# plot strat list

plots a `stratlist`, i.e. a list of values associated with stratigraphic
positions (typically returned by time_to_strat). will plot the element
with matching `ord_name` against stratigraphic positions.

## Usage

``` r
# S3 method for class 'stratlist'
plot(x, orientation = "du", ord_name = "y", ...)
```

## Arguments

- x:

  stratlist object

- orientation:

  character, either "du" (down-up) or "lr" (left-right). Orientation of
  plotting

- ord_name:

  name of the ordinate. Values plotted against time

- ...:

  further arguments passed to plot
