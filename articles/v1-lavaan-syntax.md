# Generate lavaan syntax for latent change score models

``` r

library(lcsm)
#> This is lcsm 0.3.3
#> Please report any issues or ideas at:
#> https://github.com/milanwiedemann/lcsm/issues
#> 
```

## Univariate LCSM syntax

The example below shows how to specify a generic univariate latent
change score model using the function
[`specify_uni_lcsm()`](https://milanwiedemann.github.io/lcsm/reference/specify_uni_lcsm.md).

``` r

uni_lcsm_syntax <- specify_uni_lcsm(timepoints = 5,
                                    var = "x",  
                                    change_letter = "g",
                                    model = list(alpha_constant = TRUE, 
                                                 beta = TRUE, 
                                                 phi = TRUE))
```

``` r

# To get a readable output use cat() function
cat(uni_lcsm_syntax)
#> # Specify latent true scores 
#> lx1 =~ 1 * x1 
#> lx2 =~ 1 * x2 
#> lx3 =~ 1 * x3 
#> lx4 =~ 1 * x4 
#> lx5 =~ 1 * x5 
#> # Specify mean of latent true scores 
#> lx1 ~ gamma_lx1 * 1 
#> lx2 ~ 0 * 1 
#> lx3 ~ 0 * 1 
#> lx4 ~ 0 * 1 
#> lx5 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> lx1 ~~ sigma2_lx1 * lx1 
#> lx2 ~~ 0 * lx2 
#> lx3 ~~ 0 * lx3 
#> lx4 ~~ 0 * lx4 
#> lx5 ~~ 0 * lx5 
#> # Specify intercept of obseved scores 
#> x1 ~ 0 * 1 
#> x2 ~ 0 * 1 
#> x3 ~ 0 * 1 
#> x4 ~ 0 * 1 
#> x5 ~ 0 * 1 
#> # Specify variance of observed scores 
#> x1 ~~ sigma2_ux * x1 
#> x2 ~~ sigma2_ux * x2 
#> x3 ~~ sigma2_ux * x3 
#> x4 ~~ sigma2_ux * x4 
#> x5 ~~ sigma2_ux * x5 
#> # Specify autoregressions of latent variables 
#> lx2 ~ 1 * lx1 
#> lx3 ~ 1 * lx2 
#> lx4 ~ 1 * lx3 
#> lx5 ~ 1 * lx4 
#> # Specify latent change scores 
#> dx2 =~ 1 * lx2 
#> dx3 =~ 1 * lx3 
#> dx4 =~ 1 * lx4 
#> dx5 =~ 1 * lx5 
#> # Specify latent change scores means 
#> dx2 ~ 0 * 1 
#> dx3 ~ 0 * 1 
#> dx4 ~ 0 * 1 
#> dx5 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dx2 ~~ 0 * dx2 
#> dx3 ~~ 0 * dx3 
#> dx4 ~~ 0 * dx4 
#> dx5 ~~ 0 * dx5 
#> # Specify constant change factor 
#> g2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 
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
#> # Specify autoregression of change score 
#> dx3 ~ phi_x * dx2 
#> dx4 ~ phi_x * dx3 
#> dx5 ~ phi_x * dx4
```

### Add lavaan syntax

``` r

uni_lcsm_syntax_add <- specify_uni_lcsm(timepoints = 3,
                                    var = "x",  
                                    change_letter = "g",
                                    add = "# JUST ANOTHER COMMENT",
                                    model = list(alpha_constant = TRUE, 
                                                 beta = TRUE, 
                                                 phi = TRUE))
```

``` r

# To get a readable output use cat() function
cat(uni_lcsm_syntax_add)
#> # Specify latent true scores 
#> lx1 =~ 1 * x1 
#> lx2 =~ 1 * x2 
#> lx3 =~ 1 * x3 
#> # Specify mean of latent true scores 
#> lx1 ~ gamma_lx1 * 1 
#> lx2 ~ 0 * 1 
#> lx3 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> lx1 ~~ sigma2_lx1 * lx1 
#> lx2 ~~ 0 * lx2 
#> lx3 ~~ 0 * lx3 
#> # Specify intercept of obseved scores 
#> x1 ~ 0 * 1 
#> x2 ~ 0 * 1 
#> x3 ~ 0 * 1 
#> # Specify variance of observed scores 
#> x1 ~~ sigma2_ux * x1 
#> x2 ~~ sigma2_ux * x2 
#> x3 ~~ sigma2_ux * x3 
#> # Specify autoregressions of latent variables 
#> lx2 ~ 1 * lx1 
#> lx3 ~ 1 * lx2 
#> # Specify latent change scores 
#> dx2 =~ 1 * lx2 
#> dx3 =~ 1 * lx3 
#> # Specify latent change scores means 
#> dx2 ~ 0 * 1 
#> dx3 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dx2 ~~ 0 * dx2 
#> dx3 ~~ 0 * dx3 
#> # Specify constant change factor 
#> g2 =~ 1 * dx2 + 1 * dx3 
#> # Specify constant change factor mean 
#> g2 ~ alpha_g2 * 1 
#> # Specify constant change factor variance 
#> g2 ~~ sigma2_g2 * g2 
#> # Specify constant change factor covariance with the initial true score 
#> g2 ~~ sigma_g2lx1 * lx1
#> # Specify proportional change component 
#> dx2 ~ beta_x * lx1 
#> dx3 ~ beta_x * lx2 
#> # Specify autoregression of change score 
#> dx3 ~ phi_x * dx2 
#> # # # # # # # # # # # # # # # # # # # # # # #
#> # ---- Additaional Model Specifications ----
#> # # # # # # # # # # # # # # # # # # # # # # #
#> # JUST ANOTHER COMMENT
```

## Bivariate LCSM syntax

### True Score to Change Score

``` r

# Specify bivariate LCSM
lavaan_bi_lcsm_delta_01 <- specify_bi_lcsm(timepoints = 5, 
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
```

``` r

# To get a readable output use cat() function
cat(lavaan_bi_lcsm_delta_01)
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify parameters for construct x ----
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify latent true scores 
#> lx1 =~ 1 * x1 
#> lx2 =~ 1 * x2 
#> lx3 =~ 1 * x3 
#> lx4 =~ 1 * x4 
#> lx5 =~ 1 * x5 
#> # Specify mean of latent true scores 
#> lx1 ~ gamma_lx1 * 1 
#> lx2 ~ 0 * 1 
#> lx3 ~ 0 * 1 
#> lx4 ~ 0 * 1 
#> lx5 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> lx1 ~~ sigma2_lx1 * lx1 
#> lx2 ~~ 0 * lx2 
#> lx3 ~~ 0 * lx3 
#> lx4 ~~ 0 * lx4 
#> lx5 ~~ 0 * lx5 
#> # Specify intercept of obseved scores 
#> x1 ~ 0 * 1 
#> x2 ~ 0 * 1 
#> x3 ~ 0 * 1 
#> x4 ~ 0 * 1 
#> x5 ~ 0 * 1 
#> # Specify variance of observed scores 
#> x1 ~~ sigma2_ux * x1 
#> x2 ~~ sigma2_ux * x2 
#> x3 ~~ sigma2_ux * x3 
#> x4 ~~ sigma2_ux * x4 
#> x5 ~~ sigma2_ux * x5 
#> # Specify autoregressions of latent variables 
#> lx2 ~ 1 * lx1 
#> lx3 ~ 1 * lx2 
#> lx4 ~ 1 * lx3 
#> lx5 ~ 1 * lx4 
#> # Specify latent change scores 
#> dx2 =~ 1 * lx2 
#> dx3 =~ 1 * lx3 
#> dx4 =~ 1 * lx4 
#> dx5 =~ 1 * lx5 
#> # Specify latent change scores means 
#> dx2 ~ 0 * 1 
#> dx3 ~ 0 * 1 
#> dx4 ~ 0 * 1 
#> dx5 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dx2 ~~ 0 * dx2 
#> dx3 ~~ 0 * dx3 
#> dx4 ~~ 0 * dx4 
#> dx5 ~~ 0 * dx5 
#> # Specify constant change factor 
#> g2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 
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
#> # Specify autoregression of change score 
#> dx3 ~ phi_x * dx2 
#> dx4 ~ phi_x * dx3 
#> dx5 ~ phi_x * dx4 
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify parameters for construct y ----
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify latent true scores 
#> ly1 =~ 1 * y1 
#> ly2 =~ 1 * y2 
#> ly3 =~ 1 * y3 
#> ly4 =~ 1 * y4 
#> ly5 =~ 1 * y5 
#> # Specify mean of latent true scores 
#> ly1 ~ gamma_ly1 * 1 
#> ly2 ~ 0 * 1 
#> ly3 ~ 0 * 1 
#> ly4 ~ 0 * 1 
#> ly5 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> ly1 ~~ sigma2_ly1 * ly1 
#> ly2 ~~ 0 * ly2 
#> ly3 ~~ 0 * ly3 
#> ly4 ~~ 0 * ly4 
#> ly5 ~~ 0 * ly5 
#> # Specify intercept of obseved scores 
#> y1 ~ 0 * 1 
#> y2 ~ 0 * 1 
#> y3 ~ 0 * 1 
#> y4 ~ 0 * 1 
#> y5 ~ 0 * 1 
#> # Specify variance of observed scores 
#> y1 ~~ sigma2_uy * y1 
#> y2 ~~ sigma2_uy * y2 
#> y3 ~~ sigma2_uy * y3 
#> y4 ~~ sigma2_uy * y4 
#> y5 ~~ sigma2_uy * y5 
#> # Specify autoregressions of latent variables 
#> ly2 ~ 1 * ly1 
#> ly3 ~ 1 * ly2 
#> ly4 ~ 1 * ly3 
#> ly5 ~ 1 * ly4 
#> # Specify latent change scores 
#> dy2 =~ 1 * ly2 
#> dy3 =~ 1 * ly3 
#> dy4 =~ 1 * ly4 
#> dy5 =~ 1 * ly5 
#> # Specify latent change scores means 
#> dy2 ~ 0 * 1 
#> dy3 ~ 0 * 1 
#> dy4 ~ 0 * 1 
#> dy5 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dy2 ~~ 0 * dy2 
#> dy3 ~~ 0 * dy3 
#> dy4 ~~ 0 * dy4 
#> dy5 ~~ 0 * dy5 
#> # Specify constant change factor 
#> j2 =~ 1 * dy2 + 1 * dy3 + 1 * dy4 + 1 * dy5 
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
#> # Specify autoregression of change score 
#> dy3 ~ phi_y * dy2 
#> dy4 ~ phi_y * dy3 
#> dy5 ~ phi_y * dy4 
#> # Specify residual covariances 
#> x1 ~~ sigma_su * y1 
#> x2 ~~ sigma_su * y2 
#> x3 ~~ sigma_su * y3 
#> x4 ~~ sigma_su * y4 
#> x5 ~~ sigma_su * y5 
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
#> # Change score y (t) is determined by true score x (t-1)  
#> dy2 ~ delta_lag_yx * lx1 
#> dy3 ~ delta_lag_yx * lx2 
#> dy4 ~ delta_lag_yx * lx3 
#> dy5 ~ delta_lag_yx * lx4
```

### Change Score to Change Score

``` r

# Specify bivariate LCSM
lavaan_bi_lcsm_xi_01 <- specify_bi_lcsm(timepoints = 5, 
                                        var_x = "x",
                                        model_x = list(alpha_constant = TRUE, 
                                                       beta = TRUE, 
                                                       phi = TRUE),
                                        var_y = "y",  
                                        model_y = list(alpha_constant = TRUE, 
                                                       beta = TRUE, 
                                                       phi = TRUE),  
                                        coupling = list(xi_lag_xy = TRUE, 
                                                        xi_lag_yx = TRUE),
                                        change_letter_x = "g",
                                        change_letter_y = "j")
```

``` r

# To get a readable output use cat() function
cat(lavaan_bi_lcsm_xi_01)
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify parameters for construct x ----
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify latent true scores 
#> lx1 =~ 1 * x1 
#> lx2 =~ 1 * x2 
#> lx3 =~ 1 * x3 
#> lx4 =~ 1 * x4 
#> lx5 =~ 1 * x5 
#> # Specify mean of latent true scores 
#> lx1 ~ gamma_lx1 * 1 
#> lx2 ~ 0 * 1 
#> lx3 ~ 0 * 1 
#> lx4 ~ 0 * 1 
#> lx5 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> lx1 ~~ sigma2_lx1 * lx1 
#> lx2 ~~ 0 * lx2 
#> lx3 ~~ 0 * lx3 
#> lx4 ~~ 0 * lx4 
#> lx5 ~~ 0 * lx5 
#> # Specify intercept of obseved scores 
#> x1 ~ 0 * 1 
#> x2 ~ 0 * 1 
#> x3 ~ 0 * 1 
#> x4 ~ 0 * 1 
#> x5 ~ 0 * 1 
#> # Specify variance of observed scores 
#> x1 ~~ sigma2_ux * x1 
#> x2 ~~ sigma2_ux * x2 
#> x3 ~~ sigma2_ux * x3 
#> x4 ~~ sigma2_ux * x4 
#> x5 ~~ sigma2_ux * x5 
#> # Specify autoregressions of latent variables 
#> lx2 ~ 1 * lx1 
#> lx3 ~ 1 * lx2 
#> lx4 ~ 1 * lx3 
#> lx5 ~ 1 * lx4 
#> # Specify latent change scores 
#> dx2 =~ 1 * lx2 
#> dx3 =~ 1 * lx3 
#> dx4 =~ 1 * lx4 
#> dx5 =~ 1 * lx5 
#> # Specify latent change scores means 
#> dx2 ~ 0 * 1 
#> dx3 ~ 0 * 1 
#> dx4 ~ 0 * 1 
#> dx5 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dx2 ~~ 0 * dx2 
#> dx3 ~~ 0 * dx3 
#> dx4 ~~ 0 * dx4 
#> dx5 ~~ 0 * dx5 
#> # Specify constant change factor 
#> g2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 + 1 * dx5 
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
#> # Specify autoregression of change score 
#> dx3 ~ phi_x * dx2 
#> dx4 ~ phi_x * dx3 
#> dx5 ~ phi_x * dx4 
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify parameters for construct y ----
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify latent true scores 
#> ly1 =~ 1 * y1 
#> ly2 =~ 1 * y2 
#> ly3 =~ 1 * y3 
#> ly4 =~ 1 * y4 
#> ly5 =~ 1 * y5 
#> # Specify mean of latent true scores 
#> ly1 ~ gamma_ly1 * 1 
#> ly2 ~ 0 * 1 
#> ly3 ~ 0 * 1 
#> ly4 ~ 0 * 1 
#> ly5 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> ly1 ~~ sigma2_ly1 * ly1 
#> ly2 ~~ 0 * ly2 
#> ly3 ~~ 0 * ly3 
#> ly4 ~~ 0 * ly4 
#> ly5 ~~ 0 * ly5 
#> # Specify intercept of obseved scores 
#> y1 ~ 0 * 1 
#> y2 ~ 0 * 1 
#> y3 ~ 0 * 1 
#> y4 ~ 0 * 1 
#> y5 ~ 0 * 1 
#> # Specify variance of observed scores 
#> y1 ~~ sigma2_uy * y1 
#> y2 ~~ sigma2_uy * y2 
#> y3 ~~ sigma2_uy * y3 
#> y4 ~~ sigma2_uy * y4 
#> y5 ~~ sigma2_uy * y5 
#> # Specify autoregressions of latent variables 
#> ly2 ~ 1 * ly1 
#> ly3 ~ 1 * ly2 
#> ly4 ~ 1 * ly3 
#> ly5 ~ 1 * ly4 
#> # Specify latent change scores 
#> dy2 =~ 1 * ly2 
#> dy3 =~ 1 * ly3 
#> dy4 =~ 1 * ly4 
#> dy5 =~ 1 * ly5 
#> # Specify latent change scores means 
#> dy2 ~ 0 * 1 
#> dy3 ~ 0 * 1 
#> dy4 ~ 0 * 1 
#> dy5 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dy2 ~~ 0 * dy2 
#> dy3 ~~ 0 * dy3 
#> dy4 ~~ 0 * dy4 
#> dy5 ~~ 0 * dy5 
#> # Specify constant change factor 
#> j2 =~ 1 * dy2 + 1 * dy3 + 1 * dy4 + 1 * dy5 
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
#> # Specify autoregression of change score 
#> dy3 ~ phi_y * dy2 
#> dy4 ~ phi_y * dy3 
#> dy5 ~ phi_y * dy4 
#> # Specify residual covariances 
#> x1 ~~ sigma_su * y1 
#> x2 ~~ sigma_su * y2 
#> x3 ~~ sigma_su * y3 
#> x4 ~~ sigma_su * y4 
#> x5 ~~ sigma_su * y5 
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
#> # Change score x (t) is determined by change score y (t-1)  
#> dx3 ~ xi_lag_xy * dy2 
#> dx4 ~ xi_lag_xy * dy3 
#> dx5 ~ xi_lag_xy * dy4 
#> # Change score y (t) is determined by change score x (t-1)  
#> dy3 ~ xi_lag_yx * dx2 
#> dy4 ~ xi_lag_yx * dx3 
#> dy5 ~ xi_lag_yx * dx4
```

### Add model specifications to lavaan code

``` r

# Specify bivariate LCSM
lavaan_bi_lcsm_xi_add <- specify_bi_lcsm(timepoints = 3, 
                                        var_x = "x",
                                        model_x = list(alpha_constant = TRUE, 
                                                       beta = TRUE, 
                                                       phi = TRUE),
                                        var_y = "y",  
                                        model_y = list(alpha_constant = TRUE, 
                                                       beta = TRUE, 
                                                       phi = TRUE),  
                                        coupling = list(xi_lag_xy = TRUE, 
                                                        xi_lag_yx = TRUE),
                                        add = "age ~~ age_j2 * j2",
                                        change_letter_x = "g",
                                        change_letter_y = "j")
```

``` r

# To get a readable output use cat() function
cat(lavaan_bi_lcsm_xi_add)
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify parameters for construct x ----
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify latent true scores 
#> lx1 =~ 1 * x1 
#> lx2 =~ 1 * x2 
#> lx3 =~ 1 * x3 
#> # Specify mean of latent true scores 
#> lx1 ~ gamma_lx1 * 1 
#> lx2 ~ 0 * 1 
#> lx3 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> lx1 ~~ sigma2_lx1 * lx1 
#> lx2 ~~ 0 * lx2 
#> lx3 ~~ 0 * lx3 
#> # Specify intercept of obseved scores 
#> x1 ~ 0 * 1 
#> x2 ~ 0 * 1 
#> x3 ~ 0 * 1 
#> # Specify variance of observed scores 
#> x1 ~~ sigma2_ux * x1 
#> x2 ~~ sigma2_ux * x2 
#> x3 ~~ sigma2_ux * x3 
#> # Specify autoregressions of latent variables 
#> lx2 ~ 1 * lx1 
#> lx3 ~ 1 * lx2 
#> # Specify latent change scores 
#> dx2 =~ 1 * lx2 
#> dx3 =~ 1 * lx3 
#> # Specify latent change scores means 
#> dx2 ~ 0 * 1 
#> dx3 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dx2 ~~ 0 * dx2 
#> dx3 ~~ 0 * dx3 
#> # Specify constant change factor 
#> g2 =~ 1 * dx2 + 1 * dx3 
#> # Specify constant change factor mean 
#> g2 ~ alpha_g2 * 1 
#> # Specify constant change factor variance 
#> g2 ~~ sigma2_g2 * g2 
#> # Specify constant change factor covariance with the initial true score 
#> g2 ~~ sigma_g2lx1 * lx1
#> # Specify proportional change component 
#> dx2 ~ beta_x * lx1 
#> dx3 ~ beta_x * lx2 
#> # Specify autoregression of change score 
#> dx3 ~ phi_x * dx2 
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify parameters for construct y ----
#> # # # # # # # # # # # # # # # # # # # # #
#> # Specify latent true scores 
#> ly1 =~ 1 * y1 
#> ly2 =~ 1 * y2 
#> ly3 =~ 1 * y3 
#> # Specify mean of latent true scores 
#> ly1 ~ gamma_ly1 * 1 
#> ly2 ~ 0 * 1 
#> ly3 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> ly1 ~~ sigma2_ly1 * ly1 
#> ly2 ~~ 0 * ly2 
#> ly3 ~~ 0 * ly3 
#> # Specify intercept of obseved scores 
#> y1 ~ 0 * 1 
#> y2 ~ 0 * 1 
#> y3 ~ 0 * 1 
#> # Specify variance of observed scores 
#> y1 ~~ sigma2_uy * y1 
#> y2 ~~ sigma2_uy * y2 
#> y3 ~~ sigma2_uy * y3 
#> # Specify autoregressions of latent variables 
#> ly2 ~ 1 * ly1 
#> ly3 ~ 1 * ly2 
#> # Specify latent change scores 
#> dy2 =~ 1 * ly2 
#> dy3 =~ 1 * ly3 
#> # Specify latent change scores means 
#> dy2 ~ 0 * 1 
#> dy3 ~ 0 * 1 
#> # Specify latent change scores variances 
#> dy2 ~~ 0 * dy2 
#> dy3 ~~ 0 * dy3 
#> # Specify constant change factor 
#> j2 =~ 1 * dy2 + 1 * dy3 
#> # Specify constant change factor mean 
#> j2 ~ alpha_j2 * 1 
#> # Specify constant change factor variance 
#> j2 ~~ sigma2_j2 * j2 
#> # Specify constant change factor covariance with the initial true score 
#> j2 ~~ sigma_j2ly1 * ly1
#> # Specify proportional change component 
#> dy2 ~ beta_y * ly1 
#> dy3 ~ beta_y * ly2 
#> # Specify autoregression of change score 
#> dy3 ~ phi_y * dy2 
#> # Specify residual covariances 
#> x1 ~~ sigma_su * y1 
#> x2 ~~ sigma_su * y2 
#> x3 ~~ sigma_su * y3 
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
#> # Change score x (t) is determined by change score y (t-1)  
#> dx3 ~ xi_lag_xy * dy2 
#> # Change score y (t) is determined by change score x (t-1)  
#> dy3 ~ xi_lag_yx * dx2 
#> # # # # # # # # # # # # # # # # # # # # # # #
#> # ---- Additaional Model Specifications ----
#> # # # # # # # # # # # # # # # # # # # # # # #
#> age ~~ age_j2 * j2
```

## TODOs

- show different examples
- highlight the comments that explain the different sections of the code
- show how this syntax can be adapted and used outside of this package
  in lavaan
