
# Specify latent true scores (lts)
specify_lts <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("lts", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify latent true scores \n "
  for (i in 1:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " =~ 1 * ", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("lts", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lts", variable, sep = "_")))
}

# Specify mean of latent true scores (lts_mean)
specify_lts_mean <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("lts_mean", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify mean of latent true scores \n "
  
  # Write first line out of loop to label gamma_variable1
  lavaan_str <- base::paste(lavaan_str, "l", variable, "1", " ~ ", "gamma_", "l", variable, "1", " * 1", " \n ", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " ~ 0 * 1", " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("lts_mean", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lts_mean", variable, sep = "_")))
}

# Specify variance of latent true scores (lts_var)
specify_lts_var <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("lts_var", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify variance of latent true scores \n "
  
  # Write first line out of loop to label sigma2_lvariable1
  lavaan_str <- base::paste(lavaan_str, "l", variable, "1", " ~~ ", "sigma2_", "l", variable, "1", " * ", "l", variable, "1", " \n ", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " ~~ 0 * ", "l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginningvar
  base::assign(base::paste("lts_var", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lts_var", variable, sep = "_")))
}

# Specify intercept of obseved scores (os_int)
specify_os_int <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("os_int", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify intercept of obseved scores \n "
  
  for (i in 1:timepoints) {
    lavaan_str <- base::paste(lavaan_str, variable, i, " ~ 0 * 1", " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("os_int", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("os_int", variable, sep = "_")))
}


# Specify variance of observed scores (os_resid)
specify_os_resid <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("os_resid", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify variance of observed scores \n "
  
  # Write first line out of loop to label sigma2_lvariable1
  lavaan_str <- base::paste(lavaan_str, variable, "1", " ~~ ", "sigma2_u", variable, " * ", variable, "1", " \n ", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, variable, i, " ~~ ", "sigma2_u", variable, " * ", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginningvar
  base::assign(base::paste("os_resid", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("os_resid", variable, sep = "_")))
}


# Specify autoregressions of latent variables
specify_lts_autoreg <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("lts_autoreg", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify autoregressions of latent variables \n "
  
  for (i in 1:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i + 1, " ~ 1 * ","l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("lts_autoreg", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lts_autoreg", variable, sep = "_")))
}


# Specify latent change scores
specify_lcs <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("lcs", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify latent change scores \n "
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " =~ 1 * ","l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("lcs", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lcs", variable, sep = "_")))
}


# Specify latent change scores means
specify_lcs_mean <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("lcs_mean", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify latent change scores means \n "
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " ~ 0 * ", "1", " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("lcs_mean", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lcs_mean", variable, sep = "_")))
}



# Specify latent change scores variances
specify_lcs_var <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("lcs_var", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify latent change scores variances \n "
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " ~~ ", "0 * ", "d", variable, i, " \n ", sep = "")
  }
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("lcs_var", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lcs_var", variable, sep = "_")))
}

# Specify constant change factor
specify_constant_change <- function(timepoints, variable, change_letter){
  # Create empty object
  base::assign(base::paste("constant_change", variable, sep = "_"), "")
  
  lavaan_str <- "# Specify constant change factor \n "
  
  lavaan_str_0 <- paste(lavaan_str, change_letter, "2 =~", sep = "")
  
  # Create empty str object for lavaan syntax
  lavaan_str_1 <- ""
  
  for (i in 2:(timepoints)) {
    lavaan_str_1 <- base::paste(lavaan_str_1, "1", " * ", "d", variable, i, " + ", sep = "")
  }
  
  # Combine first string object with loop
  lavaan_str_3 <- paste(lavaan_str_0, lavaan_str_1)
  
  # Delete + at the end of loop as not needed
  lavaan_str_4 <- base::substr(lavaan_str_3, 1, nchar(lavaan_str_3) - 3)

  # Add new line at the end
  lavaan_str_5 <- paste(lavaan_str_4, " \n ", sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("constant_change", variable, sep = "_"), lavaan_str_5)
  
  # Return string object
  base::eval(rlang::sym(base::paste("constant_change", variable, sep = "_")))
}

# Specify linear change factor
specify_linear_change <- function(timepoints, variable, change_letter){
  # Create empty object
  base::assign(base::paste("linear_change", variable, sep = "_"), "")
  
  lavaan_str <- "# Specify linear change factor \n "
  
  lavaan_str_0 <- paste(lavaan_str, change_letter, "3", " =~", sep = "")
  
  # Create empty str object for lavaan syntax
  lavaan_str_1 <- ""
  
  for (i in 2:(timepoints)) {
    lavaan_str_1 <- base::paste(lavaan_str_1, (i - 1), " * ", "d", variable, i, " + ", sep = "")
  }
  
  # Combine first string object with loop
  lavaan_str_3 <- paste(lavaan_str_0, lavaan_str_1)
  
  # Delete + at the end of loop as not needed
  lavaan_str_4 <- base::substr(lavaan_str_3, 1, nchar(lavaan_str_3) - 3)
  
  # Add new line at the end
  lavaan_str_5 <- paste(lavaan_str_4, " \n ", sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("linear_change", variable, sep = "_"), lavaan_str_5)
  
  # Return string object
  base::eval(rlang::sym(base::paste("linear_change", variable, sep = "_")))
}


# Specify piecewise constant change factor
specify_constant_change_piecewise <- function(timepoints, variable, change_letter, changepoint){
  # Create empty object
  base::assign(base::paste("constant_change_piece", variable, sep = "_"), "")
  
  lavaan_str_1_0 <- "# Specify first piecewise constant change factor \n "
  
  lavaan_str_2_0 <- "# Specify second piecewise constant change factor \n "
  
  
  lavaan_str_1_1 <- paste(lavaan_str_1_0, change_letter, "2 =~ ", sep = "")
  
  lavaan_str_2_1 <- paste(lavaan_str_2_0, change_letter, "3 =~ ", sep = "")
  
  
  # Create empty str object for lavaan syntax
  lavaan_str_1_2 <- ""
  lavaan_str_2_2 <- ""
  
  for (i in 2:changepoint) {
    lavaan_str_1_2 <- base::paste(lavaan_str_1_2, "1", " * ", "d", variable, i, " + ", sep = "")
  }
  
  for (j in (changepoint + 1):timepoints) {
    lavaan_str_2_2 <- base::paste(lavaan_str_2_2, "1", " * ", "d", variable, j, " + ", sep = "")
  }
  
  # Combine first string object with loop
  lavaan_str_1_3 <- paste(lavaan_str_1_1, lavaan_str_1_2, sep = "")
  
  lavaan_str_2_3 <- paste(lavaan_str_2_1, lavaan_str_2_2, sep = "")
  
  # Delete + at the end of loop as not needed
  lavaan_str_1_4 <- base::substr(lavaan_str_1_3, 1, nchar(lavaan_str_1_3) - 3)
  
  lavaan_str_2_4 <- base::substr(lavaan_str_2_3, 1, nchar(lavaan_str_2_3) - 3)
  
  # Add new line at the end
  lavaan_str_1_5 <- paste(lavaan_str_1_4, " \n ", sep = "")
  
  lavaan_str_2_5 <- paste(lavaan_str_2_4, " \n ", sep = "")
                        
  # Combine both
  lavaan_str_3 <- paste(lavaan_str_1_5, lavaan_str_2_5, sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("constant_change_piece", variable, sep = "_"), lavaan_str_3)
  
  # Return string object
  base::eval(rlang::sym(base::paste("constant_change_piece", variable, sep = "_")))
}

# Specify constant change factor mean
specify_constant_change_mean <- function(timepoints, variable, change_letter, change_number){
  # Create empty object
  base::assign(base::paste("constant_change_mean", variable, sep = "_"), "")
  
  lavaan_str <- "# Specify constant change factor mean \n "
  
  lavaan_str <- paste(lavaan_str, change_letter, change_number, " ~ ", "alpha_", change_letter, change_number, " * 1", " \n", sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("constant_change_mean", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("constant_change_mean", variable, sep = "_")))
}

# Specify constant change factor variance
specify_constant_change_var <- function(timepoints, variable, change_letter, change_number){
  # Create empty object
  base::assign(base::paste("constant_change_var", variable, sep = "_"), "")
  
  lavaan_str <- "# Specify constant change factor variance \n "
  
  lavaan_str <- paste(lavaan_str, change_letter, change_number, " ~~ ", "sigma2_", change_letter, change_number, " * ", change_letter, change_number, " \n", sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("constant_change_var", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("constant_change_var", variable, sep = "_")))
}


# Specify constant change factor covariance with the initial true score
specify_constant_change_covar_initial_ts <- function(timepoints, variable, change_letter, change_number){
  # Create empty object
  base::assign(base::paste("constant_change_covar_initial_ts", variable, sep = "_"), "")
  
  lavaan_str <- "# Specify constant change factor covariance with the initial true score \n "
  
  lavaan_str <- paste(lavaan_str, change_letter, change_number, " ~~ ", "sigma_", change_letter, change_number, "l", variable, "1", " * ", "l", variable, "1", "\n", sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("constant_change_covar_initial_ts", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("constant_change_covar_initial_ts", variable, sep = "_")))
}

# Specify covariance of two change scores
specify_uni_change_covar <- function(change_letter_1, change_number_1, change_letter_2, change_number_2){
  # Create empty object
  base::assign(base::paste("change_change_covar", change_letter_1, change_letter_2, sep = "_"), "")
  
  lavaan_str <- "# Specify change factor covariance with change factor within construct \n "
  
  lavaan_str <- paste(lavaan_str, change_letter_1, change_number_1, " ~~ ", "sigma_", change_letter_1, change_number_1, change_letter_2, change_number_2, " * ", change_letter_2, change_number_2, "\n", sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("change_change_covar", change_letter_1, change_letter_2, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("change_change_covar", change_letter_1, change_letter_2, sep = "_")))
}

# Specify covariance of constant change factors
specify_bi_change_covar  <- function(change_letter_x, change_letter_y){
  # Create empty object
  base::assign(base::paste("change_covar", change_letter_x, change_letter_y, sep = "_"), "")
  
  lavaan_str <- "# Specify covariance of constant change factors between constructs \n "
  
  lavaan_str <- paste(lavaan_str, change_letter_x, "2", " ~~ ", "sigma_", change_letter_y, "2", change_letter_x, "2"," * ", change_letter_y, "2", " \n " , sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("change_covar", change_letter_x, change_letter_y, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("change_covar", change_letter_x, change_letter_y, sep = "_")))
}

# Specify proportional change component
specify_proportional_effect <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("proportional_effect", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify proportional change component \n "
  
  for (i in 1:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i + 1, " ~ ", "beta_", variable, " * ","l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("proportional_effect", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("proportional_effect", variable, sep = "_")))
}


# Specify covariance of intercepts
specify_int_covar  <- function(variable_x, variable_y){
  # Create empty object
  base::assign(base::paste("int_covar", variable_x, variable_y, sep = "_"), "")
  
  lavaan_str <- "# Specify covariance of intercepts \n "
  
  lavaan_str <- paste(lavaan_str, "l", variable_x, "1", " ~~ ", "sigma_", "l", variable_y, "1", "l", variable_x, "1"," * ", "l", variable_y, "1", " \n " , sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("int_covar", variable_x, variable_y, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("int_covar", variable_x, variable_y, sep = "_")))
}

# Specify covariance of constant change and intercept within the same construct
specify_int_change_covar  <- function(variable, change_letter){
  # Create empty object
  base::assign(base::paste("int_change_covar", variable, change_letter, sep = "_"), "")
  
  lavaan_str <- "# Specify covariance of constant change and intercept within the same construct \n "
  
  lavaan_str <- paste(lavaan_str, "l", variable, "1", " ~~ ", "sigma_", change_letter, "2", "l", variable, "1"," * ", change_letter, "2", " \n " , sep = "")
  
  ## Assign str from loop to object created at the beginning
  base::assign(base::paste("int_change_covar", variable, change_letter, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("int_change_covar", variable, change_letter, sep = "_")))
}


# Specify residual covariances
specify_resid_covar <- function(timepoints, variable_x, variable_y){
  # Create empty object
  base::assign(base::paste("resid_covar", variable_x, variable_y, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify residual covariances \n "
  
  for (i in 1:timepoints) {
    lavaan_str <- base::paste(lavaan_str, variable_x, i, " ~~ ", "sigma_su", " * ", variable_y, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("resid_covar", variable_x, variable_y, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("resid_covar", variable_x, variable_y, sep = "_")))
}

# Specify autoregression of change score
specify_lcs_autoreg <- function(timepoints, variable){
  # Create empty object
  base::assign(base::paste("lcs_autoreg", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify autoregression of change score \n "
  
  for (i in 1:(timepoints - 2)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i + 2, " ~ ", "phi_", variable, " * ", "d", variable, i + 1, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("lcs_autoreg", variable, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lcs_autoreg", variable, sep = "_")))
}


# Specify between-construct coupling parameters true score (t) to change score (c)
specify_lcs_tc <- function(timepoints, variable_x, variable_y){
  # Create empty object
  base::assign(base::paste("lcs_tc", variable_x, variable_y, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify between-construct coupling parameters true score to change score \n "
  
  for (i in 1:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable_x, i + 1, " ~ ", "delta_", variable_x, variable_y, " * ", "l", variable_y, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("lcs_tc", variable_x, variable_y, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lcs_tc", variable_x, variable_y, sep = "_")))
}


# Specify between-construct coupling parameters change score (c) to change score (c)
specify_lcs_cc <- function(timepoints, variable_x, variable_y){
  # Create empty object
  base::assign(base::paste("lcs_cc", variable_x, variable_y, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify between-construct coupling parameters change score to change score \n "
  
  for (i in 2:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable_x, i + 1, " ~ ", "xi_", variable_x, variable_y, " * ", "d", variable_y, i, " \n ", sep = "")
  }
  
  # Assign str from loop to object created at the beginning
  base::assign(base::paste("lcs_cc", variable_x, variable_y, sep = "_"), lavaan_str)
  
  # Return string object
  base::eval(rlang::sym(base::paste("lcs_cc", variable_x, variable_y, sep = "_")))
}
