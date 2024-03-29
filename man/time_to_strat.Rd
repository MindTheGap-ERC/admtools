% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/time_to_strat.R
\name{time_to_strat}
\alias{time_to_strat}
\title{transform objects from time domain to strat. domain}
\usage{
time_to_strat(obj, x, ...)
}
\arguments{
\item{obj}{the object to be transformed}

\item{x}{age-depth model for the transformation}

\item{...}{other parameters}
}
\value{
an object of the same type as obj
}
\description{
Takes an object and transforms it from the time domain into the stratigraphic domain using the provided age-depth model.
Currently implemented for the "phylo" class.
}
\seealso{
\code{\link[=strat_to_time]{strat_to_time()}} to transform data from the stratigraphic domain to the time domain
}
