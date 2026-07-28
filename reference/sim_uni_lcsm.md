# Simulate data from univariate latent change score model parameter estimates

This function simulate data from univariate latent change score model
parameter estimates using
[simulateData](https://rdrr.io/pkg/lavaan/man/simulateData.html).

## Usage

``` r
sim_uni_lcsm(
  timepoints,
  model,
  model_param = NULL,
  var = "x",
  change_letter = "g",
  sample.nobs = 500,
  na_pct = 0,
  seed = NULL,
  ...,
  return_lavaan_syntax = FALSE
)
```

## Arguments

- timepoints:

  See
  [specify_uni_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_uni_lcsm.md)

- model:

  See
  [specify_uni_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_uni_lcsm.md)

- model_param:

  List, specifying parameter estimates for the LCSM that has been
  specified in the argument 'model'

  - **`gamma_lx1`**: Mean of latent true scores x (Intercept),

  - **`sigma2_lx1`**: Variance of latent true scores x,

  - **`sigma2_ux`**: Variance of observed scores x,

  - **`alpha_g2`**: Mean of change factor (g2),

  - **`alpha_g3`**: Mean of change factor (g3),

  - **`sigma2_g2`**: Variance of constant change factor (g2).

  - **`sigma2_g3`**: Variance of constant change factor (g3),

  - **`sigma_g2lx1`**: Covariance of constant change factor (g2) with
    the initial true score x (lx1),

  - **`sigma_g3lx1`**: Covariance of constant change factor (g3) with
    the initial true score x (lx1),

  - **`sigma_g2g3`**: Covariance of change factors (g2 and g2),

  - **`phi_x`**: Autoregression of change scores x.

- var:

  See
  [specify_uni_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_uni_lcsm.md)

- change_letter:

  See
  [specify_uni_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_uni_lcsm.md)

- sample.nobs:

  Numeric, number of cases to be simulated, see
  [specify_uni_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_uni_lcsm.md)

- na_pct:

  Numeric, percentage of random missing values in the simulated dataset
  (0 to 1)

- seed:

  Set seed for data simulation, see
  [simulateData](https://rdrr.io/pkg/lavaan/man/simulateData.html)

- ...:

  Arguments to be passed on to
  [simulateData](https://rdrr.io/pkg/lavaan/man/simulateData.html)

- return_lavaan_syntax:

  Logical, if TRUE return the lavaan syntax used for simulating data. To
  make it look beautiful use the function
  [cat](https://rdrr.io/r/base/cat.html).

## Value

tibble

## Examples

``` r
# Simulate data from univariate LCSM parameters 
sim_uni_lcsm(timepoints = 10, 
             model = list(alpha_constant = TRUE, beta = FALSE, phi = TRUE), 
             model_param = list(gamma_lx1 = 21, 
                                sigma2_lx1 = 1.5,
                                sigma2_ux = .2, 
                                alpha_g2 = -.93,
                                sigma2_g2 = .1,
                                sigma_g2lx1 = .2,
                                phi_x = .2),
             return_lavaan_syntax = FALSE, 
             sample.nobs = 1000,
             na_pct = .3)
#> Parameter estimates for the data simulation are taken from the argument 'model_param'.
#> All parameter estimates for the LCSM have been specified in the argument 'model_param'.
#> # A tibble: 1,000 × 11
#>       id    x1    x2    x3    x4    x5    x6    x7    x8    x9   x10
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1     1  21.7  NA    22.0  NA    20.4  NA    NA   19.5  18.4  17.9 
#>  2     2  19.5  19.1  NA    17.9  16.8  14.9  15.6 14.3  12.9  12.1 
#>  3     3  20.0  19.8  18.2  18.5  17.1  15.2  14.0 NA    12.9  12.7 
#>  4     4  22.3  21.2  21.2  NA    18.2  17.3  15.8 NA    NA    NA   
#>  5     5  21.2  21.3  NA    19.3  NA    18.1  17.0 16.3  15.4  14.3 
#>  6     6  21.0  NA    21.3  NA    19.7  19.4  20.0 19.4  NA    17.9 
#>  7     7  20.7  19.3  17.0  NA    14.3  12.8  11.0  8.54  7.47  5.66
#>  8     8  21.9  NA    NA    NA    15.8  12.6  12.2 11.3   9.99  8.49
#>  9     9  22.1  21.2  20.5  18.8  19.7  18.6  17.6 NA    16.7  NA   
#> 10    10  NA    NA    20.3  19.1  18.3  17.2  14.9 NA    14.4  NA   
#> # ℹ 990 more rows
```
