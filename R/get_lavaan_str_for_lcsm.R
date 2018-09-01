
# Specify latent true scores (lts)
specify_lts <- function(timepoints, variable){
  # Create empty str object lts_variable (latent true score)
  base::assign(base::paste("lts", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  for (i in 1:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " =~ 1 * ", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("lts", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lts", variable, sep = "_")))
}

# Specify means of latent true scores (lts_mean)
specify_lts_mean <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("lts_mean", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  # Write first line out of loop to label gamma_variable1
  lavaan_str <- base::paste(lavaan_str, "l", variable, "1", " ~ ", "gamma_", "l", variable, "1", " * 1", " \n ", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " ~ 0 * 1", " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("lts_mean", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lts_mean", variable, sep = "_")))
}

# Specify variance of latent true scores (lts_var)
specify_lts_var <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("lts_var", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  # Write first line out of loop to label sigma2_lvariable1
  lavaan_str <- base::paste(lavaan_str, "l", variable, "1", " ~~ ", "sigma2_", "l", variable, "1", " * ", "l", variable, "1", " \n ", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " ~~ 0 * ", "l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to lts_var
  base::assign(base::paste("lts_var", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lts_var", variable, sep = "_")))
}

# Specify intercept of obseved scores (os_int)
specify_os_int <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("os_int", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  for (i in 1:timepoints) {
    lavaan_str <- base::paste(lavaan_str, variable, i, " ~ 0 * 1", " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("os_int", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("os_int", variable, sep = "_")))
}


# Specify variance of latent true scores (lts_var)
specify_os_resid <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("os_resid", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  # Write first line out of loop to label sigma2_lvariable1
  lavaan_str <- base::paste(lavaan_str, variable, "1", " ~~ ", "sigma2_u", " * ", variable, "1", " \n ", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, variable, i, " ~~ ", "sigma2_u", " * ", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to lts_var
  base::assign(base::paste("os_resid", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("os_resid", variable, sep = "_")))
}


# Specify autoregressions of latent variables
specify_lts_autoreg <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("lts_autoreg", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  for (i in 1:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i + 1, " ~ 1 * ","l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("lts_autoreg", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lts_autoreg", variable, sep = "_")))
}


# Specify latent change scores
specify_lcs <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("lcs", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " =~ 1 * ","l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("lcs", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lcs", variable, sep = "_")))
}


# Specify latent change scores means
specify_lcs_mean <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("lcs_mean", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " ~ 1 * ", "0", " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("lcs_mean", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lcs_mean", variable, sep = "_")))
}



# Specify latent change scores variances
specify_lcs_var <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("lcs_var", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  for (i in 2:(timepoints)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i, " ~~ ", "0 * ", "d", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to lcs_var
  base::assign(base::paste("lcs_var", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lcs_var", variable, sep = "_")))
}

# Specify constant change factor
specify_constant_change <- function(timepoints, variable, change_letter){
  # Create empty str object lts_variable
  base::assign(base::paste("constant_change", variable, sep = "_"), "")
  
  lavaan_str_0 <- paste(change_letter, "2 =~", sep = "")
  
  # Create empty str object for lavaan syntax
  lavaan_str_1 <- ""
  
  for (i in 2:(timepoints)) {
    lavaan_str_1 <- base::paste(lavaan_str_1, i - 1, " * ", "d", variable, i, " + ", sep = "")
  }
  
  # Combine first string object with loop
  lavaan_str_3 <- paste(lavaan_str_0, lavaan_str_1)
  
  # Delete + at the end of loop as not needed
  lavaan_str_4 <- base::substr(lavaan_str_3, 1, nchar(lavaan_str_3) - 3)

  # Add new line at the end
  lavaan_str_5 <- paste(lavaan_str_4, " \n ", sep = "")
  
  # Assign str from loop to lcs_var
  base::assign(base::paste("constant_change", variable, sep = "_"), lavaan_str_5)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("constant_change", variable, sep = "_")))
}


# Specify constant change factor mean
specify_constant_change_mean <- function(timepoints, variable, change_letter){
  # Create empty str object lts_variable
  base::assign(base::paste("constant_change_mean", variable, sep = "_"), "")
  
  lavaan_str <- paste(change_letter, "2 ~ ", "gamma_", change_letter, "2", " * 1", sep = "")
  
  # Assign str from loop to lcs_var
  base::assign(base::paste("constant_change_mean", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("constant_change_mean", variable, sep = "_")))
}

# Specify constant change factor variance
specify_constant_change_var <- function(timepoints, variable, change_letter){
  # Create empty str object lts_variable
  base::assign(base::paste("constant_change_var", variable, sep = "_"), "")
  
  lavaan_str <- paste(change_letter, "2 ~~ ", "sigma2_", change_letter, "2", " * 1", sep = "")
  
  # Assign str from loop to lcs_var
  base::assign(base::paste("constant_change_var", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("constant_change_var", variable, sep = "_")))
}


# Specify constant change factor covariance with the initial true score
specify_constant_change_covar_initial_ts <- function(timepoints, variable, change_letter){
  # Create empty str object lts_variable
  base::assign(base::paste("constant_change_covar_initial_ts", variable, sep = "_"), "")
  
  lavaan_str <- paste(change_letter, "2 ~~ ", "sigma_", change_letter, "2", "l", variable, "1", " * ", "l", variable, "1", sep = "")
  
  # Assign str from loop to lcs_var
  base::assign(base::paste("constant_change_covar_initial_ts", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("constant_change_covar_initial_ts", variable, sep = "_")))
}


# Specify autoregressions of latent variables
specify_proportional_effect <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("proportional_effect", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  for (i in 1:(timepoints - 1)) {
    lavaan_str <- base::paste(lavaan_str, "d", variable, i + 1, " ~ ", "pi_", variable, " * ","l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("proportional_effect", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("proportional_effect", variable, sep = "_")))
}
