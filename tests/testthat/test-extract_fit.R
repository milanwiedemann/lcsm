df_test <- fit_bi_lcsm(data = data_bi_lcsm, 
                          var_x = names(data_bi_lcsm)[2:4], 
                          var_y = names(data_bi_lcsm)[12:14],
                          model_x = list(alpha_constant = TRUE, 
                                         beta = TRUE),
                          model_y = list(alpha_constant = TRUE, 
                                         beta = TRUE),
                          coupling = list(delta_lag_xy = TRUE)
)


test_that("Extract fit details names works", {
  
  df_test_fit_details <- extract_fit(df_test, details = TRUE)
  names_extract_fit_details <- names(df_test_fit_details)
  names_extract_fit_details_expect <- c("model", "chisq", "npar", "agfi", "aic", "bic",
    "cfi", "rmsea", "rmsea.conf.high", "srmr", "tli", "converged",
    "estimator", "ngroups", "missing_method", "nobs", "norig", "nexcluded")
  
  expect_equal(names_extract_fit_details, names_extract_fit_details_expect)
})


test_that("Extract fit details names works", {
  
  df_test_fit <- extract_fit(df_test, details = FALSE)
  expect_equal(df_test_fit$model, "1", tolerance = .01)
  expect_equal(df_test_fit$chisq, 14.4, tolerance = .01)
  expect_equal(df_test_fit$npar, 20, tolerance = .01)
  expect_equal(df_test_fit$aic, 5995.2, tolerance = .01)
  expect_equal(df_test_fit$bic, 6079.4, tolerance = .01)
  expect_equal(df_test_fit$cfi, 0.9948, tolerance = .01)
  expect_equal(df_test_fit$rmsea, 0.046, tolerance = .01)
  expect_equal(df_test_fit$srmr, 0.044, tolerance = .01)
  })
