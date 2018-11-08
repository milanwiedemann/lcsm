# lcsm: An R package for specifying and analysing latent change score models using lavaan

This package contains helper functions to specify and analyse univariate and bivariate latent change score models (LCSM) as described in [McArdle (2009)](http://www.annualreviews.org/doi/10.1146/annurev.psych.60.110707.163612), [Ghisletta (2012)](https://doi.org/10.1080/10705511.2012.713275), [Grimm (2012)](https://doi.org/10.1080/10705511.2012.659627), [Grimm (2017)](https://www.guilford.com/books/Growth-Modeling/Grimm-Ram-Estabrook/9781462526062) using [lavaan](http://lavaan.ugent.be/).

Similar work, that this package builds on, can be found [here](https://quantdev.ssri.psu.edu/tutorials/growth-modeling-chapter-16-introduction-latent-change-score-modeling) (univariate LCSM) and [here](https://quantdev.ssri.psu.edu/tutorials/growth-modeling-chapter-17-multivariate-latent-change-score-models) (bivariate LCSM).

[These slides](https://docs.google.com/presentation/d/1q-SVbTA6n_HiC1bLjmCWySk1_b2u6rj12XrfK8-WEE0/edit?usp=sharing) illustrate some univariate and bivariate LCSM that can be specified using this package.

## Installation

First, you need to install the devtools package to download the `LCSM` package from this GitHub repository.

```r
install.packages("devtools")
```

To install the current stable version of `LCSM` package:

```r
devtools::install_github(repo = "milanwiedemann/lcsm")
```


## Overview of the functions

The `LCSM` package contains the following functions that can be categorised into:

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

## How to use LCSM

Here are a few examples how to use the `LCSM` package.
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
# Fit univariate LCSM and save the results to the object called `fit_uni_lcsm_results`

fit_uni_lcsm_results <- 

# Extract fit statistics of the model
extract_fit(fit_uni_lcsm_results)

# Extract parameters of the model
extract_param(fit_uni_lcsm_results)
```

```r
# Fit univariate LCSM and safe the results to the object called `fit_uni_LCSM_results`
fit_bi_lcsm_results <- 

# Extract fit statistics of the model
glance(fit_bi_lcsm_results)

# Extract parameters of the model
# Increase number of parameters that get printed here to 30 so that all get printed in the output
print(tbl_df(extract_param(fit_bi_lcsm_results)), n = 30)
```

# TODOs
- [ ] Finish example on this page
- [ ] Automatically create matrix for plotting function
