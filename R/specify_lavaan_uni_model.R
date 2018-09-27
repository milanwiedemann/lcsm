#' Specify lavaan model for univariate latent change score models
#'
#' @param timepoints Number if timepoints.
#' @param model List of model specifications (logical) for variables specified in \code{variable}.
#' \itemize{
#' \item{\code{alpha_constant}}{ (Constant change factor)},
#' \item{\code{alpha_piecewise}}{ (Piecewise constant change factors)},
#' \item{\code{alpha_piecewise_num}}{ (Changepoint of piecewise constant change factors)},
#' \item{\code{alpha_linear}}{ (Linear change factor)},
#' \item{\code{beta}}{ (Proportional change factor)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param variable String with letter of variable (Usually x or y).
#' @param change_letter String with letter (Usually g or j).
#'
#' @return Lavaan model syntax.
#' @export 
#'
#' @examples TODO. 
#' 
specify_lavaan_uni_model <- function(timepoints, model, variable, change_letter) {
  
  
  # Code parameters in model that are not defined as FALSE
  if (is.null(model$alpha_constant) == TRUE) {
    model$alpha_constant <- FALSE
  }
  
  if (is.null(model$beta) == TRUE) {
    model$beta <- FALSE
  }
  
  if (is.null(model$alpha_piecewise) == TRUE) {
    model$alpha_piecewise <- FALSE
  }
  
  if (is.null(model$alpha_piecewise_num) == TRUE) {
    model$alpha_piecewise_num <- FALSE
  }
  
  if (is.null(model$alpha_linear) == TRUE) {
    model$alpha_linear <- FALSE
  }
  
  # Return error message when both constant change and piecewise constant change are defined
  if (model$alpha_constant == TRUE & model$alpha_piecewise == TRUE){
    stop("Choose only one constant change method.")
  }
  
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
if (model$alpha_constant == TRUE){
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change(timepoints, variable, change_letter))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_mean(timepoints, variable, change_letter, 2))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_var(timepoints, variable, change_letter, 2))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_covar_initial_ts(timepoints, variable, change_letter, 2))
}

# Specify piecewise constant change ----
if (model$alpha_piecewise == TRUE){
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_piecewise(timepoints, variable, change_letter, model$alpha_piecewise_num))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_mean(timepoints, variable, change_letter, 2))
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_mean(timepoints, variable, change_letter, 3))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_var(timepoints, variable, change_letter, 2))
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_var(timepoints, variable, change_letter, 3))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_covar_initial_ts(timepoints, variable, change_letter, 2))
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_covar_initial_ts(timepoints, variable, change_letter, 3))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_uni_change_covar(change_letter, 2, change_letter, 3))
}

# Specify linear change ----
if (model$alpha_linear == TRUE){
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_linear_change(timepoints, variable, change_letter))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_mean(timepoints, variable, change_letter, 3))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_var(timepoints, variable, change_letter, 3))
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_constant_change_covar_initial_ts(timepoints, variable, change_letter, 3))
}

# Specify covar between constant change and linear change ----

if (model$alpha_constant == TRUE & model$alpha_linear == TRUE){
  lavaan_model <- paste(lavaan_model, lcsm:::specify_uni_change_covar(change_letter, 2, change_letter, 3))
}

# Specify proportional change ----
if (model$beta == TRUE){
  
lavaan_model <- paste(lavaan_model, lcsm:::specify_proportional_effect(timepoints, variable))
}

# Specify autoregressive change scores ----
if (model$phi == TRUE){
  
  lavaan_model <- paste(lavaan_model, lcsm:::specify_lcs_autoreg(timepoints, variable))
}

lavaan_model

}

