#' Specify lavaan model for bivariate latent change score models
#'
#' @param timepoints Number if timepoints.
#' @param model_list_x List of model specifications for variables specified in \code{var_x}.
#' \itemize{
#' \item{\code{gamma}}{ (Constant change)},
#' \item{\code{pi}}{ (Proportional change)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param model_list_y List of model specifications for variables specified in \code{var_y}.
#' \itemize{
#' \item{\code{gamma}}{ (Constant change)},
#' \item{\code{pi}}{ (Proportional change)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param coupling_list List of model specifications for coupling parameters.
#' \itemize{
#' \item{\code{delta_xy}}{ (True score y predicting subsequent change score x)},
#' \item{\code{delta_yx}}{ (True score x predicting subsequent change score y)},
#' \item{\code{xi_xy}}{ (Change score y predicting subsequent change score x)},
#' \item{\code{xi_yx}}{ (Change score x predicting subsequent change score y)}.
#' }
#'
#' @return
#' @export
#'
#' @examples
#' 
#' 

specify_lavaan_bi_model <- function(timepoints,
                                    var_x,
                                    model_list_x,
                                    var_y,
                                    model_list_y,
                                    coupling_list,
                                    change_letter_x = "g",
                                    change_letter_y = "j"
                                    ) {
  
  
  model_x_uni_lavaan <- ""
  model_x_uni_lavaan <- lcsm::specify_lavaan_uni_model(timepoints = timepoints, model_list = model_list_x, variable = var_x, change_letter = change_letter_x)
  
  model_y_uni_lavaan <- ""
  model_y_uni_lavaan <- lcsm::specify_lavaan_uni_model(timepoints = timepoints, model_list = model_list_y, variable = var_y, change_letter = change_letter_y)

  # Specify residual covariance to be equal across time  ----
  resid_covar <- ""  
  resid_covar <- lcsm:::specify_resid_covar(timepoints = timepoints, variable_x = var_x, variable_y = var_y)
  
  # Specify covariances for bivariate latent change score model ----
  lavaan_bi_growth <- ""
  
  # Specify covariances between intercepts
  lavaan_bi_growth <- lcsm:::specify_int_covar(var_x, var_y)
 
  # Specify covariances between constant growth factors
  if (model_list_x$gamma == TRUE){
    lavaan_bi_growth <- paste(lavaan_bi_growth, lcsm:::specify_int_growth_covar(change_letter = change_letter_x, variable = var_y))
  }
  
  # Specify covariances between constant growth factors
  if (model_list_y$gamma == TRUE){
    lavaan_bi_growth <- paste(lavaan_bi_growth, lcsm:::specify_int_growth_covar(change_letter = change_letter_y, variable = var_x))
  }
  
  # Specify covariances between constant growth factors
  if (model_list_x$gamma == TRUE & model_list_y$gamma == TRUE){
    lavaan_bi_growth <- paste(lavaan_bi_growth, lcsm:::specify_growth_covar(change_letter_x = change_letter_x, change_letter_y = change_letter_y))
  }
  
  # Define empty str object 
  lavaan_bi_coupling <- ""
  
  # Specify true score y predicting change score x ----
  if (coupling_list$delta_xy == TRUE){
    lavaan_bi_coupling <- paste(lavaan_bi_coupling, lcsm:::specify_lcs_tc(timepoints = timepoints, variable_x = var_x, variable_y = var_y))
  }
  
  # Specify true score x predicting change score y ----
  if (coupling_list$delta_yx == TRUE){
    lavaan_bi_coupling <- paste(lavaan_bi_coupling, lcsm:::specify_lcs_tc(timepoints = timepoints, variable_x = var_y, variable_y = var_x))
    
  }

  
  # Specify change score y predicting change score x ----
  if (coupling_list$xi_xy == TRUE){
    lavaan_bi_coupling <- paste(lavaan_bi_coupling, lcsm:::specify_lcs_cc(timepoints = timepoints, variable_x = var_x, variable_y = var_y))
  }
  
  # Specify change score x predicting change score y ----
  if (coupling_list$xi_yx == TRUE){
    lavaan_bi_coupling <- paste(lavaan_bi_coupling, lcsm:::specify_lcs_cc(timepoints = timepoints, variable_x = var_y, variable_y = var_x))
  }
  
  # Combine univariate and bivariate models
  lavaan_bi_model <- paste(model_x_uni_lavaan, model_y_uni_lavaan, resid_covar, lavaan_bi_growth, lavaan_bi_coupling, sep = "")
  
  lavaan_bi_model
}

