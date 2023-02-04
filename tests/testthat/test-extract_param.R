model_test <- fit_uni_lcsm(
  data = data_uni_lcsm,
  var = names(data_uni_lcsm)[2:7],
  model = list(
    alpha_constant = TRUE,
    beta = TRUE,
    phi = FALSE
  )
)
param_test <- extract_param(model_test)


test_that("Extract estimate and standard error work", {
  param_test <- extract_param(model_test)
  
  param_test_label_expect <- c("gamma_lx1", "sigma2_lx1", "sigma2_ux", "alpha_g2", "sigma2_g2", "sigma_g2lx1", "beta_x")
  param_test_est_expect <- c(21.040258353750, 1.461951404947, 0.221240807867, -1.003052892255, 0.098594735006, 0.192811242320, 0.004475501092)
  param_test_se_expect <- c(0.059732724, 0.099222350, 0.009096491, 0.173317760, 0.009835117, 0.024510746, 0.008960581)

  expect_equal(param_test$label, param_test_label_expect, tolerance = 0.001)
  expect_equal(param_test$estimate, param_test_est_expect, tolerance = 0.001)
  expect_equal(param_test$std.error, param_test_se_expect, tolerance = 0.001)
})


test_that("Extract estimate print p", {
  param_test <- extract_param(model_test, printp = TRUE)
  
  printp_expect <- c("< .001", "< .001", "< .001", "< .001", "< .001", "< .001", ".617")
  expect_equal(param_test$p.value, printp_expect)
})
