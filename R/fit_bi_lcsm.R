#' Fit bivariate latent change score models
#' @description Fit bivariate latent change score models.
#' 
#' @param data Wide dataset.
#' @param var_x List of variables measuring one construct of the model.
#' @param var_y List of variables measuring another construct of the model.
#' @param model_x List of model specifications (logical) for variables specified in \code{var_x}.
#' \itemize{
#' \item{\code{alpha_constant}}{ (Constant change factor)},
#' \item{\code{alpha_piecewise}}{ (Piecewise constant change factors)},
#' \item{\code{alpha_piecewise_num}}{ (Changepoint of piecewise constant change factors)},
#' \item{\code{alpha_linear}}{ (Linear change factor)},
#' \item{\code{beta}}{ (Proportional change factor)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param model_y List of model specifications for variables specified in \code{var_y}.
#' \itemize{
#' \item{\code{alpha_constant}}{ (Constant change factor)},
#' \item{\code{alpha_piecewise}}{ (Piecewise constant change factors)},
#' \item{\code{alpha_piecewise_num}}{ (Changepoint of piecewise constant change factors)},
#' \item{\code{alpha_linear}}{ (Linear change factor)},
#' \item{\code{beta}}{ (Proportional change factor)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param coupling List of model specifications (logical) for coupling parameters.
#' \itemize{
#' \item{\code{coupling_piecewise}}{ (Piecewise coupling parameters)},
#' \item{\code{coupling_piecewise_num}}{ (Changepoint of piecewise coupling parameters)},
#' \item{\code{delta_xy}}{ (True score y predicting subsequent change score x)},
#' \item{\code{delta_yx}}{ (True score x predicting subsequent change score y)},
#' \item{\code{xi_xy}}{ (Change score y predicting subsequent change score x)},
#' \item{\code{xi_yx}}{ (Change score x predicting subsequent change score y)}.
#' }
#' @param export_model_syntax Export lavaan model syntax of specified model to global environment as object named 'lavaan_model_syntax'. Name of this object can be specified using \code{name_model_syntax}. 
#' @param name_model_syntax String, if \code{export_model_syntax} = TRUE, name of object containing lavaan model syntax.
#' @param mimic See \link[lavaan]{lavaan}.
#' @param estimator See \link[lavaan]{lavaan}.
#' @param missing See \link[lavaan]{lavaan}.
#' @param ... Additional arguments to be passed to \link[lavaan]{lavaan}.
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
                        missing = "FIML",
                        export_model_syntax = FALSE,
                        name_model_syntax = "lavaan_model_syntax",
                        ...){

  # Count timepoints ----
  if (length(var_x) != length(var_y)){
    stop("Unequal number of variables specified for x and y. Both lists need to have the same number of variables.")
  }

  timepoints <- length(var_x)
  
  # Rename variables ----
  data_lcsm <- rename_lcsm_vars(data = data, 
                         var_x = var_x, 
                         var_y = var_y)
    
  # Specify model ----
  model_bi <- specify_lavaan_bi_model(timepoints = timepoints,
                                      var_x = "x",
                                      model_x = model_x,
                                      var_y = "y",
                                      model_y = model_y,  
                                      coupling = coupling)
  
  
  # Export model ----
  if (export_model_syntax == TRUE)
  assign(name_model_syntax, model_bi, envir = .GlobalEnv)
  
  # Fit lcsm using lavaan ----
  fit_lcsm_bi <- lavaan::lavaan(
    data = data_lcsm,
    model = model_bi,
    meanstructure = TRUE,
    fixed.x = FALSE,
    control = list(iter.max = 10000),
    verbose = FALSE,
    mimic = mimic,
    estimator = estimator,
    missing = missing,
    ...)

  # Return lavaan object ----
  fit_lcsm_bi
}
  
  

