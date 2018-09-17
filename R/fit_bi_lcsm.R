#' Fit bivariate latent change score models
#' @description Fit bivariate latent change score models.
#' 
#' @param data Wide dataset.
#' @param var_x List of variables measuring one construct of the model.
#' @param var_y List of variables measuring another construct of the model.
#' @param model_x List of model specifications for variables specified in \code{var_x}.
#' \itemize{
#' \item{\code{alpha}}{ (Constant change)},
#' \item{\code{beta}}{ (Proportional change)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param model_y List of model specifications for variables specified in \code{var_y}.
#' \itemize{
#' \item{\code{alpha}}{ (Constant change)},
#' \item{\code{beta}}{ (Proportional change)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param coupling List of model specifications for coupling parameters.
#' \itemize{
#' \item{\code{delta_xy}}{ (True score y predicting subsequent change score x)},
#' \item{\code{delta_yx}}{ (True score x predicting subsequent change score y)},
#' \item{\code{xi_xy}}{ (Change score y predicting subsequent change score x)},
#' \item{\code{xi_yx}}{ (Change score x predicting subsequent change score y)}.
#' }
#' @return This function returns a lavaan class object.
#' @export

fit_bi_lcsm <- function(data,
                        var_x,
                        var_y,
                        model_x, 
                        model_y,
                        coupling,
                        mimic = "Mplus",
                        estimator = "MLR",
                        missing = "FIML"){

  # Count timepoints ----
  if (length(var_x) != length(var_y)){
    stop("Unequal number of variables specified for x and y. Both lists need to have the same number of variables.")
  }

  timepoints <- length(var_x)
  
  # Rename variables ----
  data_lcsm <- lcsm::rename_lcsm_vars(data = data, 
                         var_x = var_x, 
                         var_y = var_y)
    
  # Specify model ----
  model_bi <- specify_lavaan_bi_model(timepoints = timepoints,
                                      var_x = "x",
                                      model_x = model_x,
                                      var_y = "y",
                                      model_y = model_y,  
                                      coupling = coupling)
  
  
  # Fit lcsm using lavaan ----
  fit_lcsm_bi <- lavaan(
    data = data_lcsm,
    model = model_bi,
    meanstructure = TRUE,
    fixed.x = FALSE,
    control = list(iter.max = 10000),
    verbose = FALSE,
    mimic = mimic,
    estimator = estimator,
    missing = missing)

  # Return lavaan object ----
  fit_lcsm_bi
}
  
  

