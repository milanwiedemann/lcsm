#' Extract fit statistics of lavaan objects
#'
#' @param lavaan_object Vector, lavaan object(s)
#' @param details Logical, if TRUE return all fit statistics.
#' By default this is set to FALSE, a selection (chisq, npar, aic, bic, cfi, rmsea, srmr) of fit statistics is returned.

#' @return This function returns a tibble.
#' @export
#' @examples

extract_fit <- function(lavaan_object, details = FALSE) {
  
  lavaan_object_list <- list()
  lavaan_object_list <- c(lavaan_object)
  
  fit <- list()
  name_fit <- list()
  
  for (i in 1:length(lavaan_object_list)) {
    
    fit[[i]] <- broom::glance(lavaan_object_list[[i]])
    name_fit[[i]] <- i
    
    fit[[i]] <- dplyr::mutate(fit[[i]], model_name = paste("model", name_fit[[i]], sep = "_"))
  }
  
  fit_data <- dplyr::bind_rows(fit, .id = "id")
  
  if (details == FALSE) {
    fit_return <- dplyr::select(fit_data,
           model_name, chisq, npar, aic, bic, cfi, rmsea, srmr)
  }

  if (details == TRUE) {
    fit_return <- dplyr::select(fit_data,
           id, model_name, chisq, npar, dplyr::everything())
  }

  return(fit_return)
  
}
