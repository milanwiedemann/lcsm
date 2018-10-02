#' Fit univariate latent change score models
#' @description Fit univariate latent change score models.
#' 
#' @param data Wide dataset.
#' @param var List of variables measuring construct of the model.
#' @param model List of model specifications (logical) for variables specified in \code{var}.
#' \itemize{
#' \item{\code{alpha_constant}}{ (Constant change factor)},
#' \item{\code{alpha_piecewise}}{ (Piecewise constant change factors)},
#' \item{\code{alpha_piecewise_num}}{ (Changepoint of piecewise constant change factors},
#' \item{\code{alpha_linear}}{ (Linear change factor)},
#' \item{\code{beta}}{ (Proportional change factor)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param export_model_syntax Export lavaan model syntax of specified model to global environment as object named 'lavaan_model_syntax'. If the object 'lavaan_model_syntax' this will overwrite the existing object. 
#' @return This function returns a lavaan class object.
#' @export

fit_uni_lcsm <- function(data,
                         var,
                         model, 
                         mimic = "Mplus",
                         estimator = "MLR",
                         missing = "FIML",
                         export_model_syntax = FALSE){
   
  # Count timepoints ----
  timepoints <- length(var)
  
  # Rename variables ----
  data_lcsm <- lcsm::rename_lcsm_vars(data = data, 
                                      var_x = var,
                                      var_y = NULL
                                      )  
  
  # Specify model ----
  model_uni <- specify_lavaan_uni_model(timepoints = timepoints,
                                      var = "x",
                                      model = model,
                                      change_letter = "g"
                                      )
  
  # Export model ----
  if (export_model_syntax == TRUE)
  assign("lavaan_model_syntax", model_uni, envir = .GlobalEnv)
  
  # Fit lcsm using lavaan ----
  fit_lcsm_uni <- lavaan::lavaan(
    data = data_lcsm,
    model = model_uni,
    meanstructure = TRUE,
    fixed.x = FALSE,
    control = list(iter.max = 10000),
    verbose = FALSE,
    mimic = mimic,
    estimator = estimator,
    missing = missing)
  
  # Return lavaan object ----
  fit_lcsm_uni
}



