# Fit bivariate latent change score models

Fit bivariate latent change score models.

## Usage

``` r
fit_bi_lcsm(
  data,
  var_x,
  var_y,
  model_x,
  model_y,
  coupling,
  add = NULL,
  mimic = "Mplus",
  estimator = "MLR",
  missing = "FIML",
  return_lavaan_syntax = FALSE,
  ...
)
```

## Arguments

- data:

  Wide dataset.

- var_x:

  List of variables measuring one construct of the model.

- var_y:

  List of variables measuring another construct of the model.

- model_x:

  List of model specifications (logical) for variables specified in
  `var_x`.

  - `alpha_constant`: Constant change factor

  - `alpha_piecewise`: Piecewise constant change factors

  - `alpha_piecewise_num`: Changepoint of piecewise constant change
    factors. In an example with 10 repeated measurements, setting
    `alpha_piecewise_num` to 5 would estimate two seperate constant
    change factors, a first one for changes up to timepoint 5, and a
    second one for changes from timepoint 5 onwards (in this example
    timepoint 10).

  - `alpha_linear`: Linear change factor

  - `beta`: Proportional change factor

  - `phi`: Autoregression of change scores

- model_y:

  List of model specifications for variables specified in `var_y`.

  - `alpha_constant`: Constant change factor

  - `alpha_piecewise`: Piecewise constant change factors

  - `alpha_piecewise_num`: Changepoint of piecewise constant change
    factors. In an example with 10 repeated measurements, setting
    `alpha_piecewise_num` to 5 would estimate two seperate constant
    change factors, a first one for changes up to timepoint 5, and a
    second one for changes from timepoint 5 onwards (in this example
    timepoint 10).

  - `alpha_linear`: Linear change factor

  - `beta`: Proportional change factor

  - `phi`: Autoregression of change scores

- coupling:

  List of model specifications (logical) for coupling parameters.

  - `coupling_piecewise`: Piecewise coupling parameters

  - `coupling_piecewise_num`: Changepoint of piecewise coupling
    parameters

  - `delta_xy`: True score y predicting subsequent change score x

  - `delta_yx`: True score x predicting subsequent change score y

  - `xi_xy`: Change score y predicting subsequent change score x

  - `xi_yx`: Change score x predicting subsequent change score y

- add:

  String, lavaan syntax to be added to the model

- mimic:

  See `mimic` argument in
  [lavOptions](https://rdrr.io/pkg/lavaan/man/lavOptions.html).

- estimator:

  See `estimator` argument in
  [lavOptions](https://rdrr.io/pkg/lavaan/man/lavOptions.html).

- missing:

  See `missing` argument in
  [lavOptions](https://rdrr.io/pkg/lavaan/man/lavOptions.html).

- return_lavaan_syntax:

  Logical, if TRUE return the lavaan syntax used for simulating data. To
  make it look beautiful use the function
  [cat](https://rdrr.io/r/base/cat.html).

- ...:

  Additional arguments to be passed to
  [lavOptions](https://rdrr.io/pkg/lavaan/man/lavOptions.html).

## Value

This function returns a lavaan class object.

## References

Ghisletta, P., & McArdle, J. J. (2012). Latent Curve Models and Latent
Change Score Models Estimated in R. Structural Equation Modeling: A
Multidisciplinary Journal, 19(4), 651–682.
[doi:10.1146/annurev.psych.60.110707.163612](https://doi.org/10.1146/annurev.psych.60.110707.163612)
.

Grimm, K. J., Ram, N., & Estabrook, R. (2017). Growth
Modeling—Structural Equation and Multilevel Modeling Approaches. New
York: The Guilford Press.

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
# Fit 
fit_bi_lcsm(data = data_bi_lcsm, 
            var_x = names(data_bi_lcsm)[2:4], 
            var_y = names(data_bi_lcsm)[12:14],
            model_x = list(alpha_constant = TRUE, 
                           beta = TRUE, 
                           phi = FALSE),
            model_y = list(alpha_constant = TRUE, 
                           beta = TRUE, 
                           phi = TRUE),
            coupling = list(delta_lag_xy = TRUE, 
                            xi_lag_yx = TRUE)
                            )
#> Warning: lavaan->lav_model_vcov():  
#>    The variance-covariance matrix of the estimated parameters (vcov) does not 
#>    appear to be positive definite! The smallest eigenvalue (= 3.047831e-19) 
#>    is close to zero. This may be a symptom that the model is not identified.
#> lavaan 0.7-2 ended normally after 137 iterations
#> 
#>   Estimator                                         ML
#>   Optimization method                           NLMINB
#>   Number of model parameters                        31
#>   Number of equality constraints                     9
#> 
#>   Number of observations                           500
#>   Number of missing patterns                        23
#> 
#> Model Test User Model:
#>                                               Standard      Scaled
#>   Test Statistic                                 6.870       5.971
#>   Degrees of freedom                                 5           5
#>   P-value (Chi-square)                           0.230       0.309
#>   Scaling correction factor                                  1.151
#>     Yuan-Bentler correction (Mplus variant)                       
```
