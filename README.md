# lcsm: An R package for specifying and analysing latent change score models using lavaan

This package contains helper functions to specify and analyse univariate and bivariate latent change score models (LCSM) using [lavaan](http://lavaan.ugent.be/). For details about this method see for example [McArdle (2009)](http://www.annualreviews.org/doi/10.1146/annurev.psych.60.110707.163612), [Ghisletta (2012)](https://doi.org/10.1080/10705511.2012.713275), [Grimm (2012)](https://doi.org/10.1080/10705511.2012.659627), and [Grimm (2017)](https://www.guilford.com/books/Growth-Modeling/Grimm-Ram-Estabrook/9781462526062).
Similar work, that this package builds on, can be found [here](https://quantdev.ssri.psu.edu/tutorials/growth-modeling-chapter-16-introduction-latent-change-score-modeling) (univariate LCSM) and [here](https://quantdev.ssri.psu.edu/tutorials/growth-modeling-chapter-17-multivariate-latent-change-score-models) (bivariate LCSM).
[These slides](https://docs.google.com/presentation/d/1q-SVbTA6n_HiC1bLjmCWySk1_b2u6rj12XrfK8-WEE0/edit?usp=sharing) illustrate some univariate and bivariate LCSM that can be specified using this package.

# Installation

First, you need to install the devtools package to download the `lcsm` package from this GitHub repository.

```r
install.packages("devtools")
```

To install the current stable version of `lcsm` package:

```r
devtools::install_github(repo = "milanwiedemann/lcsm")
```

# Overview of the functions

The `lcsm` package contains the following functions that can be categorised into:

1. Functions to specify [lavaan](http://lavaan.ugent.be/) syntax for models:
  - `specify_uni_lcsm()` to write syntax for univariate LCSM
  - `specify_bi_lcsm()` to write syntax for bivariate LCSM
  
2. Functions to fit models using [lavaan](http://lavaan.ugent.be/):
  - `fit_uni_lcsm()` to fit univariate LCSM
  - `fit_bi_lcsm()` to fit bivariate LCSM
  
3. Functions to extract numbers from models using [broom](https://broom.tidyverse.org/):
  - `extract_fit()` to extract fit statistics
  - `extract_param()` to extract estimated parameters
  
4. Helper functions:
  - `plot_lcsm()` to visualise LCSM using [semPlot](http://sachaepskamp.com/semPlot)
  - `select_uni_cases()` to select cases for analysis based on available scores on one construct
  - `select_bi_cases()` to select cases for analysis based on available scores on two construct

# Overview of the models that can be specified

<iframe src="https://docs.google.com/presentation/d/e/2PACX-1vQcqxINjjgYeEyH0dLmmSI80TuVDyJyBQg6IAd6pVFubWxFRiZajU_7bo4wgh28xXpdWin8br_l-0Ci/embed?start=false&loop=false&delayms=3000" frameborder="0" width="960" height="569" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>

# Overview of parameters

## Univariate latent change score models

|Parameter   |Description                                                             |
|:-----------|:-----------------------------------------------------------------------|
|gamma_lx1   |Mean of latent true scores x                                            |
|sigma2_lx1  |Variance of latent true scores x                                        |
|sigma2_ux   |Variance of observed scores x                                           |
|alpha_g2    |Mean of constant change factor (g2)                                     |
|alpha_g3    |Mean of constant change factor (g3)                                     |
|sigma2_g2   |Variance of constant change factor (g2)                                 |
|sigma2_g3   |Variance of constant change factor (g3)                                 |
|sigma_g2lx1 |Covariance of constant change factor (g2) with the initial true score x |
|sigma_g3lx1 |Covariance of constant change factor (g3) with the initial true score x |
|sigma_g2g3  |Covariance of change factors within construct x                         |
|phi_x       |Autoregression of change scores x                                       |

## Bicariate latent change score models

|Parameter    |Description                                                             |
|:------------|:-----------------------------------------------------------------------|
| **Construct X**                                                                      |
|gamma_lx1    |Mean of latent true scores x (Intercept)                                |
|sigma2_lx1   |Variance of latent true scores x                                        |
|sigma2_ux    |Variance of observed scores x                                           |
|alpha_g2     |Mean of constant change factor (g2)                                     |
|alpha_g3     |Mean of constant change factor (g3)                                     |
|sigma2_g2    |Variance of constant change factor (g2)                                 |
|sigma2_g3    |Variance of constant change factor (g3)                                 |
|sigma_g2lx1  |Covariance of constant change factor (g2) with the initial true score x |
|sigma_g3lx1  |Covariance of constant change factor (g3) with the initial true score x |
|sigma_g2g3   |Covariance of change factors within construct x                         |
|phi_x        |Autoregression of change scores x                                       |
| **Construct Y**                                                                      |
|gamma_ly1    |Mean of latent true scores y (Intercept)                                |
|sigma2_ly1   |Variance of latent true scores y                                        |
|sigma2_uy    |Variance of observed scores y                                           |
|alpha_j2     |Mean of constant change factor (j2)                                     |
|alpha_j3     |Mean of constant change factor (j3)                                     |
|sigma2_j2    |Variance of constant change factor (j2)                                 |
|sigma2_j3    |Variance of constant change factor (j3)                                 |
|sigma_j2ly1  |Covariance of constant change factor (j2) with the initial true score y |
|sigma_j3ly1  |Covariance of constant change factor (j3) with the initial true score y |
|sigma_j2j3   |Covariance of change factors within construct y                         |
|phi_y        |Autoregression of change scores y                                       |
| **Coupeling X & Y**                                                                  |
|sigma_su     |Covariance of residuals x and y                                         |
|sigma_ly1lx1 |Covariance of intercepts x and y                                        |
|delta_xy     |Change score x (t) determined by true score y (t-1)                     |
|delta_yx     |Change score y (t) determined by true score x (t-1)                     |
|xi_xy        |Change score x (t) determined by change score y (t-1)                   |
|xi_yx        |Change score y (t) determined by change score x (t-1)                   |

# How to use `lcsm`

Here are a few examples how to use the `lcsm` package.
First, load all needed packages and datasets:

```r
# Load packages ----
library(tidyverse)
library(broom) 
library(lcsm) 

# Load data ----
data <- read_csv("ENTER/PATH/TO/DATA/HERE.csv")

```

Now that the package and data are loaded, you can use `lcsm` to specify and analyse a number of latent difference score models.

```r
# TODO FINISH EXAMPLE
```


# TODOs
- [ ] Finish example
- [ ] Automatically create matrix for plotting function
