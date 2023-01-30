## code to prepare `lcsm_data` dataset goes here
library(lavaan)

# Simulate data from bivariate LCSM parameters 
# this is the same data as df_sim in the tutorial paper
lcsm_data <- sim_bi_lcsm(timepoints = 5, 
                      sample.nobs = 500,
                      na_x_pct = .15,
                      na_y_pct = .1,
                      model_x = list(alpha_constant = TRUE, 
                                     beta = TRUE, 
                                     phi = FALSE),
                      model_x_param = list(gamma_lx1 = 29,
                                           sigma2_lx1 = .5,
                                           sigma2_ux = .2,
                                           alpha_g2 = -.3,
                                           sigma2_g2 = .6,
                                           sigma_g2lx1 = .2,
                                           beta_x = -.1),
                      model_y = list(alpha_constant = TRUE, 
                                     beta = TRUE, 
                                     phi = TRUE),
                      model_y_param = list(gamma_ly1 = 15,
                                           sigma2_ly1 = .2,
                                           sigma2_uy = .2,
                                           alpha_j2 = -.4,
                                           sigma2_j2 = .1,
                                           sigma_j2ly1 = .02,
                                           beta_y = -.2,
                                           phi_y = .1),
                      coupling = list(xi_lag_yx = TRUE),
                      coupling_param =list(sigma_su = .01,
                                           sigma_ly1lx1 = .2,
                                           sigma_g2ly1 = .1,
                                           sigma_j2lx1 = .1,
                                           sigma_j2g2 = .01,
                                           xi_lag_yx = .5),
                      seed = 1234)

usethis::use_data(lcsm_data, overwrite = TRUE)