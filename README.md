# ldsm: An R package for specifying and analysing latent difference score models using lavaan

**THIS R PACKAGE IS WORK IN PROGRESS!**
At the moment this package works with 6 to 10 time points.

---

This package contains helper functions to define and analyse univariate and bivariate latent difference score models (LDSM) as described in [McArdle (2009)](http://www.annualreviews.org/doi/10.1146/annurev.psych.60.110707.163612), [Ghisletta (2012)](https://doi.org/10.1080/10705511.2012.713275), [Grimm (2012)](https://doi.org/10.1080/10705511.2012.659627), [Grimm (2017)](https://www.guilford.com/books/Growth-Modeling/Grimm-Ram-Estabrook/9781462526062) using [lavaan](http://lavaan.ugent.be/).

Similar work, that this package builds on, can be found [here](https://quantdev.ssri.psu.edu/tutorials/growth-modeling-chapter-16-introduction-latent-change-score-modeling) (univariate LDSM) and [here](https://quantdev.ssri.psu.edu/tutorials/growth-modeling-chapter-17-multivariate-latent-change-score-models) (bivariate LDSM).

At the moment I'm working on slides to illustrate the different [univariate](https://docs.google.com/presentation/d/1a6mt4EhgMOfuIysNh8jOWhTPhvsrskXHuil7ZBoUdFg/edit?usp=sharing) and [bivariate](https://docs.google.com/presentation/d/1vdaWQkZ2wsDy9By0TmgCdjG8pf8yEhGngwNEJY5Y7sI/edit?usp=sharing) models that can be specified using this package.
The slides are also work in progress at the moment.
Please add comments to the slides or this repository in the [Wiki](https://github.com/milanwiedemann/ldsm/wiki/Comments).

## Installation

First, you need to install the devtools package to download the `ldsm` package from this GitHub repository.

```r
install.packages("devtools")
```

To install the current stable version of `ldsm` package:

```r
devtools::install_github(repo = "milanwiedemann/ldsm")
```


## Overview of the functions

The `ldsm` package four main functions which can be categorised into:

1. Functions to specify and fit models:
  - `fit_uni_ldsm()` to fit univariate LDSM
  - `fit_bi_ldsm()` to fit bivariate LDSM
  
2. Functions to extract numbers from the models:
  - `extract_fit()` to extract fit statistics
  - `extract_param()` to extract parameters
  
## Overview of models that can be specified

1. Univariate LDSM:
  - `uni_ldsm_no_change`
  - `uni_ldsm_proportional_change`
  - `uni_ldsm_constant_change`
  - `uni_ldsm_dual_change`
  - `uni_ldsm_dual_change_delta`
  - `uni_ldsm_dual_change_linear`
  - `uni_ldsm_dual_change_noise`

2. Bivariate LDSM:
  - `bi_ldsm_no_coupling`
  - `bi_ldsm_x_on_deltay`
  - `bi_ldsm_y_on_deltax`
  - `bi_ldsm_dual_change`
  - `bi_ldsm_dual_change_delta_within`
  - `bi_ldsm_dual_change_delta_xy`
  - `bi_ldsm_dual_change_delta_yx`
  - `bi_ldsm_dual_change_delta_full`

## How to use ldsm

Here are a few examples how to use the `ldsm` package.
First, load all needed packages and datasets:

```r
# Load packages ----
library(tidyverse)
library(broom) 
library(ldsm) 

# Load data ----
data <- read_csv("ENTER/PATH/TO/DATA/HERE.csv")

```

Now that the package and data are loaded, you can use `ldsm` to specify and analyse a number of latent difference score models.

```r
# Fit univariate ldsm and safe the results to the object called `fit_uni_ldsm_results`
fit_uni_ldsm_results <- fit_uni_ldsm(data = data,
                                     y = c("var1_s1", "var1_s2", "var1_s3", "var1_s4", "var1_s5", "var1_s6", "var1_s7", "var1_s8", "var1_s9", "var1_s10"),
                                     model = "uni_ldsm_dual_change") 

# Extract fit statistics of the model
extract_fit(fit_uni_ldsm_results)

# Extract parameters of the model
extract_param(fit_uni_ldsm_results)
```

```r
# Fit univariate ldsm and safe the results to the object called `fit_uni_ldsm_results`
fit_bi_ldsm_results <- fit_bi_ldsm(data = data,
                                   y = c("var1_s1", "var1_s2", "var1_s3", "var1_s4", "var1_s5", "var1_s6", "var1_s7", "var1_s8", "var1_s9", "var1_s10"),
                                   x = c("var2_s1", "var2_s2", "var2_s3", "var2_s4", "var2_s5", "var2_s6", "var2_s7", "var2_s8", "var2_s9", "var2_s10"),
                                   model = "bi_ldsm_dual_change")

# Extract fit statistics of the model
glance(fit_bi_ldsm_results)

# Extract parameters of the model
# Increase number of parameters that get printed here to 21 so that all get printed in the output
print(tbl_df(extract_param(fit_bi_ldsm_results)), n = 21)
```

# TODO
- [ ] Finish example on this page
- [ ] Functionality to fix/free specific parameters
- [ ] Add plotting function
- [ ] Add functionality for more time points
