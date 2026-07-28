# Extract labelled parameters of lavaan objects

Extract labelled parameters of lavaan objects

## Usage

``` r
extract_param(lavaan_object, printp = FALSE)
```

## Arguments

- lavaan_object:

  lavaan object.

- printp:

  If TRUE convert into easily readable p values.

## Value

This function returns a tibble with labelled parameters.

## References

David Robinson and Alex Hayes (2019). broom: Convert Statistical
Analysis Objects into Tidy Tibbles. R package version 0.5.2.
<https://CRAN.R-project.org/package=broom/>

## Examples

``` r
# First create a lavaan object
bi_lcsm_01 <- fit_bi_lcsm(data = data_bi_lcsm, 
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

# Now extract parameter estimates              
extract_param(bi_lcsm_01)
#> # A tibble: 22 × 7
#>    label       estimate std.error statistic    p.value std.lv std.all
#>    <chr>          <dbl>     <dbl>     <dbl>      <dbl>  <dbl>   <dbl>
#>  1 gamma_lx1    21.1       0.0377   560.    0          29.3    29.3  
#>  2 sigma2_lx1    0.517     0.0417    12.4   0           1       1    
#>  3 sigma2_ux     0.171     0.0109    15.6   0           0.171   0.248
#>  4 alpha_g2     -0.250     0.856     -0.292 0.770      -0.383  -0.383
#>  5 sigma2_g2     0.426     0.0455     9.38  0           1       1    
#>  6 sigma_g2lx1   0.143     0.0300     4.76  0.00000193  0.304   0.304
#>  7 beta_x       -0.0905    0.0642    -1.41  0.159      -0.101  -0.101
#>  8 gamma_ly1     5.03      0.0300   168.    0          10.4    10.4  
#>  9 sigma2_ly1    0.235     0.0275     8.53  0           1       1    
#> 10 sigma2_uy     0.177     0.0118    15.0   0           0.177   0.429
#> # ℹ 12 more rows
```
