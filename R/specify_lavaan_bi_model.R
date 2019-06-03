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
#' \item{\code{coupling_piecewise}}{ (Piecewise coupling parameters)},
#' \item{\code{coupling_piecewise_num}}{ (Changepoint of piecewise coupling parameters)},
#' \item{\code{delta_con_xy}}{ (True score y predicting concurrent change score x)},
#' \item{\code{delta_lag_xy}}{ (True score y predicting subsequent change score x)},
#' \item{\code{delta_con_yx}}{ (True score x predicting concurrent change score y)},
#' \item{\code{delta_lag_yx}}{ (True score x predicting subsequent change score y)},
#' \item{\code{xi_con_xy}}{ (Change score y predicting concurrent change score x)},
#' \item{\code{xi_lag_xy}}{ (Change score y predicting subsequent change score x)},
#' \item{\code{xi_con_yx}}{ (Change score x predicting concurrent change score y)},
#' \item{\code{xi_lag_yx}}{ (Change score x predicting subsequent change score y)}.
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
  
  # Code coupling parameters that are not defined as FALSE
  # Concurrent change (con)
  if (is.null(coupling$delta_con_xy) == TRUE) {
    coupling$delta_con_xy <- FALSE
  }
  
  if (is.null(coupling$delta_con_yx) == TRUE) {
    coupling$delta_con_yx <- FALSE
  }
  
  if (is.null(coupling$xi_con_xy) == TRUE) {
    coupling$xi_con_xy <- FALSE
  }
  
  if (is.null(coupling$xi_con_yx) == TRUE) {
    coupling$xi_con_yx <- FALSE
  }
  
  # Subsequent change (lag)
  if (is.null(coupling$delta_lag_xy) == TRUE) {
    coupling$delta_lag_xy <- FALSE
  }
  
  if (is.null(coupling$delta_lag_yx) == TRUE) {
    coupling$delta_lag_yx <- FALSE
  }
  
  if (is.null(coupling$xi_lag_xy) == TRUE) {
    coupling$xi_lag_xy <- FALSE
  }
  
  if (is.null(coupling$xi_lag_yx) == TRUE) {
    coupling$xi_lag_yx <- FALSE
  }
  
  if (is.null(coupling$coupling_piecewise) == TRUE) {
    coupling$coupling_piecewise <- FALSE
  }
  
  if (is.null(coupling$coupling_piecewise_num) == TRUE) {
    coupling$coupling_piecewise_num <- FALSE
  }

  
  model_x_uni_lavaan <- "# Specify parameters for construct x ----\n"
  model_x_uni_lavaan <- paste0(model_x_uni_lavaan, specify_lavaan_uni_model(timepoints = timepoints, 
                                                                            model = model_x, 
                                                                            var = var_x, 
                                                                            change_letter = change_letter_x))
  
  model_y_uni_lavaan <- "# Specify parameters for construct y ----\n"
  model_y_uni_lavaan <- paste0(model_y_uni_lavaan, specify_lavaan_uni_model(timepoints = timepoints, 
                                                                            model = model_y, 
                                                                            var = var_y, 
                                                                            change_letter = change_letter_y))

  # Specify residual covariance to be equal across time  ----
  resid_covar <- ""  
  resid_covar <- specify_resid_covar(timepoints = timepoints, variable_x = var_x, variable_y = var_y)
  
  # Specify covariances for bivariate latent change score model ----
  lavaan_bi_change <- "# Specify covariances betweeen specified change components (alpha) and intercepts (initial latent true scores lx1 and ly1) ----\n"
  
  # Specify covariances between intercepts
  lavaan_bi_change <- paste0(lavaan_bi_change, specify_int_covar(var_x, var_y))
 
  # Specify covariances between constant change factors
  if (model_x$alpha_constant == TRUE){
    lavaan_bi_change <- paste0(lavaan_bi_change, specify_int_change_covar(change_letter = change_letter_x, variable = var_y))
  }
  
  # Specify covariances between constant change factors
  if (model_y$alpha_constant == TRUE){
    lavaan_bi_change <- paste0(lavaan_bi_change, specify_int_change_covar(change_letter = change_letter_y, variable = var_x))
  }
  
  # Specify covariances between constant change factors
  if (model_x$alpha_constant == TRUE & model_y$alpha_constant == TRUE){
    lavaan_bi_change <- paste0(lavaan_bi_change, specify_bi_change_covar(change_letter_x = change_letter_x, change_letter_y = change_letter_y))
  }
  
  # Define empty str object 
  lavaan_bi_coupling <- "# Specify between-construct coupling parameters ----\n"
  
  if (coupling$coupling_piecewise == FALSE) {
    
    # Specify true score y predicting concurrent change score x ----
    if (coupling$delta_con_xy == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_ct_con(timepoints = timepoints, variable_x = var_x, variable_y = var_y))
    }
    
    # Specify true score y predicting subsequent change score x ----
    if (coupling$delta_lag_xy == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_ct_lag(timepoints = timepoints, variable_x = var_x, variable_y = var_y))
    }
    
    # Specify true score x predicting concurrent change score y ----
    if (coupling$delta_con_yx == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_ct_con(timepoints = timepoints, variable_x = var_y, variable_y = var_x))
    }
    
    # Specify true score x predicting subsequent change score y ----
    if (coupling$delta_lag_yx == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_ct_lag(timepoints = timepoints, variable_x = var_y, variable_y = var_x))
    }
    
    # Specify change score y predicting concurrent change score x ----
    if (coupling$xi_con_xy == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_cc_con(timepoints = timepoints, variable_x = var_x, variable_y = var_y))
    }
    
    # Specify change score y predicting subsequent change score x ----
    if (coupling$xi_lag_xy == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_cc_lag(timepoints = timepoints, variable_x = var_x, variable_y = var_y))
    }
    
    # Specify change score x predicting concurrent change score y ----
    if (coupling$xi_con_yx == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_cc_con(timepoints = timepoints, variable_x = var_y, variable_y = var_x))
    }
    
    # Specify change score x predicting subsequent change score y ----
    if (coupling$xi_lag_yx == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_cc_lag(timepoints = timepoints, variable_x = var_y, variable_y = var_x))
    }
    
  } else if (coupling$coupling_piecewise == TRUE) {
    
    # Specify true score y predicting concurrent change score x ----
    if (coupling$delta_con_xy == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_ct_con_piecewise(timepoints = timepoints, variable_x = var_x, variable_y = var_y, changepoint = coupling$coupling_piecewise_num))
    }
    
    # Specify true score y predicting subsequent change score x ----
    if (coupling$delta_lag_xy == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_ct_lag_piecewise(timepoints = timepoints, variable_x = var_x, variable_y = var_y, changepoint = coupling$coupling_piecewise_num))
    }
    
    # Specify true score x predicting concurrent change score y ----
    if (coupling$delta_con_yx == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_ct_con_piecewise(timepoints = timepoints, variable_x = var_y, variable_y = var_x, changepoint = coupling$coupling_piecewise_num))
    }
    
    # Specify true score x predicting subsequent change score y ----
    if (coupling$delta_lag_yx == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_ct_lag_piecewise(timepoints = timepoints, variable_x = var_y, variable_y = var_x, changepoint = coupling$coupling_piecewise_num))
    }
    
    # Specify change score y predicting concurrent change score x ----
    if (coupling$xi_con_xy == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_cc_con_piecewise(timepoints = timepoints, variable_x = var_x, variable_y = var_y, changepoint = coupling$coupling_piecewise_num))
    }
    
    # Specify change score y predicting subsequent change score x ----
    if (coupling$xi_lag_xy == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_cc_lag_piecewise(timepoints = timepoints, variable_x = var_x, variable_y = var_y, changepoint = coupling$coupling_piecewise_num))
    }
    
    # Specify change score x predicting concurrent change score y ----
    if (coupling$xi_con_yx == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_cc_con_piecewise(timepoints = timepoints, variable_x = var_y, variable_y = var_x, changepoint = coupling$coupling_piecewise_num))
    }
    
    # Specify change score x predicting subsequent change score y ----
    if (coupling$xi_lag_yx == TRUE){
      lavaan_bi_coupling <- paste0(lavaan_bi_coupling, specify_lcs_cc_lag_piecewise(timepoints = timepoints, variable_x = var_y, variable_y = var_x, changepoint = coupling$coupling_piecewise_num))
    }
  }
  
  # Combine univariate and bivariate models
  lavaan_bi_model <- paste0(model_x_uni_lavaan, model_y_uni_lavaan, resid_covar, lavaan_bi_change, lavaan_bi_coupling)
  
  return(lavaan_bi_model)
}

