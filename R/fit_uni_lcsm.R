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
#' @param return_lavaan_syntax Logical, if TRUE return the lavaan syntax used for simulating data, looking beautiful using \link[base]{cat}
#' @param return_lavaan_syntax_string Logical, if return_lavaan_syntax is TRUE and return_lavaan_syntax_string == TRUE return the lavaan syntax as one ugly string
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
                         return_lavaan_syntax = FALSE,
                         return_lavaan_syntax_string = FALSE,
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
                                        var = "x",
                                        model = model,
                                        change_letter = "g"
                                        )
  
  # Return ----
  if (return_lavaan_syntax == FALSE) {
    
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
    
    # Return lavaan object
    return(fit_lcsm_uni)
    
  } else if (return_lavaan_syntax == TRUE)  {
    
    if (return_lavaan_syntax_string == TRUE){
      # Return lavaan syntax string
      return(model_uni)
      
    } else if (return_lavaan_syntax_string == FALSE){
      # Return lavaan syntax 
      return(base::cat(model_uni))
    }
  }
  
}
