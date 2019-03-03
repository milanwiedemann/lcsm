#' Specify lavaan model for bivariate latent change score models
#'
#' @param timepoints Number of timepoints.
#' @param var_x Vector, specifying variables measuring one construct of the model.
#' @param var_y Vector, specifying variables measuring another construct of the model.
#' @param model_x List, specifying model specifications (logical) for variables specified in \code{var_x}.
#' \itemize{
#' \item{\code{alpha_constant}}{ (Constant change factor)},
#' \item{\code{alpha_piecewise}}{ (Piecewise constant change factors)},
#' \item{\code{alpha_piecewise_num}}{ (Changepoint of piecewise constant change factors)},
#' \item{\code{alpha_linear}}{ (Linear change factor)},
#' \item{\code{beta}}{ (Proportional change factor)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param model_y List, specifying model specifications (logical) for variables specified in \code{var_y}.
#' \itemize{
#' \item{\code{alpha_constant}}{ (Constant change factor)},
#' \item{\code{alpha_piecewise}}{ (Piecewise constant change factors)},
#' \item{\code{alpha_piecewise_num}}{ (Changepoint of piecewise constant change factors)},
#' \item{\code{alpha_linear}}{ (Linear change factor)},
#' \item{\code{beta}}{ (Proportional change factor)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param coupling List, specifying coupling parameters.
#' \itemize{
#' \item{\code{delta_xy}}{ (True score y predicting subsequent change score x)},
#' \item{\code{delta_yx}}{ (True score x predicting subsequent change score y)},
#' \item{\code{xi_xy}}{ (Change score y predicting subsequent change score x)},
#' \item{\code{xi_yx}}{ (Change score x predicting subsequent change score y)}.
#' }
#' @param change_letter_x String, specifying letter to be used as change factor for construct x in lavaan syntax.
#' @param change_letter_y String, specifying letter to be used as change factor for construct y in lavaan syntax.
#'
#' @return Lavaan model syntax including comments.
#' @export 
#' 

specify_lavaan_bi_model <- function(timepoints,
                                    var_x,
                                    model_x,
                                    var_y,
                                    model_y,
                                    coupling,
                                    change_letter_x = "g",
                                    change_letter_y = "j"
                                    ) {
  
  # Code parameters in model_x that are not defined as FALSE
  if (is.null(model_x$delta_xy) == TRUE) {
    model_x$delta_xy <- FALSE
  }
  
  if (is.null(model_x$delta_yx) == TRUE) {
    model_x$delta_yx <- FALSE
  }
  
  if (is.null(model_x$xi_xy) == TRUE) {
    model_x$xi_xy <- FALSE
  }
  
  if (is.null(model_x$xi_yx) == TRUE) {
    model_x$xi_yx <- FALSE
  }
  
  # Code parameters in model_y that are not defined as FALSE
  if (is.null(model_y$delta_xy) == TRUE) {
    model_y$delta_xy <- FALSE
  }
  
  if (is.null(model_y$delta_yx) == TRUE) {
    model_y$delta_yx <- FALSE
  }
  
  if (is.null(model_y$xi_xy) == TRUE) {
    model_y$xi_xy <- FALSE
  }
  
  if (is.null(model_y$xi_yx) == TRUE) {
    model_y$xi_yx <- FALSE
  }
  
  model_x_uni_lavaan <- ""
  model_x_uni_lavaan <- specify_lavaan_uni_model(timepoints = timepoints, model = model_x, variable = var_x, change_letter = change_letter_x)
  
  model_y_uni_lavaan <- ""
  model_y_uni_lavaan <- specify_lavaan_uni_model(timepoints = timepoints, model = model_y, variable = var_y, change_letter = change_letter_y)

  # Specify residual covariance to be equal across time  ----
  resid_covar <- ""  
  resid_covar <- specify_resid_covar(timepoints = timepoints, variable_x = var_x, variable_y = var_y)
  
  # Specify covariances for bivariate latent change score model ----
  lavaan_bi_change <- ""
  
  # Specify covariances between intercepts
  lavaan_bi_change <- specify_int_covar(var_x, var_y)
 
  # Specify covariances between constant change factors
  if (model_x$alpha_constant == TRUE){
    lavaan_bi_change <- paste(lavaan_bi_change, specify_int_change_covar(change_letter = change_letter_x, variable = var_y))
  }
  
  # Specify covariances between constant change factors
  if (model_y$alpha_constant == TRUE){
    lavaan_bi_change <- paste(lavaan_bi_change, specify_int_change_covar(change_letter = change_letter_y, variable = var_x))
  }
  
  # Specify covariances between constant change factors
  if (model_x$alpha_constant == TRUE & model_y$alpha_constant == TRUE){
    lavaan_bi_change <- paste(lavaan_bi_change, specify_bi_change_covar(change_letter_x = change_letter_x, change_letter_y = change_letter_y))
  }
  
  # Define empty str object 
  lavaan_bi_coupling <- ""
  
  # Specify true score y predicting change score x ----
  if (coupling$delta_xy == TRUE){
    lavaan_bi_coupling <- paste(lavaan_bi_coupling, specify_lcs_ct(timepoints = timepoints, variable_x = var_x, variable_y = var_y))
  }
  
  # Specify true score x predicting change score y ----
  if (coupling$delta_yx == TRUE){
    lavaan_bi_coupling <- paste(lavaan_bi_coupling, specify_lcs_ct(timepoints = timepoints, variable_x = var_y, variable_y = var_x))
  }

  # Specify change score y predicting change score x ----
  if (coupling$xi_xy == TRUE){
    lavaan_bi_coupling <- paste(lavaan_bi_coupling, specify_lcs_cc(timepoints = timepoints, variable_x = var_x, variable_y = var_y))
  }
  
  # Specify change score x predicting change score y ----
  if (coupling$xi_yx == TRUE){
    lavaan_bi_coupling <- paste(lavaan_bi_coupling, specify_lcs_cc(timepoints = timepoints, variable_x = var_y, variable_y = var_x))
  }
  
  # Combine univariate and bivariate models
  lavaan_bi_model <- paste(model_x_uni_lavaan, model_y_uni_lavaan, resid_covar, lavaan_bi_change, lavaan_bi_coupling, sep = "")
  
  lavaan_bi_model
}

