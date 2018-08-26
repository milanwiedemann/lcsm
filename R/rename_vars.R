#' Rename variables for univariate and bivariate models
#'
#' @param data Dataframe in wide format
#' @param x_vars List of variables measuring first construct
#' @param y_vars List of variables measuring second construct
#'
#' @return Dataframe in wide format with renamed variables
#' @export
#'
#' @examples
rename_vars <- function(data, x_vars, y_vars){

  # Rename variables in x_vars and y_vars list
  if (base::exists("x_vars") == TRUE & base::exists("y_vars") == TRUE) {
    
    for (i in base::seq_along(y_vars)) {
      base::names(data)[base::names(data) == x_vars[i]] <- base::paste("x", i, sep = "")
      base::names(data)[base::names(data) == y_vars[i]] <- base::paste("y", i, sep = "")
    }
    # Return dataframe with renamed variables
    data
  }
  
  # Rename variables in x_vars list
  if (base::exists("x_vars") == TRUE) {
    
    for (i in base::seq_along(x_vars)) {
      base::names(data)[base::names(data) == x_vars[i]] <- base::paste("x", i, sep = "")
    }
    
    # Return dataframe with renamed variables
    data
  }
  
  # Rename variables in y_vars list
  if (base::exists("y_vars") == TRUE) {
    
    for (i in base::seq_along(y_vars)) {
      base::names(data)[base::names(data) == y_vars[i]] <- base::paste("y", i, sep = "")
    }
    
    # Return dataframe with renamed variables
    data
  }

}
