# Parameter estimates and fit statistics of LCSMs

``` r

library(lcsm)
#> This is lcsm 0.3.3
#> Please report any issues or ideas at:
#> https://github.com/milanwiedemann/lcsm/issues
#> 
library(lavaan)
#> This is lavaan 0.7-2
#> lavaan is FREE software! Please report any bugs.
```

The main underlying functions to extract parameters and fit statistics
come from the `broom` package:
[`broom::tidy()`](https://generics.r-lib.org/reference/tidy.html) and
[`broom::glance()`](https://generics.r-lib.org/reference/glance.html).
The functions
[`extract_param()`](https://milanwiedemann.github.io/lcsm/reference/extract_param.md)
and
[`extract_fit()`](https://milanwiedemann.github.io/lcsm/reference/extract_fit.md)
offer some tools that I find helpful when running LCSMs in R, for
example:

- [`extract_param()`](https://milanwiedemann.github.io/lcsm/reference/extract_param.md):
  only one row per estimated parameter,
- [`extract_fit()`](https://milanwiedemann.github.io/lcsm/reference/extract_fit.md):
  fit statistics for multiple `lavaan` objects can be extracted.

### Create univariate models

``` r

# First fit some latent change score models

# No change model
uni_lcsm_01 <- fit_uni_lcsm(data = data_uni_lcsm, 
                            var = c("x1", "x2", "x3", "x4", "x5"),
                            model = list(alpha_constant = FALSE, 
                                         beta = FALSE, 
                                         phi = FALSE))
#> Warning: lavaan->lav_data_full():  
#>    some cases are empty and will be ignored: 239.
# Constant change only model
uni_lcsm_02 <- fit_uni_lcsm(data = data_uni_lcsm, 
                            var = c("x1", "x2", "x3", "x4", "x5"),
                            model = list(alpha_constant = TRUE, 
                                         beta = FALSE, 
                                         phi = FALSE))
#> Warning: lavaan->lav_data_full():  
#>    some cases are empty and will be ignored: 239.

# Constant change and proportional change (Dual change model)
uni_lcsm_03 <- fit_uni_lcsm(data = data_uni_lcsm, 
                            var = c("x1", "x2", "x3", "x4", "x5"),
                            model = list(alpha_constant = TRUE, 
                                         beta = TRUE, 
                                         phi = FALSE))
#> Warning: lavaan->lav_data_full():  
#>    some cases are empty and will be ignored: 239.
```

### Extract fit statistics

This function takes the `lavaan` objects as input and returns some fit
statistics. More fit statistics can be returned using the argument
`details = TRUE`.

``` r

# Extract fit statistics
fit_uni_lcsm <- extract_fit(uni_lcsm_01, uni_lcsm_02, uni_lcsm_03)

# Print table of parameter estimates
knitr::kable(fit_uni_lcsm, 
             digits = 3, 
             caption = "Parameter estimates for bivariate LCSM")
```

| model |    chisq | npar |      aic |      bic |   cfi | rmsea |  srmr |
|:------|---------:|-----:|---------:|---------:|------:|------:|------:|
| 1     | 2761.423 |    3 | 7371.135 | 7383.772 | 0.000 | 0.569 | 2.070 |
| 2     |   17.734 |    6 | 4633.446 | 4658.721 | 0.998 | 0.023 | 0.068 |
| 3     |   11.615 |    7 | 4629.327 | 4658.815 | 1.000 | 0.000 | 0.054 |

Parameter estimates for bivariate LCSM {.table}

### Extract parameters

``` r

# Now extract parameter estimates
param_uni_lcsm_02 <- extract_param(uni_lcsm_03, printp = TRUE)

# Print table of parameter estimates
knitr::kable(param_uni_lcsm_02, 
             digits = 3, 
             caption = "Parameter estimates for bivariate LCSM")
```

| label       | estimate | std.error | statistic | p.value | std.lv | std.all |
|:------------|---------:|----------:|----------:|:--------|-------:|--------:|
| gamma_lx1   |   21.066 |     0.060 |   348.365 | \< .001 | 17.456 |  17.456 |
| sigma2_lx1  |    1.456 |     0.101 |    14.413 | \< .001 |  1.000 |   1.000 |
| sigma2_ux   |    0.231 |     0.011 |    20.336 | \< .001 |  0.231 |   0.137 |
| alpha_g2    |   -0.157 |     0.287 |    -0.547 | .584    | -0.450 |  -0.450 |
| sigma2_g2   |    0.122 |     0.015 |     7.916 | \< .001 |  1.000 |   1.000 |
| sigma_g2lx1 |    0.264 |     0.033 |     7.961 | \< .001 |  0.627 |   0.627 |
| beta_x      |   -0.038 |     0.015 |    -2.606 | .009    | -0.142 |  -0.142 |

Parameter estimates for bivariate LCSM {.table}

## TODOs

- For now see example in README file on Github or shinyApp “shinychange”
- step by step example here building all the way up to a univariate lcsm
- select data
- run univariate models
- add parameters and compare results using anova and model parameters
- use grimm 2017 data?
