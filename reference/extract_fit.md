# Extract fit statistics of lavaan objects

Extract fit statistics of lavaan objects

## Usage

``` r
extract_fit(..., details = FALSE)
```

## Arguments

- ...:

  lavaan object(s)

- details:

  Logical, if TRUE return all fit statistics. By default this is set to
  FALSE, a selection (chisq, npar, aic, bic, cfi, rmsea, srmr) of fit
  statistics is returned.

## Value

This function returns a tibble.

## References

David Robinson and Alex Hayes (2019). broom: Convert Statistical
Analysis Objects into Tidy Tibbles. R package version 0.5.2.
<https://CRAN.R-project.org/package=broom/>.

## Examples

``` r
# First create a lavaan object
if (FALSE) { # \dontrun{
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

# Now extract fit statistics  

extract_fit(bi_lcsm_01)
} # }
```
