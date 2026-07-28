# Specify lavaan model for bivariate latent change score models

Specify lavaan model for bivariate latent change score models

## Usage

``` r
specify_bi_lcsm(
  timepoints,
  var_x,
  model_x,
  var_y,
  model_y,
  coupling,
  add = NULL,
  change_letter_x = "g",
  change_letter_y = "j"
)
```

## Arguments

- timepoints:

  Number of timepoints.

- var_x:

  Vector, specifying variables measuring one construct of the model.

- model_x:

  List, specifying model specifications (logical) for variables
  specified in `var_x`.

  - `alpha_constant`: Constant change factor

  - `alpha_piecewise`: Piecewise constant change factors

  - `alpha_piecewise_num`: Changepoint of piecewise constant change
    factors

  - `alpha_linear`: Linear change factor

  - `beta`: Proportional change factor

  - `phi`: Autoregression of change scores

- var_y:

  Vector, specifying variables measuring another construct of the model.

- model_y:

  List, specifying model specifications (logical) for variables
  specified in `var_y`.

  - `alpha_constant`: Constant change factor

  - `alpha_piecewise`: Piecewise constant change factors

  - `alpha_piecewise_num`: Changepoint of piecewise constant change
    factors

  - `alpha_linear`: Linear change factor

  - `beta`: Proportional change factor

  - `phi`: Autoregression of change scores

- coupling:

  List, specifying coupling parameters.

  - `coupling_piecewise`: Piecewise coupling parameters

  - `coupling_piecewise_num`: Changepoint of piecewise coupling
    parameters

  - `delta_con_xy`: True score y predicting concurrent change score x

  - `delta_lag_xy`: True score y predicting subsequent change score x

  - `delta_con_yx`: True score x predicting concurrent change score y

  - `delta_lag_yx`: True score x predicting subsequent change score y

  - `xi_con_xy`: Change score y predicting concurrent change score x

  - `xi_lag_xy`: Change score y predicting subsequent change score x

  - `xi_con_yx`: Change score x predicting concurrent change score y

  - `xi_lag_yx`: Change score x predicting subsequent change score y

- add:

  String, lavaan syntax to be added to the model

- change_letter_x:

  String, specifying letter to be used as change factor for construct x
  in lavaan syntax.

- change_letter_y:

  String, specifying letter to be used as change factor for construct y
  in lavaan syntax.

## Value

Lavaan model syntax including comments.

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
# Specify bivariate LCSM
lavaan_bi_lcsm_01 <- specify_bi_lcsm(timepoints = 10, 
                                     var_x = "x",
                                     model_x = list(alpha_constant = TRUE, 
                                                    beta = TRUE, 
                                                    phi = TRUE),
                                     var_y = "y",  
                                     model_y = list(alpha_constant = TRUE, 
                                                    beta = TRUE, 
                                                    phi = TRUE),  
                                     coupling = list(delta_lag_xy = TRUE, 
                                                     delta_lag_yx = TRUE),
                                     change_letter_x = "g",
                                     change_letter_y = "j")

# To look at string simply return the object                                    
lavaan_bi_lcsm_01
#> [1] "# # # # # # # # # # # # # # # # # # # # #\n# Specify parameters for construct x ----\n# # # # # # # # # # # # # # # # # # # # #\n# Specify latent true scores \nlx1 =~ 1 * x1 \nlx2 =~ 1 * x2 \nlx3 =~ 1 * x3 \nlx4 =~ 1 * x4 \nlx5 =~ 1 * x5 \nlx6 =~ 1 * x6 \nlx7 =~ 1 * x7 \nlx8 =~ 1 * x8 \nlx9 =~ 1 * x9 \nlx10 =~ 1 * x10 \n# Specify mean of latent true scores \nlx1 ~ gamma_lx1 * 1 \nlx2 ~ 0 * 1 \nlx3 ~ 0 * 1 \nlx4 ~ 0 * 1 \nlx5 ~ 0 * 1 \nlx6 ~ 0 * 1 \nlx7 ~ 0 * 1 \nlx8 ~ 0 * 1 \nlx9 ~ 0 * 1 \nlx10 ~ 0 * 1 \n# Specify variance of latent true scores \nlx1 ~~ sigma2_lx1 * lx1 \nlx2 ~~ 0 * lx2 \nlx3 ~~ 0 * lx3 \nlx4 ~~ 0 * lx4 \nlx5 ~~ 0 * lx5 \nlx6 ~~ 0 * lx6 \nlx7 ~~ 0 * lx7 \nlx8 ~~ 0 * lx8 \nlx9 ~~ 0 * lx9 \nlx10 ~~ 0 * lx10 \n# Specify intercept of obseved scores \nx1 ~ 0 * 1 \nx2 ~ 0 * 1 \nx3 ~ 0 * 1 \nx4 ~ 0 * 1 \nx5 ~ 0 * 1 \nx6 ~ 0 * 1 \nx7 ~ 0 * 1 \nx8 ~ 0 * 1 \nx9 ~ 0 * 1 \nx10 ~ 0 * 1 \n# Specify variance of observed scores \nx1 ~~ sigma2_ux * x1 \nx2 ~~ sigma2_ux * x2 \nx3 ~~ sigma2_ux * x3 \nx4 ~~ sigma2_ux * x4 \nx5 ~~ sigma2_ux * x5 \nx6 ~~ sigma2_ux * x6 \nx7 ~~ sigma2_ux * x7 \nx8 ~~ sigma2_ux * x8 \nx9 ~~ sigma2_ux * x9 \nx10 ~~ sigma2_ux * x10 \n# Specify autoregressions of latent variables \nlx2 ~ 1 * lx1 \nlx3 ~ 1 * lx2 \nlx4 ~ 1 * lx3 \nlx5 ~ 1 * lx4 \nlx6 ~ 1 * lx5 \nlx7 ~ 1 * lx6 \nlx8 ~ 1 * lx7 \nlx9 ~ 1 * lx8 \nlx10 ~ 1 * lx9 \n# Specify latent change scores \ndx2 =~ 1 * lx2 \ndx3 =~ 1 * lx3 \ndx4 =~ 1 * lx4 \ndx5 =~ 1 * lx5 \ndx6 =~ 1 * lx6 \ndx7 =~ 1 * lx7 \ndx8 =~ 1 * lx8 \ndx9 =~ 1 * lx9 \ndx10 =~ 1 * lx10 \n# Specify latent change scores means \ndx2 ~ 0 * 1 \ndx3 ~ 0 * 1 \ndx4 ~ 0 * 1 \ndx5 ~ 0 * 1 \ndx6 ~ 0 * 1 \ndx7 ~ 0 * 1 \ndx8 ~ 0 * 1 \ndx9 ~ 0 * 1 \ndx10 ~ 0 * 1 \n# Specify latent change scores variances \ndx2 ~~ 0 * dx2 \ndx3 ~~ 0 * dx3 \ndx4 ~~ 0 * dx4 \ndx5 ~~ 0 * dx5 \ndx6 ~~ 0 * dx6 \ndx7 ~~ 0 * dx7 \ndx8 ~~ 0 * dx8 \ndx9 ~~ 0 * dx9 \ndx10 ~~ 0 * dx10 \n# Specify constant change factor \ng2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 + 1 * dx6 + 1 * dx7 + 1 * dx8 + 1 * dx9 + 1 * dx10 \n# Specify constant change factor mean \ng2 ~ alpha_g2 * 1 \n# Specify constant change factor variance \ng2 ~~ sigma2_g2 * g2 \n# Specify constant change factor covariance with the initial true score \ng2 ~~ sigma_g2lx1 * lx1\n# Specify proportional change component \ndx2 ~ beta_x * lx1 \ndx3 ~ beta_x * lx2 \ndx4 ~ beta_x * lx3 \ndx5 ~ beta_x * lx4 \ndx6 ~ beta_x * lx5 \ndx7 ~ beta_x * lx6 \ndx8 ~ beta_x * lx7 \ndx9 ~ beta_x * lx8 \ndx10 ~ beta_x * lx9 \n# Specify autoregression of change score \ndx3 ~ phi_x * dx2 \ndx4 ~ phi_x * dx3 \ndx5 ~ phi_x * dx4 \ndx6 ~ phi_x * dx5 \ndx7 ~ phi_x * dx6 \ndx8 ~ phi_x * dx7 \ndx9 ~ phi_x * dx8 \ndx10 ~ phi_x * dx9 \n# # # # # # # # # # # # # # # # # # # # #\n# Specify parameters for construct y ----\n# # # # # # # # # # # # # # # # # # # # #\n# Specify latent true scores \nly1 =~ 1 * y1 \nly2 =~ 1 * y2 \nly3 =~ 1 * y3 \nly4 =~ 1 * y4 \nly5 =~ 1 * y5 \nly6 =~ 1 * y6 \nly7 =~ 1 * y7 \nly8 =~ 1 * y8 \nly9 =~ 1 * y9 \nly10 =~ 1 * y10 \n# Specify mean of latent true scores \nly1 ~ gamma_ly1 * 1 \nly2 ~ 0 * 1 \nly3 ~ 0 * 1 \nly4 ~ 0 * 1 \nly5 ~ 0 * 1 \nly6 ~ 0 * 1 \nly7 ~ 0 * 1 \nly8 ~ 0 * 1 \nly9 ~ 0 * 1 \nly10 ~ 0 * 1 \n# Specify variance of latent true scores \nly1 ~~ sigma2_ly1 * ly1 \nly2 ~~ 0 * ly2 \nly3 ~~ 0 * ly3 \nly4 ~~ 0 * ly4 \nly5 ~~ 0 * ly5 \nly6 ~~ 0 * ly6 \nly7 ~~ 0 * ly7 \nly8 ~~ 0 * ly8 \nly9 ~~ 0 * ly9 \nly10 ~~ 0 * ly10 \n# Specify intercept of obseved scores \ny1 ~ 0 * 1 \ny2 ~ 0 * 1 \ny3 ~ 0 * 1 \ny4 ~ 0 * 1 \ny5 ~ 0 * 1 \ny6 ~ 0 * 1 \ny7 ~ 0 * 1 \ny8 ~ 0 * 1 \ny9 ~ 0 * 1 \ny10 ~ 0 * 1 \n# Specify variance of observed scores \ny1 ~~ sigma2_uy * y1 \ny2 ~~ sigma2_uy * y2 \ny3 ~~ sigma2_uy * y3 \ny4 ~~ sigma2_uy * y4 \ny5 ~~ sigma2_uy * y5 \ny6 ~~ sigma2_uy * y6 \ny7 ~~ sigma2_uy * y7 \ny8 ~~ sigma2_uy * y8 \ny9 ~~ sigma2_uy * y9 \ny10 ~~ sigma2_uy * y10 \n# Specify autoregressions of latent variables \nly2 ~ 1 * ly1 \nly3 ~ 1 * ly2 \nly4 ~ 1 * ly3 \nly5 ~ 1 * ly4 \nly6 ~ 1 * ly5 \nly7 ~ 1 * ly6 \nly8 ~ 1 * ly7 \nly9 ~ 1 * ly8 \nly10 ~ 1 * ly9 \n# Specify latent change scores \ndy2 =~ 1 * ly2 \ndy3 =~ 1 * ly3 \ndy4 =~ 1 * ly4 \ndy5 =~ 1 * ly5 \ndy6 =~ 1 * ly6 \ndy7 =~ 1 * ly7 \ndy8 =~ 1 * ly8 \ndy9 =~ 1 * ly9 \ndy10 =~ 1 * ly10 \n# Specify latent change scores means \ndy2 ~ 0 * 1 \ndy3 ~ 0 * 1 \ndy4 ~ 0 * 1 \ndy5 ~ 0 * 1 \ndy6 ~ 0 * 1 \ndy7 ~ 0 * 1 \ndy8 ~ 0 * 1 \ndy9 ~ 0 * 1 \ndy10 ~ 0 * 1 \n# Specify latent change scores variances \ndy2 ~~ 0 * dy2 \ndy3 ~~ 0 * dy3 \ndy4 ~~ 0 * dy4 \ndy5 ~~ 0 * dy5 \ndy6 ~~ 0 * dy6 \ndy7 ~~ 0 * dy7 \ndy8 ~~ 0 * dy8 \ndy9 ~~ 0 * dy9 \ndy10 ~~ 0 * dy10 \n# Specify constant change factor \nj2 =~ 1 * dy2 + 1 * dy3 + 1 * dy4 + 1 * dy5 + 1 * dy6 + 1 * dy7 + 1 * dy8 + 1 * dy9 + 1 * dy10 \n# Specify constant change factor mean \nj2 ~ alpha_j2 * 1 \n# Specify constant change factor variance \nj2 ~~ sigma2_j2 * j2 \n# Specify constant change factor covariance with the initial true score \nj2 ~~ sigma_j2ly1 * ly1\n# Specify proportional change component \ndy2 ~ beta_y * ly1 \ndy3 ~ beta_y * ly2 \ndy4 ~ beta_y * ly3 \ndy5 ~ beta_y * ly4 \ndy6 ~ beta_y * ly5 \ndy7 ~ beta_y * ly6 \ndy8 ~ beta_y * ly7 \ndy9 ~ beta_y * ly8 \ndy10 ~ beta_y * ly9 \n# Specify autoregression of change score \ndy3 ~ phi_y * dy2 \ndy4 ~ phi_y * dy3 \ndy5 ~ phi_y * dy4 \ndy6 ~ phi_y * dy5 \ndy7 ~ phi_y * dy6 \ndy8 ~ phi_y * dy7 \ndy9 ~ phi_y * dy8 \ndy10 ~ phi_y * dy9 \n# Specify residual covariances \nx1 ~~ sigma_su * y1 \nx2 ~~ sigma_su * y2 \nx3 ~~ sigma_su * y3 \nx4 ~~ sigma_su * y4 \nx5 ~~ sigma_su * y5 \nx6 ~~ sigma_su * y6 \nx7 ~~ sigma_su * y7 \nx8 ~~ sigma_su * y8 \nx9 ~~ sigma_su * y9 \nx10 ~~ sigma_su * y10 \n# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #\n# Specify covariances betweeen specified change components (alpha) and intercepts (initial latent true scores lx1 and ly1) ----\n# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #\n# Specify covariance of intercepts \nlx1 ~~ sigma_ly1lx1 * ly1 \n# Specify covariance of constant change and intercept between constructs \nly1 ~~ sigma_g2ly1 * g2 \n# Specify covariance of constant change and intercept between constructs \nlx1 ~~ sigma_j2lx1 * j2 \n# Specify covariance of constant change factors between constructs \ng2 ~~ sigma_j2g2 * j2 \n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# Specify between-construct coupling parameters ----\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# Change score x (t) is determined by true score y (t-1)  \ndx2 ~ delta_lag_xy * ly1 \ndx3 ~ delta_lag_xy * ly2 \ndx4 ~ delta_lag_xy * ly3 \ndx5 ~ delta_lag_xy * ly4 \ndx6 ~ delta_lag_xy * ly5 \ndx7 ~ delta_lag_xy * ly6 \ndx8 ~ delta_lag_xy * ly7 \ndx9 ~ delta_lag_xy * ly8 \ndx10 ~ delta_lag_xy * ly9 \n# Change score y (t) is determined by true score x (t-1)  \ndy2 ~ delta_lag_yx * lx1 \ndy3 ~ delta_lag_yx * lx2 \ndy4 ~ delta_lag_yx * lx3 \ndy5 ~ delta_lag_yx * lx4 \ndy6 ~ delta_lag_yx * lx5 \ndy7 ~ delta_lag_yx * lx6 \ndy8 ~ delta_lag_yx * lx7 \ndy9 ~ delta_lag_yx * lx8 \ndy10 ~ delta_lag_yx * lx9 \n"

# To get a readable output use cat() function
cat(lavaan_bi_lcsm_01)
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify parameters for construct x ----
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify latent true scores 
#> lx1 =~ 1 * x1 
#> lx2 =~ 1 * x2 
#> lx3 =~ 1 * x3 
#> lx4 =~ 1 * x4 
#> lx5 =~ 1 * x5 
#> lx6 =~ 1 * x6 
#> lx7 =~ 1 * x7 
#> lx8 =~ 1 * x8 
#> lx9 =~ 1 * x9 
#> lx10 =~ 1 * x10 
#> # Specify mean of latent true scores 
#> lx1 ~ gamma_lx1 * 1 
#> lx2 ~ 0 * 1 
#> lx3 ~ 0 * 1 
#> lx4 ~ 0 * 1 
#> lx5 ~ 0 * 1 
#> lx6 ~ 0 * 1 
#> lx7 ~ 0 * 1 
#> lx8 ~ 0 * 1 
#> lx9 ~ 0 * 1 
#> lx10 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> lx1 ~~ sigma2_lx1 * lx1 
#> lx2 ~~ 0 * lx2 
#> lx3 ~~ 0 * lx3 
#> lx4 ~~ 0 * lx4 
#> lx5 ~~ 0 * lx5 
#> lx6 ~~ 0 * lx6 
#> lx7 ~~ 0 * lx7 
#> lx8 ~~ 0 * lx8 
#> lx9 ~~ 0 * lx9 
#> lx10 ~~ 0 * lx10 
#> # Specify intercept of obseved scores 
#> x1 ~ 0 * 1 
#> x2 ~ 0 * 1 
#> x3 ~ 0 * 1 
#> x4 ~ 0 * 1 
#> x5 ~ 0 * 1 
#> x6 ~ 0 * 1 
#> x7 ~ 0 * 1 
#> x8 ~ 0 * 1 
#> x9 ~ 0 * 1 
#> x10 ~ 0 * 1 
#> # Specify variance of observed scores 
#> x1 ~~ sigma2_ux * x1 
#> x2 ~~ sigma2_ux * x2 
#> x3 ~~ sigma2_ux * x3 
#> x4 ~~ sigma2_ux * x4 
#> x5 ~~ sigma2_ux * x5 
#> x6 ~~ sigma2_ux * x6 
#> x7 ~~ sigma2_ux * x7 
#> x8 ~~ sigma2_ux * x8 
#> x9 ~~ sigma2_ux * x9 
#> x10 ~~ sigma2_ux * x10 
#> # Specify autoregressions of latent variables 
#> lx2 ~ 1 * lx1 
#> lx3 ~ 1 * lx2 
#> lx4 ~ 1 * lx3 
#> lx5 ~ 1 * lx4 
#> lx6 ~ 1 * lx5 
#> lx7 ~ 1 * lx6 
#> lx8 ~ 1 * lx7 
#> lx9 ~ 1 * lx8 
#> lx10 ~ 1 * lx9 
#> # Specify latent change scores 
#> dx2 =~ 1 * lx2 
#> dx3 =~ 1 * lx3 
#> dx4 =~ 1 * lx4 
#> dx5 =~ 1 * lx5 
#> dx6 =~ 1 * lx6 
#> dx7 =~ 1 * lx7 
#> dx8 =~ 1 * lx8 
#> dx9 =~ 1 * lx9 
#> dx10 =~ 1 * lx10 
#> # Specify latent change scores means 
#> dx2 ~ 0 * 1 
#> dx3 ~ 0 * 1 
#> dx4 ~ 0 * 1 
#> dx5 ~ 0 * 1 
#> dx6 ~ 0 * 1 
#> dx7 ~ 0 * 1 
#> dx8 ~ 0 * 1 
#> dx9 ~ 0 * 1 
#> dx10 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dx2 ~~ 0 * dx2 
#> dx3 ~~ 0 * dx3 
#> dx4 ~~ 0 * dx4 
#> dx5 ~~ 0 * dx5 
#> dx6 ~~ 0 * dx6 
#> dx7 ~~ 0 * dx7 
#> dx8 ~~ 0 * dx8 
#> dx9 ~~ 0 * dx9 
#> dx10 ~~ 0 * dx10 
#> # Specify constant change factor 
#> g2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 + 1 * dx6 + 1 * dx7 + 1 * dx8 + 1 * dx9 + 1 * dx10 
#> # Specify constant change factor mean 
#> g2 ~ alpha_g2 * 1 
#> # Specify constant change factor variance 
#> g2 ~~ sigma2_g2 * g2 
#> # Specify constant change factor covariance with the initial true score 
#> g2 ~~ sigma_g2lx1 * lx1
#> # Specify proportional change component 
#> dx2 ~ beta_x * lx1 
#> dx3 ~ beta_x * lx2 
#> dx4 ~ beta_x * lx3 
#> dx5 ~ beta_x * lx4 
#> dx6 ~ beta_x * lx5 
#> dx7 ~ beta_x * lx6 
#> dx8 ~ beta_x * lx7 
#> dx9 ~ beta_x * lx8 
#> dx10 ~ beta_x * lx9 
#> # Specify autoregression of change score 
#> dx3 ~ phi_x * dx2 
#> dx4 ~ phi_x * dx3 
#> dx5 ~ phi_x * dx4 
#> dx6 ~ phi_x * dx5 
#> dx7 ~ phi_x * dx6 
#> dx8 ~ phi_x * dx7 
#> dx9 ~ phi_x * dx8 
#> dx10 ~ phi_x * dx9 
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify parameters for construct y ----
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify latent true scores 
#> ly1 =~ 1 * y1 
#> ly2 =~ 1 * y2 
#> ly3 =~ 1 * y3 
#> ly4 =~ 1 * y4 
#> ly5 =~ 1 * y5 
#> ly6 =~ 1 * y6 
#> ly7 =~ 1 * y7 
#> ly8 =~ 1 * y8 
#> ly9 =~ 1 * y9 
#> ly10 =~ 1 * y10 
#> # Specify mean of latent true scores 
#> ly1 ~ gamma_ly1 * 1 
#> ly2 ~ 0 * 1 
#> ly3 ~ 0 * 1 
#> ly4 ~ 0 * 1 
#> ly5 ~ 0 * 1 
#> ly6 ~ 0 * 1 
#> ly7 ~ 0 * 1 
#> ly8 ~ 0 * 1 
#> ly9 ~ 0 * 1 
#> ly10 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> ly1 ~~ sigma2_ly1 * ly1 
#> ly2 ~~ 0 * ly2 
#> ly3 ~~ 0 * ly3 
#> ly4 ~~ 0 * ly4 
#> ly5 ~~ 0 * ly5 
#> ly6 ~~ 0 * ly6 
#> ly7 ~~ 0 * ly7 
#> ly8 ~~ 0 * ly8 
#> ly9 ~~ 0 * ly9 
#> ly10 ~~ 0 * ly10 
#> # Specify intercept of obseved scores 
#> y1 ~ 0 * 1 
#> y2 ~ 0 * 1 
#> y3 ~ 0 * 1 
#> y4 ~ 0 * 1 
#> y5 ~ 0 * 1 
#> y6 ~ 0 * 1 
#> y7 ~ 0 * 1 
#> y8 ~ 0 * 1 
#> y9 ~ 0 * 1 
#> y10 ~ 0 * 1 
#> # Specify variance of observed scores 
#> y1 ~~ sigma2_uy * y1 
#> y2 ~~ sigma2_uy * y2 
#> y3 ~~ sigma2_uy * y3 
#> y4 ~~ sigma2_uy * y4 
#> y5 ~~ sigma2_uy * y5 
#> y6 ~~ sigma2_uy * y6 
#> y7 ~~ sigma2_uy * y7 
#> y8 ~~ sigma2_uy * y8 
#> y9 ~~ sigma2_uy * y9 
#> y10 ~~ sigma2_uy * y10 
#> # Specify autoregressions of latent variables 
#> ly2 ~ 1 * ly1 
#> ly3 ~ 1 * ly2 
#> ly4 ~ 1 * ly3 
#> ly5 ~ 1 * ly4 
#> ly6 ~ 1 * ly5 
#> ly7 ~ 1 * ly6 
#> ly8 ~ 1 * ly7 
#> ly9 ~ 1 * ly8 
#> ly10 ~ 1 * ly9 
#> # Specify latent change scores 
#> dy2 =~ 1 * ly2 
#> dy3 =~ 1 * ly3 
#> dy4 =~ 1 * ly4 
#> dy5 =~ 1 * ly5 
#> dy6 =~ 1 * ly6 
#> dy7 =~ 1 * ly7 
#> dy8 =~ 1 * ly8 
#> dy9 =~ 1 * ly9 
#> dy10 =~ 1 * ly10 
#> # Specify latent change scores means 
#> dy2 ~ 0 * 1 
#> dy3 ~ 0 * 1 
#> dy4 ~ 0 * 1 
#> dy5 ~ 0 * 1 
#> dy6 ~ 0 * 1 
#> dy7 ~ 0 * 1 
#> dy8 ~ 0 * 1 
#> dy9 ~ 0 * 1 
#> dy10 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dy2 ~~ 0 * dy2 
#> dy3 ~~ 0 * dy3 
#> dy4 ~~ 0 * dy4 
#> dy5 ~~ 0 * dy5 
#> dy6 ~~ 0 * dy6 
#> dy7 ~~ 0 * dy7 
#> dy8 ~~ 0 * dy8 
#> dy9 ~~ 0 * dy9 
#> dy10 ~~ 0 * dy10 
#> # Specify constant change factor 
#> j2 =~ 1 * dy2 + 1 * dy3 + 1 * dy4 + 1 * dy5 + 1 * dy6 + 1 * dy7 + 1 * dy8 + 1 * dy9 + 1 * dy10 
#> # Specify constant change factor mean 
#> j2 ~ alpha_j2 * 1 
#> # Specify constant change factor variance 
#> j2 ~~ sigma2_j2 * j2 
#> # Specify constant change factor covariance with the initial true score 
#> j2 ~~ sigma_j2ly1 * ly1
#> # Specify proportional change component 
#> dy2 ~ beta_y * ly1 
#> dy3 ~ beta_y * ly2 
#> dy4 ~ beta_y * ly3 
#> dy5 ~ beta_y * ly4 
#> dy6 ~ beta_y * ly5 
#> dy7 ~ beta_y * ly6 
#> dy8 ~ beta_y * ly7 
#> dy9 ~ beta_y * ly8 
#> dy10 ~ beta_y * ly9 
#> # Specify autoregression of change score 
#> dy3 ~ phi_y * dy2 
#> dy4 ~ phi_y * dy3 
#> dy5 ~ phi_y * dy4 
#> dy6 ~ phi_y * dy5 
#> dy7 ~ phi_y * dy6 
#> dy8 ~ phi_y * dy7 
#> dy9 ~ phi_y * dy8 
#> dy10 ~ phi_y * dy9 
#> # Specify residual covariances 
#> x1 ~~ sigma_su * y1 
#> x2 ~~ sigma_su * y2 
#> x3 ~~ sigma_su * y3 
#> x4 ~~ sigma_su * y4 
#> x5 ~~ sigma_su * y5 
#> x6 ~~ sigma_su * y6 
#> x7 ~~ sigma_su * y7 
#> x8 ~~ sigma_su * y8 
#> x9 ~~ sigma_su * y9 
#> x10 ~~ sigma_su * y10 
#> # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#> # Specify covariances betweeen specified change components (alpha) and intercepts (initial latent true scores lx1 and ly1) ----
#> # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#> # Specify covariance of intercepts 
#> lx1 ~~ sigma_ly1lx1 * ly1 
#> # Specify covariance of constant change and intercept between constructs 
#> ly1 ~~ sigma_g2ly1 * g2 
#> # Specify covariance of constant change and intercept between constructs 
#> lx1 ~~ sigma_j2lx1 * j2 
#> # Specify covariance of constant change factors between constructs 
#> g2 ~~ sigma_j2g2 * j2 
#> # # # # # # # # # # # # # # # # # # # # # # # # # # #
#> # Specify between-construct coupling parameters ----
#> # # # # # # # # # # # # # # # # # # # # # # # # # # #
#> # Change score x (t) is determined by true score y (t-1)  
#> dx2 ~ delta_lag_xy * ly1 
#> dx3 ~ delta_lag_xy * ly2 
#> dx4 ~ delta_lag_xy * ly3 
#> dx5 ~ delta_lag_xy * ly4 
#> dx6 ~ delta_lag_xy * ly5 
#> dx7 ~ delta_lag_xy * ly6 
#> dx8 ~ delta_lag_xy * ly7 
#> dx9 ~ delta_lag_xy * ly8 
#> dx10 ~ delta_lag_xy * ly9 
#> # Change score y (t) is determined by true score x (t-1)  
#> dy2 ~ delta_lag_yx * lx1 
#> dy3 ~ delta_lag_yx * lx2 
#> dy4 ~ delta_lag_yx * lx3 
#> dy5 ~ delta_lag_yx * lx4 
#> dy6 ~ delta_lag_yx * lx5 
#> dy7 ~ delta_lag_yx * lx6 
#> dy8 ~ delta_lag_yx * lx7 
#> dy9 ~ delta_lag_yx * lx8 
#> dy10 ~ delta_lag_yx * lx9 
```
