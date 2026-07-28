# Simulate data from bivariate latent change score model parameter estimates

This function simulate data from bivariate latent change score model
parameter estimates using
[simulateData](https://rdrr.io/pkg/lavaan/man/simulateData.html).

## Usage

``` r
sim_bi_lcsm(
  timepoints,
  model_x,
  model_x_param = NULL,
  model_y,
  model_y_param = NULL,
  coupling,
  coupling_param = NULL,
  sample.nobs = 500,
  na_x_pct = 0,
  na_y_pct = 0,
  seed = NULL,
  ...,
  var_x = "x",
  var_y = "y",
  change_letter_x = "g",
  change_letter_y = "j",
  return_lavaan_syntax = FALSE
)
```

## Arguments

- timepoints:

  See
  [specify_bi_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_bi_lcsm.md)

- model_x:

  See
  [specify_bi_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_bi_lcsm.md)

- model_x_param:

  List, specifying parameter estimates for the LCSM that has been
  specified in the argument '`model_x`':

  - **`gamma_lx1`**: Mean of latent true scores x (Intercept),

  - **`sigma2_lx1`**: Variance of latent true scores x,

  - **`sigma2_ux`**: Variance of observed scores x,

  - **`alpha_g2`**: Mean of change factor (g2),

  - **`alpha_g3`**: Mean of change factor (g3),

  - **`sigma2_g2`**: Variance of change factor (g2).

  - **`sigma2_g3`**: Variance of change factor (g3),

  - **`sigma_g2lx1`**: Covariance of change factor (g2) with the initial
    true score x (lx1),

  - **`sigma_g3lx1`**: Covariance of change factor (g3) with the initial
    true score x (lx1),

  - **`sigma_g2g3`**: Covariance of change factors (g2 and g2),

  - **`phi_x`**: Autoregression of change scores x.

- model_y:

  See
  [specify_bi_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_bi_lcsm.md)

- model_y_param:

  List, specifying parameter estimates for the LCSM that has been
  specified in the argument '`model_y`':

  - **`gamma_ly1`**: Mean of latent true scores y (Intercept),

  - **`sigma2_ly1`**: Variance of latent true scores y,

  - **`sigma2_uy`**: Variance of observed scores y,

  - **`alpha_j2`**: Mean of change factor (j2),

  - **`alpha_j3`**: Mean of change factor (j3),

  - **`sigma2_j2`**: Variance of change factor (j2).

  - **`sigma2_j3`**: Variance of change factor (j3),

  - **`sigma_j2ly1`**: Covariance of change factor (j2) with the initial
    true score x (ly1),

  - **`sigma_j3ly1`**: Covariance of change factor (j3) with the initial
    true score x (ly1),

  - **`sigma_j2j3`**: Covariance of change factors (j2 and j2),

  - **`phi_y`**: Autoregression of change scores y.

- coupling:

  See
  [specify_bi_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_bi_lcsm.md)

- coupling_param:

  List, specifying parameter estimates coupling parameters that have
  been specified in the argument '`coupling`':

  - **`sigma_su`**: Covariance of residuals x and y,

  - **`sigma_ly1lx1`**: Covariance of intercepts x and y,

  - **`sigma_g2ly1`**: Covariance of change factor x (g2) with the
    initial true score y (ly1),

  - **`sigma_g3ly1`**: Covariance of change factor x (g3) with the
    initial true score y (ly1),

  - **`sigma_j2lx1`**: Covariance of change factor y (j2) with the
    initial true score x (lx1),

  - **`sigma_j3lx1`**: Covariance of change factor y (j3) with the
    initial true score x (lx1),

  - **`sigma_j2g2`**: Covariance of change factors y (j2) and x (g2),

  - **`sigma_j2g3`**: Covariance of change factors y (j2) and x (g3),

  - **`sigma_j3g2`**: Covariance of change factors y (j3) and x (g2),,

  - **`delta_con_xy`**: Change score x (t) determined by true score y
    (t),

  - **`delta_con_yx`**: Change score y (t) determined by true score x
    (t),

  - **`delta_lag_xy`**: Change score x (t) determined by true score y
    (t-1),

  - **`delta_lag_yx`**: Change score y (t) determined by true score x
    (t-1),

  - **`xi_con_xy`**: Change score x (t) determined by change score y
    (t),

  - **`xi_con_yx`**: Change score y (t) determined by change score x
    (t),

  - **`xi_lag_xy`**: Change score x (t) determined by change score y
    (t-1),

  - **`xi_lag_yx`**: Change score y (t) determined by change score x
    (t-1)

- sample.nobs:

  Numeric, number of cases to be simulated, see
  [specify_uni_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_uni_lcsm.md)

- na_x_pct:

  Numeric, percentage of random missing values in the simulated dataset
  (0 to 1)

- na_y_pct:

  Numeric, percentage of random missing values in the simulated dataset
  (0 to 1)

- seed:

  Set seed for data simulation, see
  [simulateData](https://rdrr.io/pkg/lavaan/man/simulateData.html)

- ...:

  Arguments to be passed on to
  [simulateData](https://rdrr.io/pkg/lavaan/man/simulateData.html)

- var_x:

  See
  [specify_bi_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_bi_lcsm.md)

- var_y:

  See
  [specify_bi_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_bi_lcsm.md)

- change_letter_x:

  See
  [specify_bi_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_bi_lcsm.md)

- change_letter_y:

  See
  [specify_bi_lcsm](https://milanwiedemann.github.io/lcsm/reference/specify_bi_lcsm.md)

- return_lavaan_syntax:

  Logical, if TRUE return the lavaan syntax used for simulating data. To
  make it look beautiful use the function
  [cat](https://rdrr.io/r/base/cat.html).

## Value

tibble

## References

Ghisletta, P., & McArdle, J. J. (2012). Latent Curve Models and Latent
Change Score Models Estimated in R. Structural Equation Modeling: A
Multidisciplinary Journal, 19(4), 651-682. 10.1080/10705511.2012.713275.

Grimm, K. J., Ram, N., & Estabrook, R. (2017). Growth
Modeling—Structural Equation and Multilevel Modeling Approaches. New
York: The Guilford Press.

Kievit, R. A., Brandmaier, A. M., Ziegler, G., van Harmelen, A.-L., de
Mooij, S. M. M., Moutoussis, M., … Dolan, R. J. (2018). Developmental
cognitive neuroscience using latent change score models: A tutorial and
applications. Developmental Cognitive Neuroscience, 33, 99–117.
[doi:10.1016/j.dcn.2017.11.007](https://doi.org/10.1016/j.dcn.2017.11.007)
.

McArdle, J. J. (2009). Latent variable modeling of differences and
changes with longitudinal data. Annual Review of Psychology, 60(1),
577–605.
[doi:10.1146/annurev.psych.60.110707.163612](https://doi.org/10.1146/annurev.psych.60.110707.163612)
.

Yves Rosseel (2012). lavaan: An R Package for Structural Equation
Modeling. Journal of Statistical Software, 48(2), 1-36.
[doi:10.18637/jss.v048.i02](https://doi.org/10.18637/jss.v048.i02) .

## Examples

``` r
# Simulate data from bivariate LCSM parameters 
sim_bi_lcsm(timepoints = 12, 
            na_x_pct = .05,
            na_y_pct = .1,
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
            coupling_param =list(sigma_su = .01,
                                 sigma_ly1lx1 = .2,
                                 sigma_g2ly1 = .1,
                                 sigma_j2lx1 = .1,
                                 sigma_j2g2 = .01,
                                 delta_lag_xy = .13,
                                 xi_lag_yx = .4),
            return_lavaan_syntax = FALSE)
#> Parameter estimates for the data simulation are taken from the argument 'model_param'.
#> All parameter estimates for the LCSM have been specified in the argument 'model_param'.
#> # A tibble: 500 × 25
#>       id    x1    x2    x3    x4    x5    x6    x7    x8     x9    x10    x11
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>
#>  1     1  21.5  19.2  17.3  14.4  12.3 10.1   8.17  5.80  4.15   2.03   0.227
#>  2     2  19.9  17.2  14.4  12.2  10.3  7.16  4.07  2.00  0.205 -2.57  -4.10 
#>  3     3  20.2  17.8  14.9  13.1  10.2  7.79  5.70  3.54  0.906 -1.77  -2.92 
#>  4     4  21.2  19.4  19.4  17.5  17.4 15.7  14.2  13.7  11.9   11.0    9.70 
#>  5     5  20.5  18.0  16.7  13.6  11.7 10.4   6.85  5.48  4.20   1.11   0.748
#>  6     6  20.7  19.1  18.3  16.6  15.1 14.2  12.5  11.2   8.29   8.07   7.12 
#>  7     7  20.3  19.5  18.0  16.1  14.8 13.3  NA     9.75  9.46   7.73   6.15 
#>  8     8  22.9  22.0  21.6  21.2  19.6 18.5  16.9  17.4  16.1   15.0   14.9  
#>  9     9  21.6  20.6  18.5  16.2  14.4 13.3  11.4  10.2   7.80   6.65   5.21 
#> 10    10  20.6  18.1  15.4  13.6  10.9  8.12  5.85  4.20 NA      0.127 -0.959
#> # ℹ 490 more rows
#> # ℹ 13 more variables: x12 <dbl>, y1 <dbl>, y2 <dbl>, y3 <dbl>, y4 <dbl>,
#> #   y5 <dbl>, y6 <dbl>, y7 <dbl>, y8 <dbl>, y9 <dbl>, y10 <dbl>, y11 <dbl>,
#> #   y12 <dbl>
```
