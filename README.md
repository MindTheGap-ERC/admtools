# admtools

R package to estimate age-depth models from stratigraphic and sedimentological data, and transform complex data between the time and stratigraphic domain.

<!-- badges: start -->
  [![R-CMD-check](https://github.com/MindTheGap-ERC/admtools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/MindTheGap-ERC/admtools/actions/workflows/R-CMD-check.yaml)
[![fair-software.eu](https://img.shields.io/badge/fair--software.eu-%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8B-yellow)](https://fair-software.eu)
  [![](https://www.r-pkg.org/badges/version/admtools?color=pink)](https://cran.r-project.org/package=admtools)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13628460.svg)](https://doi.org/10.5281/zenodo.13628460)
  <!-- badges: end -->

## Authors

__Niklas Hohmann__  
Utrecht University  
email: n.h.hohmann [at] uu.nl  
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

To install the latest stable version. To install the version under development, use

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

A good place to start reading is the introductory vignette, available via

```R
vignette("admtools")
```

## License

GPL-3.0, see LICENSE file for license text.

## Copyright

Copyright 2023 Netherlands eScience Center and Utrecht University

## Contribution

For contribution guidelines see the CONTRIBUTING.md file

## Citation

To cite the package, use

* Hohmann, N. (2024). admtools (v0.3.1). Zenodo. https://doi.org/10.5281/zenodo.13628460

or run

```R
citation("admtools")
```

in R. Alternatively, you can use the information in the CITATION.cff file, or generate it using the "cite this repository" button on GitHub.

## References

This package uses data from

-   Hohmann, Niklas; Koelewijn, Joël R.; Burgess, Peter; Jarochowska, Emilia. 2024. "Identification of the mode of evolution in incomplete carbonate successions." BMC Ecology and Evolution, **24**, 113. [DOI: 10.1186/s12862-024-02287-2](https://doi.org/10.1186/s12862-024-02287-2).

-   Hohmann, Niklas, Koelewijn, Joël R.; Burgess, Peter; Jarochowska, Emilia. 2023. "Identification of the Mode of Evolution in Incomplete Carbonate Successions - Supporting Data." Open Science Framework. <https://doi.org/10.17605/OSF.IO/ZBPWA>, published under the [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Funding information

The authors acknowledge the contribution of the CycloNet project, funded by the Research Foundation Flanders (FWO, grant no. W000522N)

Funded by the European Union (ERC, MindTheGap, StG project no 101041077). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Research Council. Neither the European Union nor the granting authority can be held responsible for them.
![European Union and European Research Council logos](https://erc.europa.eu/sites/default/files/2023-06/LOGO_ERC-FLAG_FP.png)


