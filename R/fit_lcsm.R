#' Fit univariate latent change score models
#' @description Fit univariate latent change score models.
#' 
#' @param data A data frame in "wide" format, i.e. one column for each measurement point and one row for each observation.
#' @param var Vector, specifying the variable names of each measurement point sequentially.
#' @param model List of model specifications (logical) for variables specified in \code{var}.
#' \itemize{
#' \item{\code{alpha_constant}}{ (Constant change factor)},
#' \item{\code{alpha_piecewise}}{ (Piecewise constant change factors)},
#' \item{\code{alpha_piecewise_num}}{ (Changepoint of piecewise constant change factors},
#' \item{\code{alpha_linear}}{ (Linear change factor)},
#' \item{\code{beta}}{ (Proportional change factor)},
#' \item{\code{phi}}{ (Autoregression of change scores)}.
#' }
#' @param add String, lavaan syntax to be added to the model
#' @param return_lavaan_syntax Logical, if TRUE return the lavaan syntax used for simulating data. To make it look beautiful use the function \link[base]{cat}.
#' @param mimic See `mimic` argument in \link[lavaan]{lavOptions}.
#' @param estimator See `estimator` argument in \link[lavaan]{lavOptions}.
#' @param missing See `missing` argument in \link[lavaan]{lavOptions}.
#' @param ... Additional arguments to be passed to \link[lavaan]{lavOptions}.
#' @return This function returns a lavaan class object.
#' @references Ghisletta, P., & McArdle, J. J. (2012). Latent Curve Models and Latent Change Score Models Estimated in R. Structural Equation Modeling: A Multidisciplinary Journal, 19(4), 651–682. \url{https://doi.org/10.1080/10705511.2012.713275}.
#' 
#' Grimm, K. J., Ram, N., & Estabrook, R. (2017). Growth Modeling—Structural Equation and Multilevel Modeling Approaches. New York: The Guilford Press.
#' 
#' McArdle, J. J. (2009). Latent variable modeling of differences and changes with longitudinal data. Annual Review of Psychology, 60(1), 577–605. \url{https://doi.org/10.1146/annurev.psych.60.110707.163612}.
#' 
#' Yves Rosseel (2012). lavaan: An R Package for Structural Equation Modeling. Journal of Statistical Software, 48(2), 1-36.
#' \url{http://www.jstatsoft.org/v48/i02/}.
#' @export
#' @examples # Fit univariate latent change score model
#' fit_uni_lcsm(data = data_uni_lcsm, 
#'              var = names(data_uni_lcsm)[2:4],
#'              model = list(alpha_constant = TRUE, 
#'                           beta = FALSE, 
#'                           phi = FALSE))

fit_uni_lcsm <- function(data,
                         var,
                         model, 
                         add = NULL,
                         mimic = "Mplus",
                         estimator = "MLR",
                         missing = "FIML",
                         return_lavaan_syntax = FALSE,
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
  
  # Option to specify character lavaan syntax or model parameters as list 
  if (is.list(model) == TRUE) {
    
    model_uni <- specify_uni_lcsm(timepoints = timepoints,
                                  var = "x",
                                  model = model,
                                  change_letter = "g",
                                  add = add
    )
    
  } else if (is.character(model) == TRUE) {
    model_uni <- model
  }
  

  
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
    
    # Return model
      return(model_uni)
      
  }
}

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
#' @param add String, lavaan syntax to be added to the model
#' @param return_lavaan_syntax Logical, if TRUE return the lavaan syntax used for simulating data. To make it look beautiful use the function \link[base]{cat}.
#' @param mimic See `mimic` argument in \link[lavaan]{lavOptions}.
#' @param estimator See `estimator` argument in \link[lavaan]{lavOptions}.
#' @param missing See `missing` argument in \link[lavaan]{lavOptions}.
#' @param ... Additional arguments to be passed to \link[lavaan]{lavOptions}.
#' @return This function returns a lavaan class object.
#' @references Ghisletta, P., & McArdle, J. J. (2012). Latent Curve Models and Latent Change Score Models Estimated in R. Structural Equation Modeling: A Multidisciplinary Journal, 19(4), 651–682. \url{https://doi.org/10.1080/10705511.2012.713275}.
#' 
#' Grimm, K. J., Ram, N., & Estabrook, R. (2017). Growth Modeling—Structural Equation and Multilevel Modeling Approaches. New York: The Guilford Press.
#' 
#' McArdle, J. J. (2009). Latent variable modeling of differences and changes with longitudinal data. Annual Review of Psychology, 60(1), 577–605. \url{https://doi.org/10.1146/annurev.psych.60.110707.163612}.
#' 
#' Yves Rosseel (2012). lavaan: An R Package for Structural Equation Modeling. Journal of Statistical Software, 48(2), 1-36.
#' \url{http://www.jstatsoft.org/v48/i02/}.
#' @export
#' @examples # Fit 
#' fit_bi_lcsm(data = data_bi_lcsm, 
#'             var_x = names(data_bi_lcsm)[2:4], 
#'             var_y = names(data_bi_lcsm)[12:14],
#'             model_x = list(alpha_constant = TRUE, 
#'                            beta = TRUE, 
#'                            phi = FALSE),
#'             model_y = list(alpha_constant = TRUE, 
#'                            beta = TRUE, 
#'                            phi = TRUE),
#'             coupling = list(delta_lag_xy = TRUE, 
#'                             xi_lag_yx = TRUE)
#'                             )

fit_bi_lcsm <- function(data,
                        var_x,
                        var_y,
                        model_x, 
                        model_y,
                        coupling,
                        add = NULL,
                        mimic = "Mplus",
                        estimator = "MLR",
                        missing = "FIML",
                        return_lavaan_syntax = FALSE,
                        ...){
  
  # Count timepoints ----
  if (length(var_x) != length(var_y)){
    stop("Unequal number of variables specified for x and y. Both vectors 'var_x' and 'var_x' need to have the same number of variables.")
  }
  
  timepoints <- length(var_x)
  
  # Rename variables ----
  data_lcsm <- rename_lcsm_vars(data = data, 
                                var_x = var_x, 
                                var_y = var_y)
  
  # Specify model ----
  # TODO Option to specify character lavaan syntax or model parameters as list 
  # THIS NEEDS TO BE DIFFERENT FROM UNIVARIATE SOLUTION
  # PROBABLY ADD ONE MORE ARGUMENT TO FUNCTION TO ADD STRING HERe
  
  model_bi <- specify_bi_lcsm(timepoints = timepoints,
                              var_x = "x",
                              model_x = model_x,
                              var_y = "y",
                              model_y = model_y,  
                              coupling = coupling,
                              add = add)
  
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

      return(model_bi)
      
  }
}
