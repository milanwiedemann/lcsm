specify_lts <- function(timepoints, variable){
  # Create empty str object lts_variable
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


specify_lts_mean <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("lts", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  # Write first line out of loop to label gamma_variable1
  lavaan_str <- base::paste(lavaan_str, "l", variable, "1", " ~ ", "gamma_", "l", variable, "1", " * 1", " \n ", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " ~ 0 * 1", " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("lts", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lts", variable, sep = "_")))
}

specify_lts_var <- function(timepoints, variable){
  # Create empty str object lts_variable
  base::assign(base::paste("lts", variable, sep = "_"), "")
  
  # Create empty str object for lavaan syntax
  lavaan_str <- ""
  
  # Write first line out of loop to label sigma2_lvariable1
  lavaan_str <- base::paste(lavaan_str, "l", variable, "1", " ~~ ", "sigma2_", "l", variable, "1", " * ", "l", variable, "1", " \n ", sep = "")
  
  for (i in 2:timepoints) {
    lavaan_str <- base::paste(lavaan_str, "l", variable, i, " ~~ 0 * ", "l", variable, i, " \n ", sep = "")
  }
  
  # Assign str from loop to lts_
  base::assign(base::paste("lts", variable, sep = "_"), lavaan_str)
  
  # Return latent true score specifications
  base::eval(rlang::sym(base::paste("lts", variable, sep = "_")))
}



specify_lts(4, "y")
specify_lts_mean(4, "y")
specify_lts_var(4, "y")


