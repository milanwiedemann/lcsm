
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lcsm: An R package and tutorial on latent change score modeling

[![last-change](https://img.shields.io/badge/Last%20change-2019--09--05-brightgreen.svg)](https://github.com/milanwiedemann/lcsm)
[![Travis build
status](https://travis-ci.org/milanwiedemann/lcsm.svg?branch=master)](https://travis-ci.org/milanwiedemann/lcsm)
[![Build
status](https://ci.appveyor.com/api/projects/status/swwgfqdufr5xmxf2?svg=true)](https://ci.appveyor.com/project/milanwiedemann/lcsm)
[![lcsm-version](https://img.shields.io/badge/Version-0.0.5-brightgreen.svg)](https://github.com/milanwiedemann/lcsm)

This package contains some helper functions to specify and analyse
univariate and bivariate latent change score (LCS) models using
[lavaan](http://lavaan.ugent.be/). For details about this method see for
example McArdle
([2009](http://www.annualreviews.org/doi/10.1146/annurev.psych.60.110707.163612)),
Ghisletta ([2012](https://doi.org/10.1080/10705511.2012.713275)), Grimm
et al. ([2012](https://doi.org/10.1080/10705511.2012.659627)), and
Grimm, Ram & Estabrook
([2017](https://www.guilford.com/books/Growth-Modeling/Grimm-Ram-Estabrook/9781462526062)).

## Installation

You can install the development version from
[GitHub](https://github.com/milanwiedemann/lcsm) with:

``` r
# install.packages("devtools")
devtools::install_github("milanwiedemann/lcsm")
```

## Overview of the functions

The `lcsm` package contains the following functions that can be
categorised into:

1.  Functions to specify [lavaan](http://lavaan.ugent.be/) syntax for
    models:

<!-- end list -->

  - `specify_uni_lcsm()`: write syntax for univariate LCSM
  - `specify_bi_lcsm()`: write syntax for bivariate LCSM

<!-- end list -->

2.  Functions to fit models using [lavaan](http://lavaan.ugent.be/):

<!-- end list -->

  - `fit_uni_lcsm()`: fit univariate LCSM
  - `fit_bi_lcsm()`: fit bivariate LCSM

<!-- end list -->

3.  Functions to extract numbers from models using
    [broom](https://broom.tidyverse.org/):

<!-- end list -->

  - `extract_fit()`: extract fit statistics
  - `extract_param()`: extract estimated parameters

<!-- end list -->

4.  Simulate data using [lavaan](http://lavaan.ugent.be/):

<!-- end list -->

  - `sim_uni_lcsm_data()`: Simulate data from a univariate LCS model
  - `sim_bi_lcsm_data()`: Simulate data from a bivariate LCS model

<!-- end list -->

5.  Helper functions:

<!-- end list -->

  - `plot_lcsm()`: visualise LCSM using
    [semPlot](http://sachaepskamp.com/semPlot)
  - `select_uni_cases()`: select cases for analysis based on available
    scores on one construct
  - `select_bi_cases()`: select cases for analysis based on available
    scores on two construct

## How to use `lcsm`

Here are a few examples how to use the `lcsm` package.

``` r
# Load the package
library(lcsm)
```

### 1\. Visualise data

Longitudinal data can be visualised using the `plot_trajectories()`
function. Here only 30% of the data is visualised for using the argument
`random_sample_frac = 0.3`. Only consecutive measures are connected by
lines as specified in `connect_missing = FALSE`.

``` r
# Create plot for construct x
plot_x <- plot_trajectories(data = data_bi_lcsm,
                            id_var = "id", 
                            var_list = c("x1", "x2", "x3", "x4", "x5", 
                                         "x6", "x7", "x8", "x9", "x10"),
                            xlab = "Time", ylab = "X Score",
                            connect_missing = FALSE, 
                            random_sample_frac = 0.3)

# Create plot for construct y
plot_y <- plot_trajectories(data = data_bi_lcsm,
                            id_var = "id", 
                            var_list = c("y1", "y2", "y3", "y4", "y5", 
                                        "y6", "y7", "y8", "y9", "y10"),
                            xlab = "Time", ylab = "Y Score",
                            connect_missing = FALSE, 
                            random_sample_frac = 0.3)

# Arrange plots next to each other using ggpubr::ggarrange()
ggpubr::ggarrange(plot_x,
                  plot_y,
                  labels = c("a", "b"))
#> Warning: Removed 72 rows containing missing values (geom_point).
#> Warning: Removed 18 rows containing missing values (geom_path).
#> Warning: Removed 154 rows containing missing values (geom_point).
#> Warning: Removed 27 rows containing missing values (geom_path).
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

### 2\. Fit LCS models

In a first step the functions `specify_uni_lcsm()` and
`specify_bi_lcsm()` are used to specify the lavaan syntax for a specific
LCS model. The functions `fit_uni_lcsm()` and `fit_bi_lcsm()` are
running specifying the syntax before passing it on to lavaan.

The following table descibes some of the different model specifications
that the `model` arguments can take. More detail can be found in the
help files `help(fit_uni_lcsm)`.

#### 2.1. Fit univariate LCS models

| Model specification | Description                     |
| :------------------ | :------------------------------ |
| alpha\_constant     | Constant change factor          |
| beta                | Proportional change factor      |
| phi                 | Autoregression of change scores |

Here is the syntax to specify a generic univariate latent change score
model

``` r
specify_uni_lcsm(timepoints = 5,
                 var = "x",  
                 change_letter = "j",
                 model = list(alpha_constant = TRUE, 
                              beta = TRUE, 
                              phi = TRUE))
```

<details>

<summary>Click here to see the lavaan syntax specified above.</summary>

<p>

    # Specify latent true scores 
    lx1 =~ 1 * x1 
    lx2 =~ 1 * x2 
    lx3 =~ 1 * x3 
    lx4 =~ 1 * x4 
    lx5 =~ 1 * x5 
    # Specify mean of latent true scores 
    lx1 ~ gamma_lx1 * 1 
    lx2 ~ 0 * 1 
    lx3 ~ 0 * 1 
    lx4 ~ 0 * 1 
    lx5 ~ 0 * 1 
    # Specify variance of latent true scores 
    lx1 ~~ sigma2_lx1 * lx1 
    lx2 ~~ 0 * lx2 
    lx3 ~~ 0 * lx3 
    lx4 ~~ 0 * lx4 
    lx5 ~~ 0 * lx5 
    # Specify intercept of obseved scores 
    x1 ~ 0 * 1 
    x2 ~ 0 * 1 
    x3 ~ 0 * 1 
    x4 ~ 0 * 1 
    x5 ~ 0 * 1 
    # Specify variance of observed scores 
    x1 ~~ sigma2_ux * x1 
    x2 ~~ sigma2_ux * x2 
    x3 ~~ sigma2_ux * x3 
    x4 ~~ sigma2_ux * x4 
    x5 ~~ sigma2_ux * x5 
    # Specify autoregressions of latent variables 
    lx2 ~ 1 * lx1 
    lx3 ~ 1 * lx2 
    lx4 ~ 1 * lx3 
    lx5 ~ 1 * lx4 
    # Specify latent change scores 
    dx2 =~ 1 * lx2 
    dx3 =~ 1 * lx3 
    dx4 =~ 1 * lx4 
    dx5 =~ 1 * lx5 
    # Specify latent change scores means 
    dx2 ~ 0 * 1 
    dx3 ~ 0 * 1 
    dx4 ~ 0 * 1 
    dx5 ~ 0 * 1 
    # Specify latent change scores variances 
    dx2 ~~ 0 * dx2 
    dx3 ~~ 0 * dx3 
    dx4 ~~ 0 * dx4 
    dx5 ~~ 0 * dx5 
    # Specify constant change factor 
    j2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 
    # Specify constant change factor mean 
    j2 ~ alpha_j2 * 1 
    # Specify constant change factor variance 
    j2 ~~ sigma2_j2 * j2 
    # Specify constant change factor covariance with the initial true score 
    j2 ~~ sigma_j2lx1 * lx1
    # Specify proportional change component 
    dx2 ~ beta_x * lx1 
    dx3 ~ beta_x * lx2 
    dx4 ~ beta_x * lx3 
    dx5 ~ beta_x * lx4 
    # Specify autoregression of change score 
    dx3 ~ phi_x * dx2 
    dx4 ~ phi_x * dx3 
    dx5 ~ phi_x * dx4 

</p>

</details>

The following code shows how to fit a univariate LCS model using the
sample data set `data_uni_lcsm`.

``` r
# Fit univariate latent change score model
fit_uni_lcsm(data = data_uni_lcsm, 
             var =  c("x1", "x2", "x3", "x4", "x5",
                      "x6", "x7", "x8", "x9", "x10"),
             model = list(alpha_constant = TRUE, 
                          beta = FALSE, 
                          phi = TRUE))
#> lavaan 0.6-5 ended normally after 66 iterations
#> 
#>   Estimator                                         ML
#>   Optimization method                           NLMINB
#>   Number of free parameters                         23
#>   Number of equality constraints                    16
#>   Row rank of the constraints matrix                16
#>                                                       
#>   Number of observations                           500
#>   Number of missing patterns                       273
#>                                                       
#> Model Test User Model:
#>                                               Standard      Robust
#>   Test Statistic                                75.389      74.400
#>   Degrees of freedom                                58          58
#>   P-value (Chi-square)                           0.062       0.072
#>   Scaling correction factor                                  1.013
#>     for the Yuan-Bentler correction (Mplus variant)
```

It is also possible to show the lavaan syntax that was created to fit
the model by the function `specify_uni_lcsm()`. The lavaan syntax
includes comments describing some parts of the syntax in more detail.

``` r
# Fit univariate latent change score model
syntax <- fit_uni_lcsm(data = data_uni_lcsm, 
                       var =  c("x1", "x2", "x3", "x4", "x5",
                                "x6", "x7", "x8", "x9", "x10"),
                       model = list(alpha_constant = TRUE, 
                                    beta = FALSE, 
                                    phi = TRUE),
                      return_lavaan_syntax = TRUE)
```

<details>

<summary>Click here to see the lavaan syntax specified in
<code>syntax</code>.</summary>

<p>

    # Specify latent true scores 
    lx1 =~ 1 * x1 
    lx2 =~ 1 * x2 
    lx3 =~ 1 * x3 
    lx4 =~ 1 * x4 
    lx5 =~ 1 * x5 
    lx6 =~ 1 * x6 
    lx7 =~ 1 * x7 
    lx8 =~ 1 * x8 
    lx9 =~ 1 * x9 
    lx10 =~ 1 * x10 
    # Specify mean of latent true scores 
    lx1 ~ gamma_lx1 * 1 
    lx2 ~ 0 * 1 
    lx3 ~ 0 * 1 
    lx4 ~ 0 * 1 
    lx5 ~ 0 * 1 
    lx6 ~ 0 * 1 
    lx7 ~ 0 * 1 
    lx8 ~ 0 * 1 
    lx9 ~ 0 * 1 
    lx10 ~ 0 * 1 
    # Specify variance of latent true scores 
    lx1 ~~ sigma2_lx1 * lx1 
    lx2 ~~ 0 * lx2 
    lx3 ~~ 0 * lx3 
    lx4 ~~ 0 * lx4 
    lx5 ~~ 0 * lx5 
    lx6 ~~ 0 * lx6 
    lx7 ~~ 0 * lx7 
    lx8 ~~ 0 * lx8 
    lx9 ~~ 0 * lx9 
    lx10 ~~ 0 * lx10 
    # Specify intercept of obseved scores 
    x1 ~ 0 * 1 
    x2 ~ 0 * 1 
    x3 ~ 0 * 1 
    x4 ~ 0 * 1 
    x5 ~ 0 * 1 
    x6 ~ 0 * 1 
    x7 ~ 0 * 1 
    x8 ~ 0 * 1 
    x9 ~ 0 * 1 
    x10 ~ 0 * 1 
    # Specify variance of observed scores 
    x1 ~~ sigma2_ux * x1 
    x2 ~~ sigma2_ux * x2 
    x3 ~~ sigma2_ux * x3 
    x4 ~~ sigma2_ux * x4 
    x5 ~~ sigma2_ux * x5 
    x6 ~~ sigma2_ux * x6 
    x7 ~~ sigma2_ux * x7 
    x8 ~~ sigma2_ux * x8 
    x9 ~~ sigma2_ux * x9 
    x10 ~~ sigma2_ux * x10 
    # Specify autoregressions of latent variables 
    lx2 ~ 1 * lx1 
    lx3 ~ 1 * lx2 
    lx4 ~ 1 * lx3 
    lx5 ~ 1 * lx4 
    lx6 ~ 1 * lx5 
    lx7 ~ 1 * lx6 
    lx8 ~ 1 * lx7 
    lx9 ~ 1 * lx8 
    lx10 ~ 1 * lx9 
    # Specify latent change scores 
    dx2 =~ 1 * lx2 
    dx3 =~ 1 * lx3 
    dx4 =~ 1 * lx4 
    dx5 =~ 1 * lx5 
    dx6 =~ 1 * lx6 
    dx7 =~ 1 * lx7 
    dx8 =~ 1 * lx8 
    dx9 =~ 1 * lx9 
    dx10 =~ 1 * lx10 
    # Specify latent change scores means 
    dx2 ~ 0 * 1 
    dx3 ~ 0 * 1 
    dx4 ~ 0 * 1 
    dx5 ~ 0 * 1 
    dx6 ~ 0 * 1 
    dx7 ~ 0 * 1 
    dx8 ~ 0 * 1 
    dx9 ~ 0 * 1 
    dx10 ~ 0 * 1 
    # Specify latent change scores variances 
    dx2 ~~ 0 * dx2 
    dx3 ~~ 0 * dx3 
    dx4 ~~ 0 * dx4 
    dx5 ~~ 0 * dx5 
    dx6 ~~ 0 * dx6 
    dx7 ~~ 0 * dx7 
    dx8 ~~ 0 * dx8 
    dx9 ~~ 0 * dx9 
    dx10 ~~ 0 * dx10 
    # Specify constant change factor 
    g2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 + 1 * dx6 + 1 * dx7 + 1 * dx8 + 1 * dx9 + 1 * dx10 
    # Specify constant change factor mean 
    g2 ~ alpha_g2 * 1 
    # Specify constant change factor variance 
    g2 ~~ sigma2_g2 * g2 
    # Specify constant change factor covariance with the initial true score 
    g2 ~~ sigma_g2lx1 * lx1
    # Specify autoregression of change score 
    dx3 ~ phi_x * dx2 
    dx4 ~ phi_x * dx3 
    dx5 ~ phi_x * dx4 
    dx6 ~ phi_x * dx5 
    dx7 ~ phi_x * dx6 
    dx8 ~ phi_x * dx7 
    dx9 ~ phi_x * dx8 
    dx10 ~ phi_x * dx9 

</p>

</details>

#### 2.2. Fit bivariate LCS models

To estimate coupling parameters for bivariate LCSM, the argument
`coupling` from the `fit_bi_lcsm()` function can take the following
specifications. More detail can be found in the help files
`help(fit_bi_lcsm)`.

| Coupling specification   | Description                                           |
| :----------------------- | :---------------------------------------------------- |
| coupling\_piecewise      | Piecewise coupling parameters                         |
| coupling\_piecewise\_num | Changepoint of piecewise coupling parameters          |
| delta\_con\_xy           | Change score x (t) determined by true score y (t)     |
| delta\_con\_yx           | Change score y (t) determined by true score x (t)     |
| delta\_lag\_xy           | Change score x (t) determined by true score y (t-1)   |
| delta\_lag\_yx           | Change score y (t) determined by true score x (t-1)   |
| xi\_con\_xy              | Change score x (t) determined by change score y (t)   |
| xi\_con\_yx              | Change score y (t) determined by change score x (t)   |
| xi\_lag\_xy              | Change score x (t) determined by change score y (t-1) |
| xi\_lag\_yx              | Change score y (t) determined by change score x (t-1) |

``` r
fit_bi_lcsm(data = data_bi_lcsm, 
            var_x = c("x1", "x2", "x3", "x4", "x5",
                      "x6", "x7", "x8", "x9", "x10"),
            var_y = c("y1", "y2", "y3", "y4", "y5", 
                      "y6", "y7", "y8", "y9", "y10"),
            model_x = list(alpha_constant = TRUE, 
                           beta = TRUE, 
                           phi = FALSE),
            model_y = list(alpha_constant = TRUE, 
                           beta = TRUE, 
                           phi = TRUE),
            coupling = list(delta_lag_xy = TRUE, 
                            xi_lag_yx = TRUE))
#> lavaan 0.6-5 ended normally after 118 iterations
#> 
#>   Estimator                                         ML
#>   Optimization method                           NLMINB
#>   Number of free parameters                         87
#>   Number of equality constraints                    65
#>   Row rank of the constraints matrix                65
#>                                                       
#>   Number of observations                           500
#>   Number of missing patterns                       210
#>                                                       
#> Model Test User Model:
#>                                               Standard      Robust
#>   Test Statistic                               191.851     193.021
#>   Degrees of freedom                               208         208
#>   P-value (Chi-square)                           0.782       0.764
#>   Scaling correction factor                                  0.994
#>     for the Yuan-Bentler correction (Mplus variant)
```

### 3\. Extract fit statistics and parmeters

The functions XXX and YYY can be used to …

``` r
# First create a lavaan object
bi_lcsm_01 <- fit_bi_lcsm(data = data_bi_lcsm, 
                          var_x = c("x1", "x2", "x3", "x4", "x5",
                                    "x6", "x7", "x8", "x9", "x10"),
                          var_y = c("y1", "y2", "y3", "y4", "y5", 
                                    "y6", "y7", "y8", "y9", "y10"),
                         model_x = list(alpha_constant = TRUE, 
                                        beta = TRUE, 
                                        phi = FALSE),
                         model_y = list(alpha_constant = TRUE, 
                                        beta = TRUE, 
                                        phi = TRUE),
                         coupling = list(delta_lag_xy = TRUE, 
                                         xi_lag_yx = TRUE))

# Now extract parameter estimates                           
param_bi_lcsm_01 <- extract_param(bi_lcsm_01)[ ,1:7]

# Print table of parameter estimates
kable(param_bi_lcsm_01)
```

| label          |    estimate | std.error |    statistic |   p.value |    conf.low |   conf.high |
| :------------- | ----------: | --------: | -----------: | --------: | ----------: | ----------: |
| gamma\_lx1     |  21.0657621 | 0.0358148 |  588.1867011 | 0.0000000 |  20.9955665 |  21.1359577 |
| sigma2\_lx1    |   0.4926145 | 0.0365295 |   13.4853836 | 0.0000000 |   0.4210180 |   0.5642110 |
| sigma2\_ux     |   0.2009720 | 0.0044363 |   45.3012584 | 0.0000000 |   0.1922770 |   0.2096671 |
| alpha\_g2      | \-0.3091272 | 0.0529838 |  \-5.8343717 | 0.0000000 | \-0.4129735 | \-0.2052808 |
| sigma2\_g2     |   0.3946950 | 0.0275426 |   14.3303528 | 0.0000000 |   0.3407125 |   0.4486775 |
| sigma\_g2lx1   |   0.1549412 | 0.0220816 |    7.0167722 | 0.0000000 |   0.1116622 |   0.1982203 |
| beta\_x        | \-0.1060129 | 0.0034400 | \-30.8180341 | 0.0000000 | \-0.1127552 | \-0.0992707 |
| gamma\_ly1     |   5.0248664 | 0.0290815 |  172.7858133 | 0.0000000 |   4.9678677 |   5.0818650 |
| sigma2\_ly1    |   0.2083415 | 0.0191845 |   10.8599098 | 0.0000000 |   0.1707407 |   0.2459424 |
| sigma2\_uy     |   0.1927999 | 0.0048566 |   39.6983538 | 0.0000000 |   0.1832811 |   0.2023187 |
| alpha\_j2      | \-0.2029207 | 0.0388953 |  \-5.2171080 | 0.0000002 | \-0.2791540 | \-0.1266874 |
| sigma2\_j2     |   0.0929112 | 0.0078963 |   11.7664417 | 0.0000000 |   0.0774348 |   0.1083877 |
| sigma\_j2ly1   |   0.0169689 | 0.0078718 |    2.1556533 | 0.0311107 |   0.0015404 |   0.0323975 |
| beta\_y        | \-0.1969627 | 0.0049786 | \-39.5618836 | 0.0000000 | \-0.2067205 | \-0.1872048 |
| phi\_y         |   0.1439509 | 0.0290047 |    4.9630121 | 0.0000007 |   0.0871027 |   0.2007992 |
| sigma\_su      |   0.0085980 | 0.0033308 |    2.5813637 | 0.0098411 |   0.0020698 |   0.0151263 |
| sigma\_ly1lx1  |   0.1848025 | 0.0207529 |    8.9048938 | 0.0000000 |   0.1441276 |   0.2254775 |
| sigma\_g2ly1   |   0.0721028 | 0.0162510 |    4.4368113 | 0.0000091 |   0.0402514 |   0.1039543 |
| sigma\_j2lx1   |   0.0934682 | 0.0118082 |    7.9155160 | 0.0000000 |   0.0703245 |   0.1166119 |
| sigma\_j2g2    |   0.0054737 | 0.0118264 |    0.4628345 | 0.6434830 | \-0.0177056 |   0.0286530 |
| delta\_lag\_xy |   0.1399998 | 0.0058733 |   23.8368185 | 0.0000000 |   0.1284885 |   0.1515112 |
| xi\_lag\_yx    |   0.3602020 | 0.0373872 |    9.6343747 | 0.0000000 |   0.2869245 |   0.4334796 |

### 4\. Plot simplified path diagrams of LCS models

Work in progress\!

### 5\. Simulate data

The functions `sim_uni_lcsm` and `sim_bi_lcsm` simulate data based on
some some parameters that can be specified.

``` r
# Simulate some data 
sim_uni_lcsm(timepoints = 5, 
             model = list(alpha_constant = TRUE, beta = FALSE, phi = TRUE), 
             model_param = list(gamma_lx1 = 21, 
                                sigma2_lx1 = 1.5,
                                sigma2_ux = 0.2,
                                alpha_j2 = -0.93,
                                sigma2_j2 = 0.1,
                                sigma_j2lx1 = 0.2,
                                phi_x = 0.3),
             sample.nobs = 1000,
             na_pct = 0.3)
#> Parameter estimates for the data simulation are taken from the argument 'model_param'.
#> All parameter estimates for the LCS model have been specified in the argument 'model_param'.
#> # A tibble: 1,000 x 6
#>       id    x1    x2    x3    x4    x5
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1     1  20.3  19.4  18.2  17.0  NA  
#>  2     2  21.0  20.1  17.8  15.2  14.3
#>  3     3  NA    NA    15.1  13.2  NA  
#>  4     4  21.8  21.0  21.4  20.4  NA  
#>  5     5  18.3  NA    NA    13.3  NA  
#>  6     6  20.5  20.7  19.6  19.2  17.7
#>  7     7  22.7  NA    NA    NA    18.1
#>  8     8  20.4  19.2  NA    16.1  14.7
#>  9     9  NA    23.1  22.8  22.2  21.7
#> 10    10  21.7  20.6  21.0  20.6  NA  
#> # … with 990 more rows
```

It is also possible to return the lavaan syntax instead of simulating
data for further manual specifications. The modified object could then
be used to simulate data using `lavaan::simulateData()`.

``` r
# Return lavaan syntax based on the following argument specifications
simsyntax <- sim_bi_lcsm(timepoints = 5, 
                         model_x = list(alpha_constant = TRUE, beta = TRUE, phi = FALSE),
                         model_x_param = list(gamma_lx1 = 21,
                                              sigma2_lx1 = .5,
                                              sigma2_ux = .2,
                                              alpha_g2 = -.4,
                                              sigma2_g2 = .4,
                                              sigma_g2lx1 = .2,
                                              beta_x = -.1),
                         model_y = list(alpha_constant = TRUE, beta = TRUE, phi = TRUE),
                         model_y_param = list(gamma_ly1 = 5,
                                              sigma2_ly1 = .2,
                                              sigma2_uy = .2,
                                              alpha_j2 = -.2,
                                              sigma2_j2 = .1,
                                              sigma_j2ly1 = .02,
                                              beta_y = -.2,
                                              phi_y = .1),
                         coupling = list(delta_lag_xy = TRUE, 
                                         xi_lag_yx = TRUE),
                         coupling_param = list(sigma_su = .01,
                                               sigma_ly1lx1 = .2,
                                               sigma_g2ly1 = .1,
                                               sigma_j2lx1 = .1,
                                               sigma_j2g2 = .01,
                                               delta_lag_xy = .13,
                                               xi_lag_yx = .4),
                         return_lavaan_syntax = TRUE)
```

<details>

<summary>Click here to see the lavaan syntax specified in
<code>simsyntax</code>.</summary>

<p>

    # Specify parameters for construct x ----
    # Specify latent true scores 
    lx1 =~ 1 * x1 
    lx2 =~ 1 * x2 
    lx3 =~ 1 * x3 
    lx4 =~ 1 * x4 
    lx5 =~ 1 * x5 
    # Specify mean of latent true scores 
    lx1 ~ 21 * 1 
    lx2 ~ 0 * 1 
    lx3 ~ 0 * 1 
    lx4 ~ 0 * 1 
    lx5 ~ 0 * 1 
    # Specify variance of latent true scores 
    lx1 ~~ 0.5 * lx1 
    lx2 ~~ 0 * lx2 
    lx3 ~~ 0 * lx3 
    lx4 ~~ 0 * lx4 
    lx5 ~~ 0 * lx5 
    # Specify intercept of obseved scores 
    x1 ~ 0 * 1 
    x2 ~ 0 * 1 
    x3 ~ 0 * 1 
    x4 ~ 0 * 1 
    x5 ~ 0 * 1 
    # Specify variance of observed scores 
    x1 ~~ 0.2 * x1 
    x2 ~~ 0.2 * x2 
    x3 ~~ 0.2 * x3 
    x4 ~~ 0.2 * x4 
    x5 ~~ 0.2 * x5 
    # Specify autoregressions of latent variables 
    lx2 ~ 1 * lx1 
    lx3 ~ 1 * lx2 
    lx4 ~ 1 * lx3 
    lx5 ~ 1 * lx4 
    # Specify latent change scores 
    dx2 =~ 1 * lx2 
    dx3 =~ 1 * lx3 
    dx4 =~ 1 * lx4 
    dx5 =~ 1 * lx5 
    # Specify latent change scores means 
    dx2 ~ 0 * 1 
    dx3 ~ 0 * 1 
    dx4 ~ 0 * 1 
    dx5 ~ 0 * 1 
    # Specify latent change scores variances 
    dx2 ~~ 0 * dx2 
    dx3 ~~ 0 * dx3 
    dx4 ~~ 0 * dx4 
    dx5 ~~ 0 * dx5 
    # Specify constant change factor 
    g2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 
    # Specify constant change factor mean 
    g2 ~ -0.4 * 1 
    # Specify constant change factor variance 
    g2 ~~ 0.4 * g2 
    # Specify constant change factor covariance with the initial true score 
    g2 ~~ 0.2 * lx1
    # Specify proportional change component 
    dx2 ~ -0.1 * lx1 
    dx3 ~ -0.1 * lx2 
    dx4 ~ -0.1 * lx3 
    dx5 ~ -0.1 * lx4 
    # Specify parameters for construct y ----
    # Specify latent true scores 
    ly1 =~ 1 * y1 
    ly2 =~ 1 * y2 
    ly3 =~ 1 * y3 
    ly4 =~ 1 * y4 
    ly5 =~ 1 * y5 
    # Specify mean of latent true scores 
    ly1 ~ 5 * 1 
    ly2 ~ 0 * 1 
    ly3 ~ 0 * 1 
    ly4 ~ 0 * 1 
    ly5 ~ 0 * 1 
    # Specify variance of latent true scores 
    ly1 ~~ 0.2 * ly1 
    ly2 ~~ 0 * ly2 
    ly3 ~~ 0 * ly3 
    ly4 ~~ 0 * ly4 
    ly5 ~~ 0 * ly5 
    # Specify intercept of obseved scores 
    y1 ~ 0 * 1 
    y2 ~ 0 * 1 
    y3 ~ 0 * 1 
    y4 ~ 0 * 1 
    y5 ~ 0 * 1 
    # Specify variance of observed scores 
    y1 ~~ 0.2 * y1 
    y2 ~~ 0.2 * y2 
    y3 ~~ 0.2 * y3 
    y4 ~~ 0.2 * y4 
    y5 ~~ 0.2 * y5 
    # Specify autoregressions of latent variables 
    ly2 ~ 1 * ly1 
    ly3 ~ 1 * ly2 
    ly4 ~ 1 * ly3 
    ly5 ~ 1 * ly4 
    # Specify latent change scores 
    dy2 =~ 1 * ly2 
    dy3 =~ 1 * ly3 
    dy4 =~ 1 * ly4 
    dy5 =~ 1 * ly5 
    # Specify latent change scores means 
    dy2 ~ 0 * 1 
    dy3 ~ 0 * 1 
    dy4 ~ 0 * 1 
    dy5 ~ 0 * 1 
    # Specify latent change scores variances 
    dy2 ~~ 0 * dy2 
    dy3 ~~ 0 * dy3 
    dy4 ~~ 0 * dy4 
    dy5 ~~ 0 * dy5 
    # Specify constant change factor 
    j2 =~ 1 * dy2 + 1 * dy3 + 1 * dy4 + 1 * dy5 
    # Specify constant change factor mean 
    j2 ~ -0.2 * 1 
    # Specify constant change factor variance 
    j2 ~~ 0.1 * j2 
    # Specify constant change factor covariance with the initial true score 
    j2 ~~ 0.02 * ly1
    # Specify proportional change component 
    dy2 ~ -0.2 * ly1 
    dy3 ~ -0.2 * ly2 
    dy4 ~ -0.2 * ly3 
    dy5 ~ -0.2 * ly4 
    # Specify autoregression of change score 
    dy3 ~ 0.1 * dy2 
    dy4 ~ 0.1 * dy3 
    dy5 ~ 0.1 * dy4 
    # Specify residual covariances 
    x1 ~~ 0.01 * y1 
    x2 ~~ 0.01 * y2 
    x3 ~~ 0.01 * y3 
    x4 ~~ 0.01 * y4 
    x5 ~~ 0.01 * y5 
    # Specify covariances betweeen specified change components (alpha) and intercepts (initial latent true scores lx1 and ly1) ----
    # Specify covariance of intercepts 
    lx1 ~~ 0.2 * ly1 
    # Specify covariance of constant change and intercept within the same construct 
    ly1 ~~ 0.1 * g2 
    # Specify covariance of constant change and intercept within the same construct 
    lx1 ~~ 0.1 * j2 
    # Specify covariance of constant change factors between constructs 
    g2 ~~ 0.01 * j2 
    # Specify between-construct coupling parameters ----
    # Change score x (t) is determined by true score y (t-1)  
    dx2 ~ 0.13 * ly1 
    dx3 ~ 0.13 * ly2 
    dx4 ~ 0.13 * ly3 
    dx5 ~ 0.13 * ly4 
    # Change score y (t) is determined by change score x (t-1)  
    dy3 ~ 0.4 * dx2 
    dy4 ~ 0.4 * dx3 
    dy5 ~ 0.4 * dx4 

</p>

</details>

## Overview of estimated LCS model parameters

### Univariate LCS models

Depending on the specified model, the following parameters can be
estimated for **univariate** LCS
models:

| Parameter    | Description                                                    |
| :----------- | :------------------------------------------------------------- |
| gamma\_lx1   | Mean of latent true scores x (Intercept)                       |
| sigma2\_lx1  | Variance of latent true scores x                               |
| sigma2\_ux   | Variance of observed scores x                                  |
| alpha\_g2    | Mean of change factor (g2)                                     |
| alpha\_g3    | Mean of change factor (g3)                                     |
| sigma2\_g2   | Variance of change factor (g2)                                 |
| sigma2\_g3   | Variance of change factor (g3)                                 |
| sigma\_g2lx1 | Covariance of change factor (g2) with the initial true score x |
| sigma\_g3lx1 | Covariance of change factor (g3) with the initial true score x |
| sigma\_g2g3  | Covariance of change factors within construct x                |
| phi\_x       | Autoregression of change scores x                              |

### Bivariate LCS models

For bivariate LCS models, estimated parameters can be categorised into
(1) **Construct X**, (2) **Construct Y**, and (3) **Coupling between X
and
Y**.

| Parameter           | Description                                                            |
| :------------------ | :--------------------------------------------------------------------- |
| **Construct X**     |                                                                        |
| gamma\_lx1          | Mean of latent true scores x (Intercept)                               |
| sigma2\_lx1         | Variance of latent true scores x                                       |
| sigma2\_ux          | Variance of observed scores x                                          |
| alpha\_g2           | Mean of change factor (g2)                                             |
| alpha\_g3           | Mean of change factor (g3)                                             |
| sigma2\_g2          | Variance of change factor (g2)                                         |
| sigma2\_g3          | Variance of change factor (g3)                                         |
| sigma\_g2lx1        | Covariance of change factor (g2) with the initial true score x (lx1)   |
| sigma\_g3lx1        | Covariance of change factor (g3) with the initial true score x (lx1)   |
| sigma\_g2g3         | Covariance of change factors within construct x                        |
| phi\_x              | Autoregression of change scores x                                      |
| **Construct Y**     |                                                                        |
| gamma\_ly1          | Mean of latent true scores y (Intercept)                               |
| sigma2\_ly1         | Variance of latent true scores y                                       |
| sigma2\_uy          | Variance of observed scores y                                          |
| alpha\_j2           | Mean of change factor (j2)                                             |
| alpha\_j3           | Mean of change factor (j3)                                             |
| sigma2\_j2          | Variance of change factor (j2)                                         |
| sigma2\_j3          | Variance of change factor (j3)                                         |
| sigma\_j2ly1        | Covariance of change factor (j2) with the initial true score y (ly1)   |
| sigma\_j3ly1        | Covariance of change factor (j3) with the initial true score y (ly1)   |
| sigma\_j2j3         | Covariance of change factors within construct y                        |
| phi\_y              | Autoregression of change scores y                                      |
| **Coupeling X & Y** |                                                                        |
| sigma\_su           | Covariance of residuals x and y                                        |
| sigma\_ly1lx1       | Covariance of intercepts x and y                                       |
| sigma\_g2ly1        | Covariance of change factor x (g2) with the initial true score y (ly1) |
| sigma\_g3ly1        | Covariance of change factor x (g3) with the initial true score y (ly1) |
| sigma\_j2lx1        | Covariance of change factor y (j2) with the initial true score x (lx1) |
| sigma\_j3lx1        | Covariance of change factor y (j3) with the initial true score x (lx1) |
| sigma\_j2g2         | Covariance of change factors y (j2) and x (g2)                         |
| sigma\_j2g3         | Covariance of change factors y (j2) and x (g3)                         |
| sigma\_j3g2         | Covariance of change factors y (j3) and x (g2)                         |
| delta\_con\_xy      | Change score x (t) determined by true score y (t)                      |
| delta\_con\_yx      | Change score y (t) determined by true score x (t)                      |
| delta\_lag\_xy      | Change score x (t) determined by true score y (t-1)                    |
| delta\_lag\_yx      | Change score y (t) determined by true score x (t-1)                    |
| xi\_con\_xy         | Change score x (t) determined by change score y (t)                    |
| xi\_con\_yx         | Change score y (t) determined by change score x (t)                    |
| xi\_lag\_xy         | Change score x (t) determined by change score y (t-1)                  |
| xi\_lag\_yx         | Change score y (t) determined by change score x (t-1)                  |
