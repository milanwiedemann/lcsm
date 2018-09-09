#' Rename variables for univariate and bivariate models
#'
#' @param data Dataframe in wide format
#' @param var_x List of variables measuring first construct
#' @param var_y List of variables measuring second construct
#'
#' @return Dataframe in wide format with renamed variables
#' @export
#'
#' @examples
rename_lcsm_vars <- function(data, var_x, var_y){

  # Rename variables in var_x and var_y list
  if (base::exists("var_x") == TRUE & base::exists("var_y") == TRUE) {
    
    for (i in base::seq_along(var_y)) {
      base::names(data)[base::names(data) == var_x[i]] <- base::paste("x", i, sep = "")
      base::names(data)[base::names(data) == var_y[i]] <- base::paste("y", i, sep = "")
    }
    # Return dataframe with renamed variables
    data
  }
  
  # Rename variables in var_x list
  if (base::exists("var_x") == TRUE) {
    
    for (i in base::seq_along(var_x)) {
      base::names(data)[base::names(data) == var_x[i]] <- base::paste("x", i, sep = "")
    }
    
    # Return dataframe with renamed variables
    data
  }
  
  # Rename variables in var_y list
  if (base::exists("var_y") == TRUE) {
    
    for (i in base::seq_along(var_y)) {
      base::names(data)[base::names(data) == var_y[i]] <- base::paste("y", i, sep = "")
    }
    
    # Return dataframe with renamed variables
    data
  }

}
