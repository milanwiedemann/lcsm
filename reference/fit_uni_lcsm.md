# Fit univariate latent change score models

Fit univariate latent change score models.

## Usage

``` r
fit_uni_lcsm(
  data,
  var,
  model,
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

  A data frame in "wide" format, i.e. one column for each measurement
  point and one row for each observation.

- var:

  Vector, specifying the variable names of each measurement point
  sequentially.

- model:

  List of model specifications (logical) for variables specified in
  `var`.

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
Multidisciplinary Journal, 19(4), 651-682. 10.1080/10705511.2012.713275.

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
# Fit univariate latent change score model
fit_uni_lcsm(data = data_uni_lcsm, 
             var = names(data_uni_lcsm)[2:4],
             model = list(alpha_constant = TRUE, 
                          beta = FALSE, 
                          phi = FALSE))
#> Warning: lavaan->lav_data_full():  
#>    some cases are empty and will be ignored: 179 223 239 258 306 359 430.
#> lavaan 0.7-2 ended normally after 62 iterations
#> 
#>   Estimator                                         ML
#>   Optimization method                           NLMINB
#>   Number of model parameters                         8
#>   Number of equality constraints                     2
#> 
#>                                                   Used       Total
#>   Number of observations                           493         500
#>   Number of missing patterns                         7            
#> 
#> Model Test User Model:
#>                                               Standard      Scaled
#>   Test Statistic                                 0.703       0.704
#>   Degrees of freedom                                 3           3
#>   P-value (Chi-square)                           0.873       0.872
#>   Scaling correction factor                                  0.998
#>     Yuan-Bentler correction (Mplus variant)                       
```
