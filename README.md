# lcsm: An R package for specifying and analysing latent change score models using lavaan

This package contains helper functions to specify and analyse univariate and bivariate latent change score models (LCSM) using [lavaan](http://lavaan.ugent.be/). For details about this method see for example [McArdle (2009)](http://www.annualreviews.org/doi/10.1146/annurev.psych.60.110707.163612), [Ghisletta (2012)](https://doi.org/10.1080/10705511.2012.713275), [Grimm (2012)](https://doi.org/10.1080/10705511.2012.659627), and [Grimm (2017)](https://www.guilford.com/books/Growth-Modeling/Grimm-Ram-Estabrook/9781462526062).

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
  - `specify_uni_lcsm()`: write syntax for univariate LCSM
  - `specify_bi_lcsm()`: write syntax for bivariate LCSM
  
2. Functions to fit models using [lavaan](http://lavaan.ugent.be/):
  - `fit_uni_lcsm()`: fit univariate LCSM
  - `fit_bi_lcsm()`: fit bivariate LCSM
  
3. Functions to extract numbers from models using [broom](https://broom.tidyverse.org/):
  - `extract_fit()`: extract fit statistics
  - `extract_param()`: extract estimated parameters
  
4. Helper functions:
  - `plot_lcsm()`: visualise LCSM using [semPlot](http://sachaepskamp.com/semPlot), doesn't work at the moment
  - `select_uni_cases()`: select cases for analysis based on available scores on one construct
  - `select_bi_cases()`: select cases for analysis based on available scores on two construct

# Overview of some models that can be specified

## Univariate latent change score models

Here is a slide illustrating a univariate dual change score model:
![](https://dl.dropboxusercontent.com/s/g4czivyp8pd5qwt/uni-lcsm-dual.png)

## Bivariate latent change score models

This slide shows a bivariate latent change score model without coupling between the constructs:
![](https://dl.dropboxusercontent.com/s/ewoksd04f2rs2z8/bi-lcsm-no-coup.png)

This model includes coupling parameters between the constructs:
![](https://dl.dropboxusercontent.com/s/e12ut0ri96nzjuf/bi-lcsm-coup.png)



# Overview of estimated parameters

Depending on the specified model, the following parameters can be estimated for **univariate** latent change score models: 

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

For bivariate latent change score models, estimated parameters can be categorised into (1) **Construct X**, (2) **Construct Y**, and (3) **Coupeling between X and Y**.

|Parameter    |Description                                                             |
|:------------|:-----------------------------------------------------------------------|
| **1. Construct X**                                                                      |
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
| **2. Construct Y**                                                                      |
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
| **3. Coupeling X & Y**                                                                  |
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