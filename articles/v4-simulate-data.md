# Simulate data to explore the effect of different parameters

``` r

library(lcsm)
#> This is lcsm 0.3.3
#> Please report any issues or ideas at:
#> https://github.com/milanwiedemann/lcsm/issues
#> 
```

The functions
[`sim_uni_lcsm()`](https://milanwiedemann.github.io/lcsm/reference/sim_uni_lcsm.md)
and
[`sim_bi_lcsm()`](https://milanwiedemann.github.io/lcsm/reference/sim_bi_lcsm.md)
simulate data based on some some parameters that can be specified. A
full list of parameters that can be specified for the data simulation
can be found in the [README](https://github.com/milanwiedemann/lcsm/)
file on GitHub.

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
#> Warning: The following parameters are specified in the LCSM but no parameter estimates have been entered in 'model_param':
#> -  alpha_g2
#> -  sigma2_g2
#> -  sigma_g2lx1
#> # A tibble: 1,000 × 6
#>       id    x1    x2    x3    x4    x5
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1     1  21.6  NA    25.2  26.6  NA  
#>  2     2  NA    20.6  NA    19.2  21.3
#>  3     3  NA    24.8  NA    30.0  32.1
#>  4     4  19.7  20.2  21.3  NA    NA  
#>  5     5  NA    19.3  NA    19.7  20.4
#>  6     6  19.8  18.8  19.0  NA    15.3
#>  7     7  NA    23.7  25.7  NA    NA  
#>  8     8  20.4  21.2  21.6  22.5  24.0
#>  9     9  22.6  NA    NA    20.4  18.3
#> 10    10  20.6  22.0  21.6  NA    22.0
#> # ℹ 990 more rows
```

It is also possible to return the lavaan syntax instead of simulating
data for further manual specifications. The modified object could then
be used to simulate data using
[`lavaan::simulateData()`](https://rdrr.io/pkg/lavaan/man/simulateData.html).

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
#> Parameter estimates for the data simulation are taken from the argument 'model_param'.
#> All parameter estimates for the LCSM have been specified in the argument 'model_param'.
```

I’m using the function [`cat()`](https://rdrr.io/r/base/cat.html) here
to make the output more readable. This has no effect on the information
that is returned, it is just another way to format the syntax and
`lavaan` knows how to read either format as long as it’s a string,
i.e. surrounded by quotation marks.

``` r

cat(simsyntax)
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
#> lx1 ~ 21 * 1 
#> lx2 ~ 0 * 1 
#> lx3 ~ 0 * 1 
#> lx4 ~ 0 * 1 
#> lx5 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> lx1 ~~ 0.5 * lx1 
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
#> x1 ~~ 0.2 * x1 
#> x2 ~~ 0.2 * x2 
#> x3 ~~ 0.2 * x3 
#> x4 ~~ 0.2 * x4 
#> x5 ~~ 0.2 * x5 
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
#> g2 ~ -0.4 * 1 
#> # Specify constant change factor variance 
#> g2 ~~ 0.4 * g2 
#> # Specify constant change factor covariance with the initial true score 
#> g2 ~~ 0.2 * lx1
#> # Specify proportional change component 
#> dx2 ~ -0.1 * lx1 
#> dx3 ~ -0.1 * lx2 
#> dx4 ~ -0.1 * lx3 
#> dx5 ~ -0.1 * lx4 
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
#> ly1 ~ 5 * 1 
#> ly2 ~ 0 * 1 
#> ly3 ~ 0 * 1 
#> ly4 ~ 0 * 1 
#> ly5 ~ 0 * 1 
#> # Specify variance of latent true scores 
#> ly1 ~~ 0.2 * ly1 
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
#> y1 ~~ 0.2 * y1 
#> y2 ~~ 0.2 * y2 
#> y3 ~~ 0.2 * y3 
#> y4 ~~ 0.2 * y4 
#> y5 ~~ 0.2 * y5 
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
#> j2 ~ -0.2 * 1 
#> # Specify constant change factor variance 
#> j2 ~~ 0.1 * j2 
#> # Specify constant change factor covariance with the initial true score 
#> j2 ~~ 0.02 * ly1
#> # Specify proportional change component 
#> dy2 ~ -0.2 * ly1 
#> dy3 ~ -0.2 * ly2 
#> dy4 ~ -0.2 * ly3 
#> dy5 ~ -0.2 * ly4 
#> # Specify autoregression of change score 
#> dy3 ~ 0.1 * dy2 
#> dy4 ~ 0.1 * dy3 
#> dy5 ~ 0.1 * dy4 
#> # Specify residual covariances 
#> x1 ~~ 0.01 * y1 
#> x2 ~~ 0.01 * y2 
#> x3 ~~ 0.01 * y3 
#> x4 ~~ 0.01 * y4 
#> x5 ~~ 0.01 * y5 
#> # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#> # Specify covariances betweeen specified change components (alpha) and intercepts (initial latent true scores lx1 and ly1) ----
#> # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#> # Specify covariance of intercepts 
#> lx1 ~~ 0.2 * ly1 
#> # Specify covariance of constant change and intercept between constructs 
#> ly1 ~~ 0.1 * g2 
#> # Specify covariance of constant change and intercept between constructs 
#> lx1 ~~ 0.1 * j2 
#> # Specify covariance of constant change factors between constructs 
#> g2 ~~ 0.01 * j2 
#> # # # # # # # # # # # # # # # # # # # # # # # # # # #
#> # Specify between-construct coupling parameters ----
#> # # # # # # # # # # # # # # # # # # # # # # # # # # #
#> # Change score x (t) is determined by true score y (t-1)  
#> dx2 ~ 0.13 * ly1 
#> dx3 ~ 0.13 * ly2 
#> dx4 ~ 0.13 * ly3 
#> dx5 ~ 0.13 * ly4 
#> # Change score y (t) is determined by change score x (t-1)  
#> dy3 ~ 0.4 * dx2 
#> dy4 ~ 0.4 * dx3 
#> dy5 ~ 0.4 * dx4
```
