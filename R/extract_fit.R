#' Extract fit statistics of lavaan objects
#'
#' @param lavaan_object Vector, lavaan object(s)
#' @param details Logical, if TRUE return all fit statistics.
#' By default this is set to FALSE, a selection (chisq, npar, aic, bic, cfi, rmsea, srmr) of fit statistics is returned.

#' @return This function returns a tibble.
#' @references David Robinson and Alex Hayes (2019). broom: Convert Statistical Analysis Objects into Tidy Tibbles. R package version 0.5.2.
#' \url{https://CRAN.R-project.org/package=broom}
#' @export
#' @examples # First create a lavaan object
#' bi_lcsm_01 <- fit_bi_lcsm(data = data_bi_lcsm, 
#'                           var_x = names(data_bi_lcsm)[2:11], 
#'                           var_y = names(data_bi_lcsm)[12:21],
#'                           model_x = list(alpha_constant = TRUE, beta = TRUE, phi = FALSE),
#'                           model_y = list(alpha_constant = TRUE, beta = TRUE, phi = TRUE),
#'                           coupling = list(delta_lag_xy = TRUE, xi_lag_yx = TRUE))
#'
#' # Now extract fit statistics                          
#' extract_fit(bi_lcsm_01)

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
