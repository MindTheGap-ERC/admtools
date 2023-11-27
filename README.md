# admtools

R package to handle age-depth models

## Authors

__Niklas Hohmann__  
Utrecht University  
email: n.hohmann [at] uu.nl  
Web page: [uu.nl/staff/NHohmann](uu.nl/staff/NHohmann)  
Orcid: [0000-0003-1559-1838](https://orcid.org/0000-0003-1559-1838)

## Installation

In R, first, install the devtools package:

```{R}
install.packages("devtools")
```

You can install the _admtools_ package_ directly from GitHub using

```{R}
devtools::install_github(repo = "MindTheGap-ERC/admtools",
                         build_vignettes = TRUE)
```

Now you can load the package using

```{R}
library("admtools")
```

To get started, have a look at the vignettes:

```{R}
vignette("admtools")
```

## Copyright

Copyright 2023 Netherlands eScience Center and Utrecht University

## License

Apache 2.0 License, see LICENSE file for license text.

## Funding information

Funded by the European Union (ERC, MindTheGap, StG project no 101041077). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or the European Research Council. Neither the European Union nor the granting authority can be held responsible for them.
![European Union and European Research Council logos](https://erc.europa.eu/sites/default/files/2023-06/LOGO_ERC-FLAG_FP.png)
