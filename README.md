# lcsm: Specifying, analysing, and visualising latent change score models

[![last-change](https://img.shields.io/badge/Last%20change-2019--06--03-brightgreen.svg)](https://github.com/milanwiedemann/lcsm)
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Travis build status](https://travis-ci.org/milanwiedemann/lcsm.svg?branch=master)](https://travis-ci.org/milanwiedemann/lcsm)
[![Build status](https://ci.appveyor.com/api/projects/status/swwgfqdufr5xmxf2?svg=true)](https://ci.appveyor.com/project/milanwiedemann/lcsm)
[![lcsm-version](https://img.shields.io/badge/Version-0.0.3-brightgreen.svg)](https://github.com/milanwiedemann/lcsm) 

This package contains helper functions to specify and analyse univariate and bivariate latent change score models (LCSM) using [lavaan](http://lavaan.ugent.be/). For details about this method see for example McArdle ([2009](http://www.annualreviews.org/doi/10.1146/annurev.psych.60.110707.163612)), Ghisletta ([2012](https://doi.org/10.1080/10705511.2012.713275)), Grimm et al. ([2012](https://doi.org/10.1080/10705511.2012.659627)), and Grimm, Ram & Estabrook ([2017](https://www.guilford.com/books/Growth-Modeling/Grimm-Ram-Estabrook/9781462526062)).
[These slides](https://docs.google.com/presentation/d/1q-SVbTA6n_HiC1bLjmCWySk1_b2u6rj12XrfK8-WEE0/edit?usp=sharing) illustrate some of the models that can be specified and analysed using this package.

# Installation

First, you need to install the `devtools` package to download the `lcsm` package from GitHub repository.

```r
install.packages("devtools")
```

To install the current stable version of the `lcsm` package:

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
  
4. Simulate data using [lavaan](http://lavaan.ugent.be/):
  - `sim_uni_lcsm_data()`: Simulate data from a univariate LCS model
  - `sim_bi_lcsm_data()`: Simulate data from a bivariate LCS model
  
5. Helper functions:
  - `plot_lcsm()`: visualise LCSM using [semPlot](http://sachaepskamp.com/semPlot)
  - `select_uni_cases()`: select cases for analysis based on available scores on one construct
  - `select_bi_cases()`: select cases for analysis based on available scores on two construct


# Overview of parameters

## Univariate LCS models

Depending on the specified model, the following parameters can be estimated for **univariate** LCS models: 

|Parameter   |Description                                                             |
|:-----------|:-----------------------------------------------------------------------|
|gamma_lx1   |Mean of latent true scores x (Intercept)                                |
|sigma2_lx1  |Variance of latent true scores x                                        |
|sigma2_ux   |Variance of observed scores x                                           |
|alpha_g2    |Mean of change factor (g2)                                              |
|alpha_g3    |Mean of change factor (g3)                                              |
|sigma2_g2   |Variance of change factor (g2)                                          |
|sigma2_g3   |Variance of change factor (g3)                                          |
|sigma_g2lx1 |Covariance of change factor (g2) with the initial true score x          |
|sigma_g3lx1 |Covariance of change factor (g3) with the initial true score x          |
|sigma_g2g3  |Covariance of change factors within construct x                         |
|phi_x       |Autoregression of change scores x                                       |

## Bivariate LCS models

For bivariate LCS models, estimated parameters can be categorised into (1) **Construct X**, (2) **Construct Y**, and (3) **Coupeling between X and Y**.

|Parameter    |Description                                                             |
|:------------|:-----------------------------------------------------------------------|
|**Construct X**                                                                       |
|  gamma_lx1    |Mean of latent true scores x (Intercept)                                |
|  sigma2_lx1   |Variance of latent true scores x                                        |
|  sigma2_ux    |Variance of observed scores x                                           |
|  alpha_g2     |Mean of change factor (g2)                                              |
|  alpha_g3     |Mean of change factor (g3)                                              |
|  sigma2_g2    |Variance of change factor (g2)                                          |
|  sigma2_g3    |Variance of change factor (g3)                                          |
|  sigma_g2lx1  |Covariance of change factor (g2) with the initial true score x (lx1)    |
|  sigma_g3lx1  |Covariance of change factor (g3) with the initial true score x (lx1)    |
|  sigma_g2g3   |Covariance of change factors within construct x                         |
|  phi_x        |Autoregression of change scores x                                       |
|**Construct Y**                                                                       |
|gamma_ly1    |Mean of latent true scores y (Intercept)                                |
|sigma2_ly1   |Variance of latent true scores y                                        |
|sigma2_uy    |Variance of observed scores y                                           |
|alpha_j2     |Mean of change factor (j2)                                              |
|alpha_j3     |Mean of change factor (j3)                                              |
|sigma2_j2    |Variance of change factor (j2)                                          |
|sigma2_j3    |Variance of change factor (j3)                                          |
|sigma_j2ly1  |Covariance of change factor (j2) with the initial true score y (ly1)    |
|sigma_j3ly1  |Covariance of change factor (j3) with the initial true score y (ly1)    |
|sigma_j2j3   |Covariance of change factors within construct y                         |
|phi_y        |Autoregression of change scores y                                       |
|**Coupeling X & Y**                                                                   |
|sigma_su     |Covariance of residuals x and y                                         |
|sigma_ly1lx1 |Covariance of intercepts x and y                                        |
|sigma_g2ly1  |Covariance of change factor x (g2) with the initial true score y (ly1)  |
|sigma_g3ly1  |Covariance of change factor x (g3) with the initial true score y (ly1)  |
|sigma_j2lx1  |Covariance of change factor y (j2) with the initial true score x (lx1)  |
|sigma_j3lx1  |Covariance of change factor y (j3) with the initial true score x (lx1)  |
|sigma_j2g2   |Covariance of change factors y (j2) and x (g2)                          |
|sigma_j2g3   | Covariance of change factors y (j2) and x (g3)                         |
|sigma_j3g2   |Covariance of change factors y (j3) and x (g2)                          |
|delta_con_xy |Change score x (t) determined by true score y (t)                       |
|delta_con_yx |Change score y (t) determined by true score x (t)                       |
|delta_lag_xy |Change score x (t) determined by true score y (t-1)                     |
|delta_lag_yx |Change score y (t) determined by true score x (t-1)                     |
|xi_con_xy    |Change score x (t) determined by change score y (t)                     |
|xi_con_yx    |Change score y (t) determined by change score x (t)                     |
|xi_lag_xy    |Change score x (t) determined by change score y (t-1)                   |
|xi_lag_yx    |Change score y (t) determined by change score x (t-1)                   |

# How to use `lcsm`

Here are a few examples how to use the `lcsm` package.

```r
# Load packages ----
library(tidyverse)
library(lavaan)
library(broom)
library(semPlot)
library(lcsm) 

# Load data ----

data <- read_csv("~/ENTER/PATH/TO/DATA.csv")
```

## 1. Visualise data

The package has a function to create longitudinal plots of the measures.

```r
# Visualise data ----
# Create longitudinal plot of the scores for variables x1 to x7
# Change the variable names to the variables to be plotted
# The plot can also be saved to an object to be further customised using ggplot2 functions
plot_trajectories(data = data,
                  id_var = "id", 
                  var_list = c("x1", "x2", "x3", "x4", "x5", "x6", "x7"),
                  xlab = "Time", ylab = "Score")
```

## 2. Fit LCS models

### 2.1. Fit univariate LCS models

The functions `fit_uni_lcsm()` and `fit_bi_lcsm()` can be used to specify and analyse a number of latent difference score models.
It is also possible to extract the lavaan syntax that was specified and used to fit the model.
The lavaan syntax includes comments about each element in the model and can be manually adapted for further specifications.
The following table descibes the different model specifications that the `model` argument can take:


|Model specification  |Description                                                    |
|:-----------|:-----------------------------------------------------------------------|
|alpha_constant      |Constant change factor                                          |
|alpha_linear        |Linear change factor                               |
|alpha_piecewise     |Piecewise constant change factors                                |
|alpha_piecewise_num |Changepoint of piecewise constant change factors                                |
|beta                |Proportional change factor                                      |
|phi                 |Autoregression of change scores                                 |

### 2.2. Fit bivariate LCS models

To estimate coupling parameters for bivariate LCSM, the argument `coupling` from the `fit_bi_lcsm()` function can take the following specifications:

|Coupling specification |Description                                            |
|:----------------------|:------------------------------------------------------|
|coupling_piecewise     |Piecewise coupling parameters                          |
|coupling_piecewise_num |Changepoint of piecewise coupling parameters           |
|delta_con_xy           |Change score x (t) determined by true score y (t)      |
|delta_con_yx           |Change score y (t) determined by true score x (t)      |
|delta_lag_xy           |Change score x (t) determined by true score y (t-1)    |
|delta_lag_yx           |Change score y (t) determined by true score x (t-1)    |
|xi_con_xy              |Change score x (t) determined by change score y (t)    |
|xi_con_yx              |Change score y (t) determined by change score x (t)    |
|xi_lag_xy              |Change score x (t) determined by change score y (t-1)  |
|xi_lag_yx              |Change score y (t) determined by change score x (t-1)  |


```r
# Fit univariate lcsm ----
# To see all parameters that can be estimated for univariate lcsm see help(fit_uni_lcsm)
fit_uni_lcsm_01 <- fit_uni_lcsm(# Specify dataset in wide format
                                data = data, 
                                # Specify which variables to use
                                var = c("x1", "x2", "x3", "x4", "x5", "x6", "x7"),
                                # Specify which parameters to estimate in model
                                model = list(alpha_constant = FALSE, beta = TRUE),
                                # Create object in Global Environment with lavaan model syntax
                                export_model_syntax = TRUE, name_model_syntax = "uni_lcsm_01")
                             
# Fit bivariate lcsm ----
# To see all parameters that can be estimated for bivariate lcsm see help(fit_bi_lcsm)
fit_bi_lcsm_01 <- fit_bi_lcsm(data = data,
                              var_x = c("x1", "x2", "x3", "x4", "x5", "x6", "x7"),
                              var_y = c("y1", "y2", "x3", "y4", "y5", "y6", "y7"),
                              model_x = list(alpha_constant = TRUE, beta = TRUE, phi = TRUE),
                              model_y = list(alpha_constant = TRUE, beta = TRUE, phi = TRUE),  
                              coupling = list(# delta_xy parameter estimates change score x (t) 
                                              # determined by true score y (t-1)
                                              delta_xy = TRUE, delta_yx = TRUE, 
                                              # xi_xy parameter estimates change score x (t) 
                                              # determined by change score y (t-1)
                                              xi_xy = TRUE, xi_yx = TRUE),
                              export_model_syntax = TRUE, name_model_syntax = "bi_lcsm_01")
                              
# Look at lavaan model syntax that was specified and fit for these models
# Use 'export_model_syntax = TRUE' to export model syntax to the global environment

# To see the model syntax that was speficied for the model 'fit_uni_lcsm_01' use:
cat(uni_lcsm_01)

# To see the model syntax that was speficied for the model 'fit_bi_lcsm_01' use:
cat(bi_lcsm_01)
```

## 3. Extract fit statistics and parmeters

```r
# Extract fit statistics ----
extract_fit(# Specify which lavaan objects to extract fit from
            lavaan_object = fit_uni_lcsm_01, 
            # Only return selection of fit statistics (details = FALSE)
            details = FALSE)

# Extract estimated parameters ----
# Specify which lavaan objects to extract fit from
# Descriptions about each parameter can be found in the table above
extract_param(fit_uni_lcsm_01)
```

## 4. Plot simplified path diagrams of lcsm

```r
# First, a layout matrix has to be defined manually
# This will be used by the semPlot package to arrange the different elements in the plot

# Create layout matrix for univariate LCSM without intercepts
layout_uni_lcsm <- matrix(
  c(NA, "g2", NA, NA, NA, NA, NA, 
    NA, "dx2", "dx3", "dx4", "dx5", "dx6", "dx7",
    "lx1", "lx2", "lx3", "lx4", "lx5", "lx6", "lx7",
    "x1", "x2", "x3", "x4", "x5", "x6", "x7"),
  4, byrow = TRUE)

# Create layout matrix for bivariate LCSM without intercepts
layout_bi_lcsm <- matrix(
  c(NA, NA, "y1", "y2", "y3", "y4", "y5", "y6", "y7",
    NA, NA, "ly1", "ly2", "ly3", "ly4", "ly5", "ly6", "ly7",
    NA, NA, NA, "dy2", "dy3", "dy4", "dy5", "dy6", "dy7",
    NA, "j2",NA,NA, NA,  NA, NA, NA, NA, 
    NA, "g2", NA,NA, NA,  NA, NA, NA, NA, 
    NA, NA, NA, "dx2", "dx3", "dx4", "dx5", "dx6", "dx7", 
    NA, NA, "lx1", "lx2", "lx3", "lx4", "lx5", "lx6", "lx7",
    NA, NA, "x1", "x2", "x3", "x4", "x5", "x6", "x7"),
  8, byrow = TRUE)

# Plot simplified path diagram using semPlot package
# The lavaan_object argument takes any lavaan object as input
# The layout argument is the above specified matrix
# Depending on the number of measurement points this matrix has to be adapted manually at the moment

# This command plots the univariate lcsm 'fit_uni_lcsm_01' using the predifined matrix 'layout_uni_lcsm'
plot_lcsm(lavaan_object = fit_uni_lcsm_01, 
          layout = layout_uni_lcsm)
          
# This command plots the bivariate lcsm 'fit_bi_lcsm_01' using the predifined matrix 'layout_bi_lcsm'
plot_lcsm(lavaan_object = fit_bi_lcsm_01, 
          layout = layout_bi_lcsm)
```

## 5. Simulate data
