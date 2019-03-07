
# Specify latent true scores (lts)
specify_lts <- function(timepoints, variable){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify latent true scores \n"
  for (i in 1:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " =~ 1 * ", variable, i, " \n", sep = "")
  }

  return(lavaan_str)
}

# Specify mean of latent true scores (lts_mean)
specify_lts_mean <- function(timepoints, variable){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify mean of latent true scores \n"
  
  # Write first line out of loop to label gamma_variable1
  lavaan_str <- base::paste(lavaan_str, "l", variable, "1", " ~ ", "gamma_", "l", variable, "1", " * 1", " \n", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " ~ 0 * 1", " \n", sep = "")
  }
  
  return(lavaan_str)
}

# Specify variance of latent true scores (lts_var)
specify_lts_var <- function(timepoints, variable){
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify variance of latent true scores \n"
  
  # Write first line out of loop to label sigma2_lvariable1
  lavaan_str <- base::paste(lavaan_str, "l", variable, "1", " ~~ ", "sigma2_", "l", variable, "1", " * ", "l", variable, "1", " \n", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " ~~ 0 * ", "l", variable, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}

# Specify intercept of obseved scores (os_int)
specify_os_int <- function(timepoints, variable){
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify intercept of obseved scores \n"
  
  for (i in 1:timepoints) {
    lavaan_str <- base::paste(lavaan_str, variable, i, " ~ 0 * 1", " \n", sep = "")
  }
  
  return(lavaan_str)
}


# Specify variance of observed scores (os_resid)
specify_os_resid <- function(timepoints, variable){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify variance of observed scores \n"
  
  # Write first line out of loop to label sigma2_lvariable1
  lavaan_str <- base::paste(lavaan_str, variable, "1", " ~~ ", "sigma2_u", variable, " * ", variable, "1", " \n", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, variable, i, " ~~ ", "sigma2_u", variable, " * ", variable, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}


# Specify autoregressions of latent variables
specify_lts_autoreg <- function(timepoints, variable){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify autoregressions of latent variables \n"
  
  for (i in 1:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i + 1, " ~ 1 * ","l", variable, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}


# Specify latent change scores
specify_lcs <- function(timepoints, variable){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify latent change scores \n"
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " =~ 1 * ","l", variable, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}


# Specify latent change scores means
specify_lcs_mean <- function(timepoints, variable){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify latent change scores means \n"
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " ~ 0 * ", "1", " \n", sep = "")
  }
  
  return(lavaan_str)
}



# Specify latent change scores variances
specify_lcs_var <- function(timepoints, variable){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify latent change scores variances \n"
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " ~~ ", "0 * ", "d", variable, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}

# Specify constant change factor
specify_constant_change <- function(timepoints, variable, change_letter){

  lavaan_str <- "# Specify constant change factor \n"
  
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
  lavaan_str_5 <- paste(lavaan_str_4, " \n", sep = "")
  
  return(lavaan_str_5)
}

# Specify linear change factor
specify_linear_change <- function(timepoints, variable, change_letter){
  
  lavaan_str <- "# Specify linear change factor \n"
  
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
  lavaan_str_5 <- paste(lavaan_str_4, " \n", sep = "")
  
  return(lavaan_str_5)
  
}


# Specify piecewise constant change factor
specify_constant_change_piecewise <- function(timepoints, variable, change_letter, changepoint){
  
  lavaan_str_1_0 <- "# Specify first piecewise constant change factor \n"
  
  lavaan_str_2_0 <- "# Specify second piecewise constant change factor \n"
  
  
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
  lavaan_str_1_5 <- paste(lavaan_str_1_4, " \n", sep = "")
  
  lavaan_str_2_5 <- paste(lavaan_str_2_4, " \n", sep = "")
                        
  # Combine both
  lavaan_str_3 <- paste(lavaan_str_1_5, lavaan_str_2_5, sep = "")
  
  return(lavaan_str_3)
}

# Specify constant change factor mean
specify_constant_change_mean <- function(timepoints, variable, change_letter, change_number){
  
  lavaan_str <- "# Specify constant change factor mean \n"
  
  lavaan_str <- paste(lavaan_str, change_letter, change_number, " ~ ", "alpha_", change_letter, change_number, " * 1", " \n", sep = "")
  
  return(lavaan_str)
}

# Specify constant change factor variance
specify_constant_change_var <- function(timepoints, variable, change_letter, change_number){
  
  lavaan_str <- "# Specify constant change factor variance \n"
  
  lavaan_str <- paste(lavaan_str, change_letter, change_number, " ~~ ", "sigma2_", change_letter, change_number, " * ", change_letter, change_number, " \n", sep = "")
  
  return(lavaan_str)
}


# Specify constant change factor covariance with the initial true score
specify_constant_change_covar_initial_ts <- function(timepoints, variable, change_letter, change_number){
  
  lavaan_str <- "# Specify constant change factor covariance with the initial true score \n"
  
  lavaan_str <- paste(lavaan_str, change_letter, change_number, " ~~ ", "sigma_", change_letter, change_number, "l", variable, "1", " * ", "l", variable, "1", "\n", sep = "")
  
  return(lavaan_str)
}

# Specify covariance of two change scores
specify_uni_change_covar <- function(change_letter_1, change_number_1, change_letter_2, change_number_2){
  
  lavaan_str <- "# Specify change factor covariance with change factor within construct \n"
  
  lavaan_str <- paste(lavaan_str, change_letter_1, change_number_1, " ~~ ", "sigma_", change_letter_1, change_number_1, change_letter_2, change_number_2, " * ", change_letter_2, change_number_2, "\n", sep = "")
  
  return(lavaan_str)
}

# Specify covariance of constant change factors
specify_bi_change_covar  <- function(change_letter_x, change_letter_y){
  
  lavaan_str <- "# Specify covariance of constant change factors between constructs \n"
  
  lavaan_str <- paste(lavaan_str, change_letter_x, "2", " ~~ ", "sigma_", change_letter_y, "2", change_letter_x, "2"," * ", change_letter_y, "2", " \n" , sep = "")
  
  return(lavaan_str)
}

# Specify proportional change component
specify_proportional_effect <- function(timepoints, variable){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify proportional change component \n"
  
  for (i in 1:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i + 1, " ~ ", "beta_", variable, " * ","l", variable, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}


# Specify covariance of intercepts
specify_int_covar  <- function(variable_x, variable_y){
  
  lavaan_str <- "# Specify covariance of intercepts \n"
  
  lavaan_str <- paste(lavaan_str, "l", variable_x, "1", " ~~ ", "sigma_", "l", variable_y, "1", "l", variable_x, "1"," * ", "l", variable_y, "1", " \n" , sep = "")
  
  return(lavaan_str)
}

# Specify covariance of constant change and intercept within the same construct
specify_int_change_covar  <- function(variable, change_letter){
  
  lavaan_str <- "# Specify covariance of constant change and intercept within the same construct \n"
  
  lavaan_str <- paste(lavaan_str, "l", variable, "1", " ~~ ", "sigma_", change_letter, "2", "l", variable, "1"," * ", change_letter, "2", " \n" , sep = "")
  
  return(lavaan_str)
}


# Specify residual covariances
specify_resid_covar <- function(timepoints, variable_x, variable_y){

  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify residual covariances \n"
  
  for (i in 1:timepoints) {
    lavaan_str <- base::paste(lavaan_str, variable_x, i, " ~~ ", "sigma_su", " * ", variable_y, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}

# Specify autoregression of change score
specify_lcs_autoreg <- function(timepoints, variable){
  
  # Create empty str object for lavaan syntax
  lavaan_str <- "# Specify autoregression of change score \n"
  
  for (i in 1:(timepoints - 2)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i + 2, " ~ ", "phi_", variable, " * ", "d", variable, i + 1, " \n", sep = "")
  }
  
  return(lavaan_str)
}


# Specify between-construct coupling parameters true score (t) to change score (c)
specify_lcs_ct <- function(timepoints, variable_x, variable_y){

  # Create empty str object for lavaan syntax
  lavaan_str <- paste0("# Specify between-construct coupling parameter:\n# Change score ", variable_x, " (t) is determined by true score ", variable_y, " (t-1)  \n")
  
  for (i in 1:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable_x, i + 1, " ~ ", "delta_", variable_x, variable_y, " * ", "l", variable_y, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}


# Specify between-construct coupling parameters change score (c) to change score (c)
specify_lcs_cc <- function(timepoints, variable_x, variable_y){
  
  # Create empty str object for lavaan syntax
  lavaan_str <- paste0("# Specify between-construct coupling parameter:\n# Change score ", variable_x, " (t) is determined by change score ", variable_y, " (t-1)  \n")
  
  for (i in 2:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable_x, i + 1, " ~ ", "xi_", variable_x, variable_y, " * ", "d", variable_y, i, " \n", sep = "")
  }
  
  return(lavaan_str)
}

# Specify piecewise between-construct coupling parameters true score (t) to change score (c)
specify_lcs_ct_piecewise <- function(timepoints, variable_x, variable_y, changepoint){
  
  # Create title str object for each piece 
  lavaan_str_1_0 <- "# Specify first piecewise between-construct coupling parameters true score (t) to change score (c) \n"
  lavaan_str_2_0 <- "# Specify second piecewise between-construct coupling parameters true score (t) to change score (c) \n"
  
  for (i in 1:(changepoint -1)) {
    lavaan_str_1_0 <- base::paste(lavaan_str_1_0, "d", variable_x, i + 1, " ~ ", "delta1_", variable_x, variable_y, " * ", "l", variable_y, i, " \n", sep = "")
  }
  
  for (j in (changepoint):(timepoints - 1)) {
    lavaan_str_2_0 <- base::paste(lavaan_str_2_0, "d", variable_x, j + 1, " ~ ", "delta2_", variable_x, variable_y, " * ", "l", variable_y, j, " \n", sep = "")
  }
  
  # Combine first and second piece
  lavaan_str <- paste0(lavaan_str_1_0, lavaan_str_2_0)
  
  return(lavaan_str)
}


# Specify piecewise between-construct coupling parameters change score (c) to change score (c)
specify_lcs_cc_piecewise <- function(timepoints, variable_x, variable_y, changepoint){
  
  # Create title str object for each piece 
  lavaan_str_1_0 <- "# Specify first piecewise between-construct coupling parameters change score (c) to change score (c) \n"
  lavaan_str_2_0 <- "# Specify second piecewise between-construct coupling parameters change score (c) to change score (c) \n"
  
  for (i in 1:(changepoint -1)) {
    lavaan_str_1_0 <- base::paste(lavaan_str_1_0, "d", variable_x, i + 1, " ~ ", "xi1_", variable_x, variable_y, " * ", "d", variable_y, i, " \n", sep = "")
  }
  
  for (j in (changepoint):(timepoints - 1)) {
    lavaan_str_2_0 <- base::paste(lavaan_str_2_0, "d", variable_x, j + 1, " ~ ", "xi2_", variable_x, variable_y, " * ", "d", variable_y, j, " \n", sep = "")
  }
  
  # Combine first and second piece
  lavaan_str <- paste0(lavaan_str_1_0, lavaan_str_2_0)
  
  return(lavaan_str)
}