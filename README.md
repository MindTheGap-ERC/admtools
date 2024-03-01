# admtools

R package to estimate age-depth models from stratigraphic and sedimentological data, and transform complex data between the time and stratigraphic domain.

<!-- badges: start -->
  [![R-CMD-check](https://github.com/MindTheGap-ERC/admtools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/MindTheGap-ERC/admtools/actions/workflows/R-CMD-check.yaml)
  [![fair-software.eu](https://img.shields.io/badge/fair--software.eu-%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8B%20%20%E2%97%8F%20%20%E2%97%8B-orange)](https://fair-software.eu)
  <!-- badges: end -->

## Authors

__Niklas Hohmann__  
Utrecht University  
email: n.hohmann [at] uu.nl  
Web page: [uu.nl/staff/NHohmann](https://www.uu.nl/staff/NHHohmann)  
Orcid: [0000-0003-1559-1838](https://orcid.org/0000-0003-1559-1838)

## Installation

You can install the package from _CRAN_. For this, run

```R
install.packages("admtools")
```

in R. To install the package from _GitHub_, first install the _remotes_ package

```R
install.packages("remotes")
```

Then, run

```R
remotes::install_github(repo = "MindTheGap-ERC/admtools",
                        build_vignettes = TRUE,
                        ref = "HEAD",
                        dependencies = TRUE)
```

To install the latest stable version. To install the version under developemnt, use

```R
remotes::install_github(repo = "MindTheGap-ERC/admtools",
                        build_vignettes = TRUE,
                        ref = "dev",
                        dependencies = TRUE)
```

After installation, you can load the package using

```R
library("admtools")
```

To get started, have a look at the available vignettes via

```R
browseVignettes(package = "admtools") # opens in Browser
#or
vignette(package = "admtools")
```

A good place to start reading is the introductionary vignette, available via

```R
vignette("admtools")
```

## License

GPL-3.0, see LICENSE file for license text.

## Copyright

Copyright 2023 Netherlands eScience Center and Utrecht University

## Citation

To cite the package, use

* Hohmann N (2023). “admtools package for R.” doi:10.5281/zenodo.10213587 <https://doi.org/10.5281/zenodo.10213587>

or run

```R
citation("admtools)
```

in R. Alternatively, you can use the information in the CITATION.cff file, or generate it using the "cite this repository" button on GitHub.

## Funding information

Funded by the European Union (ERC, MindTheGap, StG project no 101041077). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Research Council. Neither the European Union nor the granting authority can be held responsible for them.
![European Union and European Research Council logos](https://erc.europa.eu/sites/default/files/2023-06/LOGO_ERC-FLAG_FP.png)
