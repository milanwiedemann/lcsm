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
#' @param return_lavaan_syntax Logical, if TRUE return the lavaan syntax used for simulating data, looking beautiful using \link[base]{cat}
#' @param return_lavaan_syntax_string Logical, if return_lavaan_syntax == TRUE and return_lavaan_syntax_string == TRUE return the lavaan syntax as one ugly string
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
                        return_lavaan_syntax = FALSE,
                        return_lavaan_syntax_string = FALSE,
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
  
  # Return ----
  if (return_lavaan_syntax == FALSE) {
    
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
    
    # Return lavaan object
    return(fit_lcsm_bi)
    
  } else if (return_lavaan_syntax == TRUE)  {
    
    if (return_lavaan_syntax_string == TRUE){
      # Return lavaan syntax string
      return(model_bi)
      
    } else if (return_lavaan_syntax_string == FALSE){
      # Return lavaan syntax 
      return(base::cat(model_bi))
    }
  }

}
  
  

