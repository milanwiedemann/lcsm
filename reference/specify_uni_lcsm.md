# Specify lavaan model for univariate latent change score models

Specify lavaan model for univariate latent change score models

## Usage

``` r
specify_uni_lcsm(timepoints, var, model, add = NULL, change_letter = "g")
```

## Arguments

- timepoints:

  Number if timepoints.

- var:

  String, specifying letter to be used for of variables (Usually x or
  y).

- model:

  List of model specifications (logical) for the variables specified in
  `variable`.

  - `alpha_constant`: Constant change factor,

  - `alpha_piecewise`: Piecewise constant change factors,

  - `alpha_piecewise_num`: Changepoint of piecewise constant change
    factors,

  - `alpha_linear`: Linear change factor,

  - `beta`: Proportional change factor,

  - `phi`: Autoregression of change scores.

- add:

  String, lavaan syntax to be added to the model

- change_letter:

  String, specifying letter to be used for change factor (Usually g or
  j).

## Value

Lavaan model syntax including comments.

## References

Ghisletta, P., & McArdle, J. J. (2012). Latent Curve Models and Latent
Change Score Models Estimated in R. Structural Equation Modeling: A
Multidisciplinary Journal, 19(4), 651–682.
[doi:10.1080/10705511.2012.713275](https://doi.org/10.1080/10705511.2012.713275)
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
# Specify univariate LCSM
lavaan_uni_lcsm_01 <- specify_uni_lcsm(timepoints = 10, 
                                       model = list(alpha_constant = TRUE, 
                                                    beta = TRUE, 
                                                    phi = TRUE), 
                                       var = "x",  
                                       change_letter = "g")
                 
#' # To look at string simply return the object                                    
lavaan_uni_lcsm_01
#> [1] "# Specify latent true scores \nlx1 =~ 1 * x1 \nlx2 =~ 1 * x2 \nlx3 =~ 1 * x3 \nlx4 =~ 1 * x4 \nlx5 =~ 1 * x5 \nlx6 =~ 1 * x6 \nlx7 =~ 1 * x7 \nlx8 =~ 1 * x8 \nlx9 =~ 1 * x9 \nlx10 =~ 1 * x10 \n# Specify mean of latent true scores \nlx1 ~ gamma_lx1 * 1 \nlx2 ~ 0 * 1 \nlx3 ~ 0 * 1 \nlx4 ~ 0 * 1 \nlx5 ~ 0 * 1 \nlx6 ~ 0 * 1 \nlx7 ~ 0 * 1 \nlx8 ~ 0 * 1 \nlx9 ~ 0 * 1 \nlx10 ~ 0 * 1 \n# Specify variance of latent true scores \nlx1 ~~ sigma2_lx1 * lx1 \nlx2 ~~ 0 * lx2 \nlx3 ~~ 0 * lx3 \nlx4 ~~ 0 * lx4 \nlx5 ~~ 0 * lx5 \nlx6 ~~ 0 * lx6 \nlx7 ~~ 0 * lx7 \nlx8 ~~ 0 * lx8 \nlx9 ~~ 0 * lx9 \nlx10 ~~ 0 * lx10 \n# Specify intercept of obseved scores \nx1 ~ 0 * 1 \nx2 ~ 0 * 1 \nx3 ~ 0 * 1 \nx4 ~ 0 * 1 \nx5 ~ 0 * 1 \nx6 ~ 0 * 1 \nx7 ~ 0 * 1 \nx8 ~ 0 * 1 \nx9 ~ 0 * 1 \nx10 ~ 0 * 1 \n# Specify variance of observed scores \nx1 ~~ sigma2_ux * x1 \nx2 ~~ sigma2_ux * x2 \nx3 ~~ sigma2_ux * x3 \nx4 ~~ sigma2_ux * x4 \nx5 ~~ sigma2_ux * x5 \nx6 ~~ sigma2_ux * x6 \nx7 ~~ sigma2_ux * x7 \nx8 ~~ sigma2_ux * x8 \nx9 ~~ sigma2_ux * x9 \nx10 ~~ sigma2_ux * x10 \n# Specify autoregressions of latent variables \nlx2 ~ 1 * lx1 \nlx3 ~ 1 * lx2 \nlx4 ~ 1 * lx3 \nlx5 ~ 1 * lx4 \nlx6 ~ 1 * lx5 \nlx7 ~ 1 * lx6 \nlx8 ~ 1 * lx7 \nlx9 ~ 1 * lx8 \nlx10 ~ 1 * lx9 \n# Specify latent change scores \ndx2 =~ 1 * lx2 \ndx3 =~ 1 * lx3 \ndx4 =~ 1 * lx4 \ndx5 =~ 1 * lx5 \ndx6 =~ 1 * lx6 \ndx7 =~ 1 * lx7 \ndx8 =~ 1 * lx8 \ndx9 =~ 1 * lx9 \ndx10 =~ 1 * lx10 \n# Specify latent change scores means \ndx2 ~ 0 * 1 \ndx3 ~ 0 * 1 \ndx4 ~ 0 * 1 \ndx5 ~ 0 * 1 \ndx6 ~ 0 * 1 \ndx7 ~ 0 * 1 \ndx8 ~ 0 * 1 \ndx9 ~ 0 * 1 \ndx10 ~ 0 * 1 \n# Specify latent change scores variances \ndx2 ~~ 0 * dx2 \ndx3 ~~ 0 * dx3 \ndx4 ~~ 0 * dx4 \ndx5 ~~ 0 * dx5 \ndx6 ~~ 0 * dx6 \ndx7 ~~ 0 * dx7 \ndx8 ~~ 0 * dx8 \ndx9 ~~ 0 * dx9 \ndx10 ~~ 0 * dx10 \n# Specify constant change factor \ng2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 + 1 * dx6 + 1 * dx7 + 1 * dx8 + 1 * dx9 + 1 * dx10 \n# Specify constant change factor mean \ng2 ~ alpha_g2 * 1 \n# Specify constant change factor variance \ng2 ~~ sigma2_g2 * g2 \n# Specify constant change factor covariance with the initial true score \ng2 ~~ sigma_g2lx1 * lx1\n# Specify proportional change component \ndx2 ~ beta_x * lx1 \ndx3 ~ beta_x * lx2 \ndx4 ~ beta_x * lx3 \ndx5 ~ beta_x * lx4 \ndx6 ~ beta_x * lx5 \ndx7 ~ beta_x * lx6 \ndx8 ~ beta_x * lx7 \ndx9 ~ beta_x * lx8 \ndx10 ~ beta_x * lx9 \n# Specify autoregression of change score \ndx3 ~ phi_x * dx2 \ndx4 ~ phi_x * dx3 \ndx5 ~ phi_x * dx4 \ndx6 ~ phi_x * dx5 \ndx7 ~ phi_x * dx6 \ndx8 ~ phi_x * dx7 \ndx9 ~ phi_x * dx8 \ndx10 ~ phi_x * dx9 \n"

# To get a readable output use cat() function
cat(lavaan_uni_lcsm_01)
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
```
