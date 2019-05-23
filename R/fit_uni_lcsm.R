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
#' @param export_model_syntax Export lavaan model syntax of specified model to global environment as object named 'lavaan_model_syntax'. Name of this object can be specified using \code{name_model_syntax}. 
#' @param name_model_syntax String, if \code{export_model_syntax} = TRUE, name of object containing lavaan model syntax.
#' @param mimic See \link[lavaan]{lavaan}.
#' @param estimator See \link[lavaan]{lavaan}.
#' @param missing See \link[lavaan]{lavaan}.
#' @param ... Additional arguments to be passed to \link[lavaan]{lavaan}.
#' @return This function returns a lavaan class object.
#' @export

fit_uni_lcsm <- function(data,
                         var,
                         model, 
                         mimic = "Mplus",
                         estimator = "MLR",
                         missing = "FIML",
                         export_model_syntax = FALSE,
                         name_model_syntax = "lavaan_model_syntax",
                         ...
                         ){
   
  # Count timepoints ----
  timepoints <- length(var)
  
  # Rename variables ----
  data_lcsm <- rename_lcsm_vars(data = data, 
                                var_x = var,
                                var_y = NULL
                                )  
  
  # Specify model ----
  model_uni <- specify_lavaan_uni_model(timepoints = timepoints,
                                        variable = "x",
                                        model = model,
                                        change_letter = "g"
                                        )
  
  # Export model ----
  if (export_model_syntax == TRUE)
  assign(name_model_syntax, model_uni, envir = .GlobalEnv)
  
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
    missing = missing,
    ...)
  
  # Return lavaan object ----
  return(fit_lcsm_uni)
}



