#' Specify lavaan model for univariate latent change score models
#' @description TODO: Describe function
#' @param timepoints Number if timepoints.
#' @param model List of model specifications (logical) for the variables specified in \code{variable}.
#' \itemize{
#' \item{\code{alpha_constant}: Constant change factor},
#' \item{\code{alpha_piecewise}: Piecewise constant change factors},
#' \item{\code{alpha_piecewise_num}: Changepoint of piecewise constant change factors},
#' \item{\code{alpha_linear}: Linear change factor},
#' \item{\code{beta}: Proportional change factor},
#' \item{\code{phi}: Autoregression of change scores}.
#' }
#' @param var String, specifying letter to be used for of variables (Usually x or y).
#' @param change_letter String, specifying letter to be used for change factor (Usually g or j).
#' @references Ghisletta, P., & McArdle, J. J. (2012). Latent Curve Models and Latent Change Score Models Estimated in R. Structural Equation Modeling: A Multidisciplinary Journal, 19(4), 651–682. \url{https://doi.org/10.1080/10705511.2012.713275}.
#' 
#' Grimm, K. J., Ram, N., & Estabrook, R. (2017). Growth Modeling—Structural Equation and Multilevel Modeling Approaches. New York: The Guilford Press.
#' 
#' McArdle, J. J. (2009). Latent variable modeling of differences and changes with longitudinal data. Annual Review of Psychology, 60(1), 577–605. \url{https://doi.org/10.1146/annurev.psych.60.110707.16361}.
#' 
#' Yves Rosseel (2012). lavaan: An R Package for Structural Equation Modeling. Journal of Statistical Software, 48(2), 1-36.
#' \url{http://www.jstatsoft.org/v48/i02/}.
#' @return Lavaan model syntax including comments.
#' @export 
#' @examples # Specify univariate LCS model
#' lavaan_uni_lcsm_01 <- specify_uni_lcsm(timepoints = 10, 
#'                                        model = list(alpha_constant = TRUE, 
#'                                                     beta = TRUE, 
#'                                                     phi = TRUE), 
#'                                        var = "x",  
#'                                        change_letter = "g")
#'                  
#' #' # To look at string simply return the object                                    
#' lavaan_uni_lcsm_01
#' 
#' # To get a readable output use cat() function
#' cat(lavaan_uni_lcsm_01)
#' 

specify_uni_lcsm <- function(timepoints, model, var, change_letter = "g") {
  
  # Code parameters in model that are not defined as FALSE
  
  # Set parameters ----
  # Set parameters not specified in model for FALSE
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
  
  if (is.null(model$phi) == TRUE) {
    model$phi <- FALSE
  }
  
  # Return error message when both constant change and piecewise constant change are defined
  if (model$alpha_constant == TRUE & model$alpha_piecewise == TRUE){
    stop("Choose only one constant change method.")
  }
  
  # Return error message when both constant change and linear change are defined
  if (model$alpha_constant == TRUE & model$alpha_linear == TRUE){
    stop("Constant change is automatically added to model when linear change is selected. Set alpha_linear to TRUE and alpha_constant to FALSE to model both.")
  }
  
  # Define empty str object 
  lavaan_uni_model <- ''
  
  # Specify no change by default ----
  # Specify latent true scores
  lavaan_uni_model <- specify_lts(timepoints = timepoints, variable = var)
  
  # Specify means of latent true scores
  lavaan_uni_model <- paste0(lavaan_uni_model, specify_lts_mean(timepoints = timepoints, variable = var))
  
  # Specify variances of latent true scores
  lavaan_uni_model <- paste0(lavaan_uni_model, specify_lts_var(timepoints = timepoints, variable = var))
  
  # Specify observed intercepts
  lavaan_uni_model <- paste0(lavaan_uni_model, specify_os_int(timepoints = timepoints, variable = var))
  
  # Specify observed residual variances
  lavaan_uni_model <- paste0(lavaan_uni_model, specify_os_resid(timepoints = timepoints, variable = var)) 
  
  # Specify latent true score autoregressions
  lavaan_uni_model <- paste0(lavaan_uni_model, specify_lts_autoreg(timepoints = timepoints, variable = var))
  
  # Specify latent change scores
  lavaan_uni_model <- paste0(lavaan_uni_model, specify_lcs(timepoints = timepoints, variable = var))
  
  # Specify latent change score means
  lavaan_uni_model <- paste0(lavaan_uni_model, specify_lcs_mean(timepoints = timepoints, variable = var))
  
  # Specify latent change score variances
  lavaan_uni_model <- paste0(lavaan_uni_model, specify_lcs_var(timepoints = timepoints, variable = var))
  
  # Specify constant change ----
  if (model$alpha_constant == TRUE){
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change(timepoints = timepoints, variable = var, change_letter))
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_mean(timepoints = timepoints, variable = var, change_letter, 2))
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_var(timepoints = timepoints, variable = var, change_letter, 2))
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_covar_initial_ts(timepoints = timepoints, variable = var, change_letter, 2))
  }
  
  # Specify piecewise constant change ----
  if (model$alpha_piecewise == TRUE){
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_piecewise(timepoints = timepoints, variable = var, change_letter, model$alpha_piecewise_num))
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_mean(timepoints = timepoints, variable = var, change_letter, 2))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_mean(timepoints = timepoints, variable = var, change_letter, 3))
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_var(timepoints = timepoints, variable = var, change_letter, 2))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_var(timepoints = timepoints, variable = var, change_letter, 3))
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_covar_initial_ts(timepoints = timepoints, variable = var, change_letter, 2))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_covar_initial_ts(timepoints = timepoints, variable = var, change_letter, 3))
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_uni_change_covar(change_letter, 2, change_letter, 3))
  }
  
  # Specify linear change ----
  if (model$alpha_linear == TRUE){
    
    # Specify constant change
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change(timepoints = timepoints, variable = var, change_letter))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_mean(timepoints = timepoints, variable = var, change_letter, 2))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_var(timepoints = timepoints, variable = var, change_letter, 2))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_covar_initial_ts(timepoints = timepoints, variable = var, change_letter, 2))
    
    # Specify linear change
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_linear_change(timepoints = timepoints, variable = var, change_letter))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_mean(timepoints = timepoints, variable = var, change_letter, 3))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_var(timepoints = timepoints, variable = var, change_letter, 3))
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_constant_change_covar_initial_ts(timepoints = timepoints, variable = var, change_letter, 3))
    
    # Specify change change
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_uni_change_covar(change_letter, 2, change_letter, 3))
  }
  
  # Specify covar between constant change and linear change ----
  if (model$alpha_constant == TRUE & model$alpha_linear == TRUE){
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_uni_change_covar(change_letter, 2, change_letter, 3))
  }
  
  # Specify proportional change ----
  if (model$beta == TRUE){
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_proportional_effect(timepoints = timepoints, variable = var))
  }
  
  # Specify autoregressive change scores ----
  if (model$phi == TRUE){
    
    lavaan_uni_model <- paste0(lavaan_uni_model, specify_lcs_autoreg(timepoints = timepoints, variable = var))
  }
  return(lavaan_uni_model)
}

#' Specify lavaan model for bivariate latent change score models
#' @description TODO: Describe function
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
#' @references Ghisletta, P., & McArdle, J. J. (2012). Latent Curve Models and Latent Change Score Models Estimated in R. Structural Equation Modeling: A Multidisciplinary Journal, 19(4), 651–682. \url{https://doi.org/10.1080/10705511.2012.713275}.
#' 
#' Grimm, K. J., Ram, N., & Estabrook, R. (2017). Growth Modeling—Structural Equation and Multilevel Modeling Approaches. New York: The Guilford Press.
#' 
#' McArdle, J. J. (2009). Latent variable modeling of differences and changes with longitudinal data. Annual Review of Psychology, 60(1), 577–605. \url{https://doi.org/10.1146/annurev.psych.60.110707.16361}.
#' 
#' Yves Rosseel (2012). lavaan: An R Package for Structural Equation Modeling. Journal of Statistical Software, 48(2), 1-36.
#' \url{http://www.jstatsoft.org/v48/i02/}.
#' @examples # Specify biivariate LCS model
#' lavaan_bi_lcsm_01 <- specify_bi_lcsm(timepoints = 10, 
#'                                      var_x = "x",
#'                                      model_x = list(alpha_constant = TRUE, 
#'                                                     beta = TRUE, 
#'                                                     phi = TRUE),
#'                                      var_y = "y",  
#'                                      model_y = list(alpha_constant = TRUE, 
#'                                                     beta = TRUE, 
#'                                                     phi = TRUE),  
#'                                      coupling = list(delta_lag_xy = TRUE, 
#'                                                      delta_lag_yx = TRUE),
#'                                      change_letter_x = "g",
#'                                      change_letter_y = "j")
#' 
#' # To look at string simply return the object                                    
#' lavaan_bi_lcsm_01
#' 
#' # To get a readable output use cat() function
#' cat(lavaan_bi_lcsm_01)
#' 
specify_bi_lcsm <- function(timepoints,
                                    var_x,
                                    model_x,
                                    var_y,
                                    model_y,
                                    coupling,
                                    change_letter_x = "g",
                                    change_letter_y = "j"
) {
  
  # Set parameters ----
  # Set parameters not specified in model_x for FALSE
  
  if (is.null(model_x$alpha_constant) == TRUE) {
    model_x$alpha_constant <- FALSE
  }
  
  if (is.null(model_x$beta) == TRUE) {
    model_x$beta <- FALSE
  }
  
  if (is.null(model_x$alpha_piecewise) == TRUE) {
    model_x$alpha_piecewise <- FALSE
  }
  
  if (is.null(model_x$alpha_piecewise_num) == TRUE) {
    model_x$alpha_piecewise_num <- FALSE
  }
  
  if (is.null(model_x$alpha_linear) == TRUE) {
    model_x$alpha_linear <- FALSE
  }
  
  if (is.null(model_x$phi) == TRUE) {
    model_x$phi <- FALSE
  }
  
  # Set parameters not specified in model_y for FALSE
  if (is.null(model_y$alpha_constant) == TRUE) {
    model_y$alpha_constant <- FALSE
  }
  
  if (is.null(model_y$beta) == TRUE) {
    model_y$beta <- FALSE
  }
  
  if (is.null(model_y$alpha_piecewise) == TRUE) {
    model_y$alpha_piecewise <- FALSE
  }
  
  if (is.null(model_y$alpha_piecewise_num) == TRUE) {
    model_y$alpha_piecewise_num <- FALSE
  }
  
  if (is.null(model_y$alpha_linear) == TRUE) {
    model_y$alpha_linear <- FALSE
  }
  
  if (is.null(model_y$phi) == TRUE) {
    model_y$phi <- FALSE
  }
  
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
  model_x_uni_lavaan <- paste0(model_x_uni_lavaan, specify_uni_lcsm(timepoints = timepoints, 
                                                                            model = model_x, 
                                                                            var = var_x, 
                                                                            change_letter = change_letter_x))
  
  model_y_uni_lavaan <- "# Specify parameters for construct y ----\n"
  model_y_uni_lavaan <- paste0(model_y_uni_lavaan, specify_uni_lcsm(timepoints = timepoints, 
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
    lavaan_bi_change <- paste0(lavaan_bi_change, specify_int_change_between_covar(change_letter = change_letter_x, variable = var_y))
  }
  
  # Specify covariances between constant change factors
  if (model_y$alpha_constant == TRUE){
    lavaan_bi_change <- paste0(lavaan_bi_change, specify_int_change_between_covar(change_letter = change_letter_y, variable = var_x))
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