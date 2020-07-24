#' Extract fit statistics of lavaan objects
#'
#' @param ... lavaan object(s)
#' @param details Logical, if TRUE return all fit statistics.
#' By default this is set to FALSE, a selection (chisq, npar, aic, bic, cfi, rmsea, srmr) of fit statistics is returned.
#' @importFrom lavaan lavInspect
#' @return This function returns a tibble.
#' @references David Robinson and Alex Hayes (2019). broom: Convert Statistical Analysis Objects into Tidy Tibbles. R package version 0.5.2.
#' \url{https://CRAN.R-project.org/package=broom}.
#' @export
#' @examples # First create a lavaan object
#' bi_lcsm_01 <- fit_bi_lcsm(data = data_bi_lcsm, 
#'                           var_x = names(data_bi_lcsm)[2:4], 
#'                           var_y = names(data_bi_lcsm)[12:14],
#'                           model_x = list(alpha_constant = TRUE, 
#'                                          beta = TRUE, 
#'                                          phi = FALSE),
#'                           model_y = list(alpha_constant = TRUE, 
#'                                          beta = TRUE, 
#'                                          phi = TRUE),
#'                           coupling = list(delta_lag_xy = TRUE, 
#'                                           xi_lag_yx = TRUE)
#'                                           )
#'
#' # Now extract fit statistics  
#' extract_fit(bi_lcsm_01)

extract_fit <- function(..., details = FALSE) {
  
  lavaan_objects <- list(...)
  
  fit_data <- purrr::map_df(.x = lavaan_objects, .f = broom::glance, .id = "model")
  
  fit_data <- dplyr::rename_all(.tbl = fit_data, tolower)
  
  # Figure out a way to name these things
  # fit_return$model <- paste0("m", 1:length(lavaan_objects))
  
  if (details == FALSE) {
    fit_return <- dplyr::select(fit_data,
                                model, chisq, npar, aic, bic, cfi, rmsea, srmr)
  }
  
  if (details == TRUE) {
    fit_return <- dplyr::select(fit_data,
                                model, chisq, npar, dplyr::everything())
  }
  
  return(fit_return)
  
}
