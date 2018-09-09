#' Specify lavaan model for univariate latent change score models
#'
#' @param timepoints Number if timepoints.
#' @param model_list List of parameters to be estimated in the univariate lcsm.
#' \itemize{
#' \item{\code{gamma}}{ (Constant change)},
#' \item{\code{pi}}{ (Proportional change)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param variable String with letter of variable (Usually x or y).
#' @param change_letter String with letter (Usually g or j).
#'
#' @return
#' @export
#'
#' @examples
specify_lavaan_uni_model <- function(timepoints, model_list, variable, change_letter) {
  
# Define empty str object 
lavaan_model <- ''
  
# Specify no change by default ----

# Specify latent true scores
lavaan_model <- lcsm:::specify_lts(timepoints, variable)

# Specify means of latent true scores
lavaan_model <- paste(lavaan_model, lcsm:::specify_lts_mean(timepoints, variable))

# Specify variances of latent true scores
lavaan_model <- paste(lavaan_model, lcsm:::specify_lts_var(timepoints, variable))

# Specify observed intercepts
lavaan_model <- paste(lavaan_model, lcsm:::specify_os_int(timepoints, variable))

# Specify observed residual variances
lavaan_model <- paste(lavaan_model, lcsm:::specify_os_resid(timepoints, variable)) 

# Specify latent true score autoregressions
lavaan_model <- paste(lavaan_model, lcsm:::specify_lts_autoreg(timepoints, variable))

# Specify latent change scores
lavaan_model <- paste(lavaan_model, lcsm:::specify_lcs(timepoints, variable))

# Specify latent change score means
lavaan_model <- paste(lavaan_model, lcsm:::specify_lcs_mean(timepoints, variable))

# Specify latent change score variances
lavaan_model <- paste(lavaan_model, lcsm:::specify_lcs_var(timepoints, variable))

# Specify constant change ----
if (model_list$gamma == TRUE){
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change(timepoints, variable, change_letter))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_mean(timepoints, variable, change_letter))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_var(timepoints, variable, change_letter))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_covar_initial_ts(timepoints, variable, change_letter))
}

# Specify proportional change ----
if (model_list$pi == TRUE){
  
lavaan_model <- paste(lavaan_model, lcsm:::specify_proportional_effect(timepoints, variable))
}

# Specify autoregressive change scores ----
if (model_list$phi == TRUE){
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_lcs_autoreg(timepoints, variable))
}

lavaan_model

}

