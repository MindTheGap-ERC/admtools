% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_destructive.R
\name{is_destructive}
\alias{is_destructive}
\title{Is deposition destructive?}
\usage{
is_destructive(x, t, mode = "rcll", 
bdry_pts_hiat = "destructive", out_dom_mode = "default")
}
\arguments{
\item{x}{an \emph{adm} or \emph{multiadm} object}

\item{t}{vector of times}

\item{mode}{string, either "rcll", "lcrl", "open", or "closed"}

\item{bdry_pts_hiat}{string, "destructive" or "consistent". If the adm starts/ends with a hiatus, should the
start/end be removed, or treated consistently with mode?}

\item{out_dom_mode}{""default", "destructive", or "conservative"}
}
\value{
logical vector of same length as t. Is deposition at time t destructive?
}
\description{
Determines whether specified time is destructive or not
}
