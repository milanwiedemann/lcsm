# Simplified plot of bivariate lcsm
lavaan_syntax_bi <- fit_bi_lcsm(
  data = data_bi_lcsm,
  var_x = c("x1", "x2", "x3", "x4", "x5"),
  var_y = c("y1", "y2", "y3", "y4", "y5"),
  model_x = list(
    alpha_constant = TRUE,
    beta = TRUE,
    phi = TRUE
  ),
  model_y = list(
    alpha_constant = TRUE,
    beta = TRUE,
    phi = TRUE
  ),
  coupling = list(
    delta_lag_xy = TRUE,
    delta_lag_yx = TRUE
  ),
  return_lavaan_syntax = TRUE,
  return_lavaan_syntax_string = TRUE
)
lavaan_object_bi <- fit_bi_lcsm(
  data = data_bi_lcsm,
  var_x = c("x1", "x2", "x3", "x4", "x5"),
  var_y = c("y1", "y2", "y3", "y4", "y5"),
  model_x = list(
    alpha_constant = TRUE,
    beta = TRUE,
    phi = TRUE
  ),
  model_y = list(
    alpha_constant = TRUE,
    beta = TRUE,
    phi = TRUE
  ),
  coupling = list(
    delta_lag_xy = TRUE,
    delta_lag_yx = TRUE
  )
)
plot_lcsm_test <- plot_lcsm(
  lavaan_object = lavaan_object_bi,
  what = "cons", whatLabels = "invisible",
  lavaan_syntax = lavaan_syntax_bi,
  lcsm = "bivariate",
  return_plot_object = TRUE
)


test_that("Test plotting", {
  
  plot_lscm_test_typeof <- typeof(plot_lcsm_test)
  testthat::expect_equal(plot_lscm_test_typeof, "list")

  plot_lscm_test_edgelist_bidirectional <- plot_lcsm_test$Edgelist$bidirectional
  plot_lscm_expect_edgelist_bidirectional <- c(
    FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
    FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE,
    FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
    FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
    FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE,
    FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE,
    TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE,
    FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE,
    TRUE, TRUE, TRUE, TRUE, TRUE, TRUE
  )

  testthat::expect_identical(plot_lscm_test_edgelist_bidirectional, plot_lscm_expect_edgelist_bidirectional)

  # plot_lscm_test_Arguments_labels <- plot_lcsm_test$Arguments$labels
  # plot_lscm_test_Arguments_bidirectional <- plot_lcsm_test$Arguments$bidirectional
  # plot_lscm_test_Arguments_directed <- plot_lcsm_test$Arguments$directed
  # plot_lscm_test_Arguments_layout <- plot_lcsm_test$Arguments$layout
})


