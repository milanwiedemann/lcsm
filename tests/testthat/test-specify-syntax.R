test_that("uni (3x) null model", {
  
lavaan_syntax_expect <- c(
"# Specify latent true scores 
lx1 =~ 1 * x1 
lx2 =~ 1 * x2 
lx3 =~ 1 * x3 
# Specify mean of latent true scores 
lx1 ~ gamma_lx1 * 1 
lx2 ~ 0 * 1 
lx3 ~ 0 * 1 
# Specify variance of latent true scores 
lx1 ~~ sigma2_lx1 * lx1 
lx2 ~~ 0 * lx2 
lx3 ~~ 0 * lx3 
# Specify intercept of obseved scores 
x1 ~ 0 * 1 
x2 ~ 0 * 1 
x3 ~ 0 * 1 
# Specify variance of observed scores 
x1 ~~ sigma2_ux * x1 
x2 ~~ sigma2_ux * x2 
x3 ~~ sigma2_ux * x3 
# Specify autoregressions of latent variables 
lx2 ~ 1 * lx1 
lx3 ~ 1 * lx2 
# Specify latent change scores 
dx2 =~ 1 * lx2 
dx3 =~ 1 * lx3 
# Specify latent change scores means 
dx2 ~ 0 * 1 
dx3 ~ 0 * 1 
# Specify latent change scores variances 
dx2 ~~ 0 * dx2 
dx3 ~~ 0 * dx3 
")

lavaan_syntax_test <- specify_uni_lcsm(timepoints = 3,
                                       var = "x",  
                                       change_letter = "g",
                                       model = list(alpha_constant = FALSE, 
                                                    beta = FALSE, 
                                                    phi = FALSE))
  
  expect_equal(lavaan_syntax_test, lavaan_syntax_expect)
  
})

test_that("uni (3x) alpha", {
  
lavaan_syntax_expect <- c(
"# Specify latent true scores 
lx1 =~ 1 * x1 
lx2 =~ 1 * x2 
lx3 =~ 1 * x3 
# Specify mean of latent true scores 
lx1 ~ gamma_lx1 * 1 
lx2 ~ 0 * 1 
lx3 ~ 0 * 1 
# Specify variance of latent true scores 
lx1 ~~ sigma2_lx1 * lx1 
lx2 ~~ 0 * lx2 
lx3 ~~ 0 * lx3 
# Specify intercept of obseved scores 
x1 ~ 0 * 1 
x2 ~ 0 * 1 
x3 ~ 0 * 1 
# Specify variance of observed scores 
x1 ~~ sigma2_ux * x1 
x2 ~~ sigma2_ux * x2 
x3 ~~ sigma2_ux * x3 
# Specify autoregressions of latent variables 
lx2 ~ 1 * lx1 
lx3 ~ 1 * lx2 
# Specify latent change scores 
dx2 =~ 1 * lx2 
dx3 =~ 1 * lx3 
# Specify latent change scores means 
dx2 ~ 0 * 1 
dx3 ~ 0 * 1 
# Specify latent change scores variances 
dx2 ~~ 0 * dx2 
dx3 ~~ 0 * dx3 
# Specify constant change factor 
g2 =~ 1 * dx2 + 1 * dx3 
# Specify constant change factor mean 
g2 ~ alpha_g2 * 1 
# Specify constant change factor variance 
g2 ~~ sigma2_g2 * g2 
# Specify constant change factor covariance with the initial true score 
g2 ~~ sigma_g2lx1 * lx1
")
  
  lavaan_syntax_test <- specify_uni_lcsm(timepoints = 3,
                     var = "x",
                     change_letter = "g",
                     model = list(alpha_constant = TRUE,
                                  beta = FALSE,
                                  phi = FALSE))
  
  expect_equal(lavaan_syntax_test, lavaan_syntax_expect)
  
})

test_that("uni (3x) beta", {
  
lavaan_syntax_expect <- c(
"# Specify latent true scores 
lx1 =~ 1 * x1 
lx2 =~ 1 * x2 
lx3 =~ 1 * x3 
# Specify mean of latent true scores 
lx1 ~ gamma_lx1 * 1 
lx2 ~ 0 * 1 
lx3 ~ 0 * 1 
# Specify variance of latent true scores 
lx1 ~~ sigma2_lx1 * lx1 
lx2 ~~ 0 * lx2 
lx3 ~~ 0 * lx3 
# Specify intercept of obseved scores 
x1 ~ 0 * 1 
x2 ~ 0 * 1 
x3 ~ 0 * 1 
# Specify variance of observed scores 
x1 ~~ sigma2_ux * x1 
x2 ~~ sigma2_ux * x2 
x3 ~~ sigma2_ux * x3 
# Specify autoregressions of latent variables 
lx2 ~ 1 * lx1 
lx3 ~ 1 * lx2 
# Specify latent change scores 
dx2 =~ 1 * lx2 
dx3 =~ 1 * lx3 
# Specify latent change scores means 
dx2 ~ 0 * 1 
dx3 ~ 0 * 1 
# Specify latent change scores variances 
dx2 ~~ 0 * dx2 
dx3 ~~ 0 * dx3 
# Specify proportional change component 
dx2 ~ beta_x * lx1 
dx3 ~ beta_x * lx2 
")
  
  lavaan_syntax_test <- specify_uni_lcsm(timepoints = 3,
                                         var = "x",
                                         change_letter = "g",
                                         model = list(alpha_constant = FALSE,
                                                      beta = TRUE,
                                                      phi = FALSE))
  
  expect_equal(lavaan_syntax_test, lavaan_syntax_expect)
  
})

test_that("uni (3x) phi", {
  
lavaan_syntax_expect <- c(
"# Specify latent true scores 
lx1 =~ 1 * x1 
lx2 =~ 1 * x2 
lx3 =~ 1 * x3 
# Specify mean of latent true scores 
lx1 ~ gamma_lx1 * 1 
lx2 ~ 0 * 1 
lx3 ~ 0 * 1 
# Specify variance of latent true scores 
lx1 ~~ sigma2_lx1 * lx1 
lx2 ~~ 0 * lx2 
lx3 ~~ 0 * lx3 
# Specify intercept of obseved scores 
x1 ~ 0 * 1 
x2 ~ 0 * 1 
x3 ~ 0 * 1 
# Specify variance of observed scores 
x1 ~~ sigma2_ux * x1 
x2 ~~ sigma2_ux * x2 
x3 ~~ sigma2_ux * x3 
# Specify autoregressions of latent variables 
lx2 ~ 1 * lx1 
lx3 ~ 1 * lx2 
# Specify latent change scores 
dx2 =~ 1 * lx2 
dx3 =~ 1 * lx3 
# Specify latent change scores means 
dx2 ~ 0 * 1 
dx3 ~ 0 * 1 
# Specify latent change scores variances 
dx2 ~~ 0 * dx2 
dx3 ~~ 0 * dx3 
# Specify autoregression of change score 
dx3 ~ phi_x * dx2 
")
  
  lavaan_syntax_test <- specify_uni_lcsm(timepoints = 3,
                                         var = "x",
                                         change_letter = "g",
                                         model = list(alpha_constant = FALSE,
                                                      beta = FALSE,
                                                      phi = TRUE))
  
  expect_equal(lavaan_syntax_test, lavaan_syntax_expect)
  
})

test_that("uni (3x) alpha beta", {
  
lavaan_syntax_expect <- c(
"# Specify latent true scores 
lx1 =~ 1 * x1 
lx2 =~ 1 * x2 
lx3 =~ 1 * x3 
# Specify mean of latent true scores 
lx1 ~ gamma_lx1 * 1 
lx2 ~ 0 * 1 
lx3 ~ 0 * 1 
# Specify variance of latent true scores 
lx1 ~~ sigma2_lx1 * lx1 
lx2 ~~ 0 * lx2 
lx3 ~~ 0 * lx3 
# Specify intercept of obseved scores 
x1 ~ 0 * 1 
x2 ~ 0 * 1 
x3 ~ 0 * 1 
# Specify variance of observed scores 
x1 ~~ sigma2_ux * x1 
x2 ~~ sigma2_ux * x2 
x3 ~~ sigma2_ux * x3 
# Specify autoregressions of latent variables 
lx2 ~ 1 * lx1 
lx3 ~ 1 * lx2 
# Specify latent change scores 
dx2 =~ 1 * lx2 
dx3 =~ 1 * lx3 
# Specify latent change scores means 
dx2 ~ 0 * 1 
dx3 ~ 0 * 1 
# Specify latent change scores variances 
dx2 ~~ 0 * dx2 
dx3 ~~ 0 * dx3 
# Specify constant change factor 
g2 =~ 1 * dx2 + 1 * dx3 
# Specify constant change factor mean 
g2 ~ alpha_g2 * 1 
# Specify constant change factor variance 
g2 ~~ sigma2_g2 * g2 
# Specify constant change factor covariance with the initial true score 
g2 ~~ sigma_g2lx1 * lx1
# Specify proportional change component 
dx2 ~ beta_x * lx1 
dx3 ~ beta_x * lx2 
")
  
  lavaan_syntax_test <-  specify_uni_lcsm(timepoints = 3,
                                          var = "x",
                                          change_letter = "g",
                                          model = list(alpha_constant = TRUE,
                                                       beta = TRUE,
                                                       phi = FALSE))
    
  expect_equal(lavaan_syntax_test, lavaan_syntax_expect)
  
})

test_that("uni (4x) alpha beta phi", {
  
lavaan_syntax_expect <- c(
"# Specify latent true scores 
lx1 =~ 1 * x1 
lx2 =~ 1 * x2 
lx3 =~ 1 * x3 
lx4 =~ 1 * x4 
# Specify mean of latent true scores 
lx1 ~ gamma_lx1 * 1 
lx2 ~ 0 * 1 
lx3 ~ 0 * 1 
lx4 ~ 0 * 1 
# Specify variance of latent true scores 
lx1 ~~ sigma2_lx1 * lx1 
lx2 ~~ 0 * lx2 
lx3 ~~ 0 * lx3 
lx4 ~~ 0 * lx4 
# Specify intercept of obseved scores 
x1 ~ 0 * 1 
x2 ~ 0 * 1 
x3 ~ 0 * 1 
x4 ~ 0 * 1 
# Specify variance of observed scores 
x1 ~~ sigma2_ux * x1 
x2 ~~ sigma2_ux * x2 
x3 ~~ sigma2_ux * x3 
x4 ~~ sigma2_ux * x4 
# Specify autoregressions of latent variables 
lx2 ~ 1 * lx1 
lx3 ~ 1 * lx2 
lx4 ~ 1 * lx3 
# Specify latent change scores 
dx2 =~ 1 * lx2 
dx3 =~ 1 * lx3 
dx4 =~ 1 * lx4 
# Specify latent change scores means 
dx2 ~ 0 * 1 
dx3 ~ 0 * 1 
dx4 ~ 0 * 1 
# Specify latent change scores variances 
dx2 ~~ 0 * dx2 
dx3 ~~ 0 * dx3 
dx4 ~~ 0 * dx4 
# Specify constant change factor 
g2 =~ 1 * dx2 + 1 * dx3 + 1 * dx4 
# Specify constant change factor mean 
g2 ~ alpha_g2 * 1 
# Specify constant change factor variance 
g2 ~~ sigma2_g2 * g2 
# Specify constant change factor covariance with the initial true score 
g2 ~~ sigma_g2lx1 * lx1
# Specify proportional change component 
dx2 ~ beta_x * lx1 
dx3 ~ beta_x * lx2 
dx4 ~ beta_x * lx3 
# Specify autoregression of change score 
dx3 ~ phi_x * dx2 
dx4 ~ phi_x * dx3 
")
  
  lavaan_syntax_test <- specify_uni_lcsm(timepoints = 4,
                     var = "x",
                     change_letter = "g",
                     model = list(alpha_constant = TRUE,
                                  beta = TRUE,
                                  phi = TRUE))
  
  expect_equal(lavaan_syntax_test, lavaan_syntax_expect)
  
})


test_that("uni (3y) alpha beta phi", {
  
lavaan_syntax_expect <- c(
"# Specify latent true scores 
ly1 =~ 1 * y1 
ly2 =~ 1 * y2 
ly3 =~ 1 * y3 
# Specify mean of latent true scores 
ly1 ~ gamma_ly1 * 1 
ly2 ~ 0 * 1 
ly3 ~ 0 * 1 
# Specify variance of latent true scores 
ly1 ~~ sigma2_ly1 * ly1 
ly2 ~~ 0 * ly2 
ly3 ~~ 0 * ly3 
# Specify intercept of obseved scores 
y1 ~ 0 * 1 
y2 ~ 0 * 1 
y3 ~ 0 * 1 
# Specify variance of observed scores 
y1 ~~ sigma2_uy * y1 
y2 ~~ sigma2_uy * y2 
y3 ~~ sigma2_uy * y3 
# Specify autoregressions of latent variables 
ly2 ~ 1 * ly1 
ly3 ~ 1 * ly2 
# Specify latent change scores 
dy2 =~ 1 * ly2 
dy3 =~ 1 * ly3 
# Specify latent change scores means 
dy2 ~ 0 * 1 
dy3 ~ 0 * 1 
# Specify latent change scores variances 
dy2 ~~ 0 * dy2 
dy3 ~~ 0 * dy3 
# Specify constant change factor 
j2 =~ 1 * dy2 + 1 * dy3 
# Specify constant change factor mean 
j2 ~ alpha_j2 * 1 
# Specify constant change factor variance 
j2 ~~ sigma2_j2 * j2 
# Specify constant change factor covariance with the initial true score 
j2 ~~ sigma_j2ly1 * ly1
# Specify proportional change component 
dy2 ~ beta_y * ly1 
dy3 ~ beta_y * ly2 
# Specify autoregression of change score 
dy3 ~ phi_y * dy2 
")
  
  lavaan_syntax_test <- specify_uni_lcsm(timepoints = 3,
                                         var = "y",
                                         change_letter = "j",
                                         model = list(alpha_constant = TRUE,
                                                      beta = TRUE,
                                                      phi = TRUE))
  
  expect_equal(lavaan_syntax_test, lavaan_syntax_expect)
  
})
