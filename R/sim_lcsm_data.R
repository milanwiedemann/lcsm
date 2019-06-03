#' Simulate data from a univariate latent change score model
#'
#' @param timepoints See \link[lcstools]{specify_lavaan_uni_model}
#' @param var See \link[lcstools]{specify_lavaan_uni_model}
#' @param model See \link[lcstools]{specify_lavaan_uni_model}
#' @param change_letter See \link[lcstools]{specify_lavaan_uni_model}
#' @param sample.nobs Numeric, number of cases to be simulated, see \link[lcstools]{specify_lavaan_uni_model}
#' @param na_pct Numeric, percentage of random missing values in the simulated dataset [0,1]
#' @param model_param List, specifying parameter estimates for the LCS model that has been specified in the argument 'model'
#' \itemize{
#' \item{\strong{\code{gamma_lx1}}}: Mean of latent true scores x (Intercept),
#' \item{\strong{\code{sigma2_lx1}}}: Variance of latent true scores x,
#' \item{\strong{\code{sigma2_ux}}}: Variance of observed scores x,
#' \item{\strong{\code{alpha_g2}}}: Mean of change factor (g2),
#' \item{\strong{\code{alpha_g3}}}: Mean of change factor (g3),
#' \item{\strong{\code{sigma2_g2}}}: Variance of constant change factor (g2).
#' \item{\strong{\code{sigma2_g3}}}: Variance of constant change factor (g3),
#' \item{\strong{\code{sigma_g2lx1}}}: Covariance of constant change factor (g2) with the initial true score x (lx1),
#' \item{\strong{\code{sigma_g3lx1}}}: Covariance of constant change factor (g3) with the initial true score x (lx1),
#' \item{\strong{\code{sigma_g2g3}}}: Covariance of change factors (g2 and g2),
#' \item{\strong{\code{phi_x}}}: Autoregression of change scores x.
#' }
#' @param ... Arguments to be passed on to \link[lavaan]{simulateData}
#' @param return_lavaan_syntax Logical, if TRUE return the lavaan syntax used for simulating data, looking beautiful using \link[base]{cat}
#' @param return_lavaan_syntax_string Logical, if return_lavaan_syntax == TRUE and return_lavaan_syntax_string == TRUE return the lavaan syntax as one ugly string
#' @return
#' @export
#'
#' @examples
sim_uni_lcsm_data <- function(timepoints, model, model_param = NULL, var = "x", change_letter = "j", sample.nobs = 500, na_pct = 0, ..., return_lavaan_syntax = FALSE, return_lavaan_syntax_string = FALSE){
  
  # 1. Create string object with lavaan syntax including labels for parameters
  model <- specify_lavaan_uni_model(timepoints = timepoints,
                                    var = var,
                                    model = model,
                                    change_letter = change_letter)
  
  # 2. Extract all labels from lavaan syntax using lavaan::lavaanify()
  labels <- lavaan::lavaanify(model) %>% 
    tibble::as_tibble() %>%
    dplyr::mutate(label = dplyr::na_if(label, ""),
                  label = base::factor(label)) %>% 
    dplyr::filter(is.na(label) == FALSE) %>% 
    dplyr::distinct(label) %>% 
    base::unlist()
  
  # 3. Enter values for all labels/estimates in lavaan syntax using base::readline()
  if (base::is.null(model_param) == TRUE){
    base::message("Please enter the following parameter estimates for the data simulation:")
    
    # Create empty list
    estimates <- list()
    
    for (label_i in labels) {
      value <- base::readline(base::paste0("Enter value for ", label_i, ": "))
      estimates[label_i] <- base::as.numeric(value)
    } 
  } else if (base::is.null(model_param) == FALSE){
    base::message("Parameter estimates for the data simulation are taken from the argument 'model_param'.")
    # If argument model_param is specified, use this to simulate data
    
    # Create vector indicating which labels have been specified in model_param
    check_labels <- labels %in% base::names(model_param)
    
    # Test if all labels have been specified
    if (base::all(check_labels) == TRUE){
      base::message("All parameter estimates for the LCS model have been specified in the argument 'model_param'.")
    } else if (base::all(check_labels) == FALSE){
      
      missing_labels <- labels[base::which(!check_labels)]
      
      missing_labels_01 <- paste("- ", missing_labels)
      
      missing_labels_02 <- stringr::str_c(missing_labels_01, sep = "", collapse = "\n")
      
      base::warning(paste0("The following parameters are specified in LCS model but no parameter estimates have been entered in 'model_param':\n", missing_labels_02), call. = FALSE)
    }
    
    estimates <- model_param
  }
  
  # 4. Replace all labels in lavaan syntax with values entered above
  model_estimates <- model
  
  for (estimate_i in seq_along(estimates)) {
    model_estimates <- stringr::str_replace_all(model_estimates, names(estimates[estimate_i]), as.character(estimates[estimate_i])) 
  }
  
  # 5. Simulate data using lavaan::simulateData()
  sim_data_model <- lavaan::simulateData(model = model_estimates, 
                                         model.type = "sem", 
                                         meanstructure = 'default', 
                                         int.ov.free = TRUE, 
                                         int.lv.free = FALSE, 
                                         conditional.x = TRUE,
                                         fixed.x = FALSE, 
                                         orthogonal = FALSE, 
                                         std.lv = TRUE, 
                                         auto.fix.first = FALSE, 
                                         auto.fix.single = FALSE, 
                                         auto.var = TRUE, 
                                         auto.cov.lv.x = TRUE, 
                                         auto.cov.y = TRUE, 
                                         sample.nobs = sample.nobs, 
                                         ov.var = NULL, 
                                         group.label = paste("G", 1:ngroups, sep = ""), 
                                         skewness = 0, 
                                         kurtosis = 0, 
                                         seed = NULL, 
                                         empirical = FALSE, 
                                         return.type = "data.frame",
                                         return.fit = FALSE,
                                         debug = FALSE, 
                                         standardized = FALSE,
                                         ...)
  
  # 6. Restructure data
  
  # Add id variable
  sim_data_model_ids <- sim_data_model %>% 
    dplyr::as_tibble() %>% 
    dplyr::mutate(id = 1:sample.nobs) %>% 
    dplyr::select(id, dplyr::everything()) 
  
  # Add missing values
  var_names <- names(sim_data_model_ids)[-1]
  
  sim_data_model_ids_nas <- sim_data_model_ids %>%
    tidyr::gather(vars, value, -id) %>%
    dplyr::mutate(vars = base::factor(vars, levels = var_names)) %>% 
    dplyr::mutate(random_num = runif(nrow(.)),   
                  value = base::ifelse(vars %in% var_names & random_num <= na_pct, NA, value)) %>%
    dplyr::select(-random_num) %>%
    tidyr::spread(vars, value) 
  
  # 7. Return 
  if (return_lavaan_syntax == FALSE){
    # Return simulated data
    return(sim_data_model_ids_nas)
  } else if (return_lavaan_syntax == TRUE){
    
    if (return_lavaan_syntax_string == TRUE){
      return(model_estimates)
    } else if (return_lavaan_syntax_string == FALSE){
      # Return lavaan syntax used to simulate datq
      return(base::cat(model_estimates))
    }
    
  }
  
}


#' Simulate data from a univariate latent change score model
#'
#' @param timepoints See \link[lcstools]{specify_lavaan_bi_model}
#' @param model_x See \link[lcstools]{specify_lavaan_bi_model}
#' @param model_x_param List, specifying parameter estimates for the LCS model that has been specified in the argument '\code{model_x}':
#' \itemize{
#' \item{\strong{\code{gamma_lx1}}}: Mean of latent true scores x (Intercept),
#' \item{\strong{\code{sigma2_lx1}}}: Variance of latent true scores x,
#' \item{\strong{\code{sigma2_ux}}}: Variance of observed scores x,
#' \item{\strong{\code{alpha_g2}}}: Mean of change factor (g2),
#' \item{\strong{\code{alpha_g3}}}: Mean of change factor (g3),
#' \item{\strong{\code{sigma2_g2}}}: Variance of change factor (g2).
#' \item{\strong{\code{sigma2_g3}}}: Variance of change factor (g3),
#' \item{\strong{\code{sigma_g2lx1}}}: Covariance of change factor (g2) with the initial true score x (lx1),
#' \item{\strong{\code{sigma_g3lx1}}}: Covariance of change factor (g3) with the initial true score x (lx1),
#' \item{\strong{\code{sigma_g2g3}}}: Covariance of change factors (g2 and g2),
#' \item{\strong{\code{phi_x}}}: Autoregression of change scores x.
#' }
#' @param model_y See \link[lcstools]{specify_lavaan_bi_model}
#' @param model_y_param List, specifying parameter estimates for the LCS model that has been specified in the argument '\code{model_y}':
#' \itemize{
#' \item{\strong{\code{gamma_ly1}}}: Mean of latent true scores y (Intercept),
#' \item{\strong{\code{sigma2_ly1}}}: Variance of latent true scores y,
#' \item{\strong{\code{sigma2_uy}}}: Variance of observed scores y,
#' \item{\strong{\code{alpha_j2}}}: Mean of change factor (j2),
#' \item{\strong{\code{alpha_j3}}}: Mean of change factor (j3),
#' \item{\strong{\code{sigma2_j2}}}: Variance of change factor (j2).
#' \item{\strong{\code{sigma2_j3}}}: Variance of change factor (j3),
#' \item{\strong{\code{sigma_j2ly1}}}: Covariance of change factor (j2) with the initial true score x (ly1),
#' \item{\strong{\code{sigma_j3ly1}}}: Covariance of change factor (j3) with the initial true score x (ly1),
#' \item{\strong{\code{sigma_j2j3}}}: Covariance of change factors (j2 and j2),
#' \item{\strong{\code{phi_y}}}: Autoregression of change scores y.
#' }
#' @param coupling See \link[lcstools]{specify_lavaan_bi_model}
#' @param coupling_param List, specifying parameter estimates coupling parameters that have been specified in the argument '\code{coupling}':
#' \itemize{
#' \item{\strong{\code{sigma_su}}}: Covariance of residuals x and y,
#' \item{\strong{\code{sigma_ly1lx1}}}: Covariance of intercepts x and y,
#' \item{\strong{\code{sigma_g2ly1}}}: Covariance of change factor x (g2) with the initial true score y (ly1),
#' \item{\strong{\code{sigma_g3ly1}}}: Covariance of change factor x (g3) with the initial true score y (ly1),
#' \item{\strong{\code{sigma_j2lx1}}}: Covariance of change factor y (j2) with the initial true score x (lx1),
#' \item{\strong{\code{sigma_j3lx1}}}: Covariance of change factor y (j3) with the initial true score x (lx1),
#' \item{\strong{\code{sigma_j2g2}}}: Covariance of change factors y (j2) and x (g2),
#' \item{\strong{\code{sigma_j2g3}}}: Covariance of change factors y (j2) and x (g3),
#' \item{\strong{\code{sigma_j3g2}}}: Covariance of change factors y (j3) and x (g2),,
#' \item{\strong{\code{delta_con_xy}}}: Change score x (t) determined by true score y (t),
#' \item{\strong{\code{delta_con_yx}}}: Change score y (t) determined by true score x (t),
#' \item{\strong{\code{delta_lag_xy}}}: Change score x (t) determined by true score y (t-1),
#' \item{\strong{\code{delta_lag_yx}}}: Change score y (t) determined by true score x (t-1),
#' \item{\strong{\code{xi_con_xy}}}: Change score x (t) determined by change score y (t),
#' \item{\strong{\code{xi_con_yx}}}: Change score y (t) determined by change score x (t),
#' \item{\strong{\code{xi_lag_xy}}}: Change score x (t) determined by change score y (t-1),
#' \item{\strong{\code{xi_lag_yx}}}: Change score y (t) determined by change score x (t-1)
#' }
#' @param sample.nobs Numeric, number of cases to be simulated, see \link[lcstools]{specify_lavaan_uni_model}
#' @param na_x_pct Numeric, percentage of random missing values in the simulated dataset [0,1]
#' @param na_y_pct Numeric, percentage of random missing values in the simulated dataset [0,1]
#' @param ... Arguments to be passed on to \link[lavaan]{simulateData}
#' @param var_x See \link[lcstools]{specify_lavaan_bi_model}
#' @param var_y See \link[lcstools]{specify_lavaan_bi_model}
#' @param change_letter_x See \link[lcstools]{specify_lavaan_bi_model}
#' @param change_letter_y See \link[lcstools]{specify_lavaan_bi_model}
#' @param return_lavaan_syntax Logical, if TRUE return the lavaan syntax used for simulating data, looking beautiful using \link[base]{cat}
#' @param return_lavaan_syntax_string Logical, if return_lavaan_syntax == TRUE and return_lavaan_syntax_string == TRUE return the lavaan syntax as one ugly string
#'
#' @return
#' @export
#'
#' @examples
sim_bi_lcsm_data <- function(timepoints, 
                             model_x, model_x_param = NULL, 
                             model_y, model_y_param = NULL, 
                             coupling, coupling_param = NULL,
                             sample.nobs = 500, na_x_pct = 0, na_y_pct = 0, ...,
                             var_x = "x", var_y = "y", change_letter_x = "g", change_letter_y = "j", 
                             return_lavaan_syntax = FALSE, return_lavaan_syntax_string = FALSE){
  
  # 1. Create string object with lavaan syntax including labels for parameters
  model <- specify_lavaan_bi_model(timepoints = timepoints,
                                   var_x = var_x,
                                   model_x = model_x,
                                   var_y = var_y,
                                   model_y = model_y,
                                   coupling = coupling,
                                   change_letter_x = change_letter_x,
                                   change_letter_y = change_letter_y)
  
  # 2. Extract all labels from lavaan syntax using lavaan::lavaanify()
  labels <- lavaan::lavaanify(model) %>% 
    tibble::as_tibble() %>%
    dplyr::mutate(label = dplyr::na_if(label, ""),
                  label = base::factor(label)) %>% 
    dplyr::filter(is.na(label) == FALSE) %>% 
    dplyr::distinct(label) %>% 
    base::unlist()
  
  # 3. Enter values for all labels/estimates in lavaan syntax using base::readline()
  # Only if all _param arguemtnts are NULL ask for values using base::readline()
  if (base::is.null(model_x_param) == TRUE & base::is.null(model_y_param) == TRUE & base::is.null(coupling_param) == TRUE){
    base::message("Please enter the following parameter estimates for the data simulation:")
    
    # Create empty list
    estimates <- list()
    
    for (label_i in labels) {
      value <- base::readline(base::paste0("Enter value for ", label_i, ": "))
      estimates[label_i] <- base::as.numeric(value)
    }
    # If at least one _param argument has values dont ask for other values
    # THis could be improved to be spcific for each model an coupling parameters maybe
  } else if (base::is.null(model_x_param) == FALSE | base::is.null(model_y_param) == FALSE | base::is.null(coupling_param) == FALSE){
    base::message("Parameter estimates for the data simulation are taken from the argument 'model_param'.")
    # If argument model_param is specified, use this to simulate data
    # Combine all model parameters
    model_param <- c(model_x_param, model_y_param, coupling_param)
    
    # Create vector indicating which labels have been specified in model_param
    check_labels <- labels %in% base::names(model_param)
    
    # Test if all labels have been specified
    if (base::all(check_labels) == TRUE){
      base::message("All parameter estimates for the LCS model have been specified in the argument 'model_param'.")
    } else if (base::all(check_labels) == FALSE){
      
      missing_labels <- labels[base::which(!check_labels)]
      
      missing_labels_01 <- paste("- ", missing_labels)
      
      missing_labels_02 <- stringr::str_c(missing_labels_01, sep = "", collapse = "\n")
      
      base::warning(paste0("The following parameters are specified in LCS model but no parameter estimates have been entered in 'model_param':\n", missing_labels_02), call. = FALSE)
    }
    
    estimates <- model_param
  }
  
  # 4. Replace all labels in lavaan syntax with values entered above
  
  # Create new object with lavaan model, this still has labels and not values
  model_estimates <- model
  
  # Loop through all estimates and replacve with values that have been specified
  for (estimate_i in seq_along(estimates)) {
    model_estimates <- stringr::str_replace_all(model_estimates, names(estimates[estimate_i]), as.character(estimates[estimate_i])) 
  }
  
  # 5. Simulate data using lavaan::simulateData()
  sim_data_model <- lavaan::simulateData(model = model_estimates, 
                                         model.type = "sem", 
                                         meanstructure = 'default', 
                                         int.ov.free = TRUE, 
                                         int.lv.free = FALSE, 
                                         conditional.x = TRUE,
                                         fixed.x = FALSE, 
                                         orthogonal = FALSE, 
                                         std.lv = TRUE, 
                                         auto.fix.first = FALSE, 
                                         auto.fix.single = FALSE, 
                                         auto.var = TRUE, 
                                         auto.cov.lv.x = TRUE, 
                                         auto.cov.y = TRUE, 
                                         sample.nobs = sample.nobs, 
                                         ov.var = NULL, 
                                         group.label = paste("G", 1:ngroups, sep = ""), 
                                         skewness = 0, 
                                         kurtosis = 0, 
                                         seed = NULL, 
                                         empirical = FALSE, 
                                         return.type = "data.frame",
                                         return.fit = FALSE,
                                         debug = FALSE, 
                                         standardized = FALSE,
                                         ...)
  
  # 6. Restructure data
  # Add id variable
  sim_data_model_ids <- sim_data_model %>% 
    dplyr::as_tibble() %>% 
    dplyr::mutate(id = 1:sample.nobs) %>% 
    dplyr::select(id, dplyr::everything()) 
  
  # Add missing values
  
  # # Get list with variable names for each constrct
  var_names_x <- names(sim_data_model_ids)[2:(timepoints + 1)]
  var_names_y <- names(sim_data_model_ids)[(timepoints + 2):length(names(sim_data_model_ids))]

  # Select data for each construct
  # Introduce NAs seperately for each construcht

  # x ----
  sim_data_x_model_ids <- sim_data_model_ids %>%
    dplyr::select(id, var_names_x)

  sim_data_x_model_ids_nas <- sim_data_x_model_ids %>%
    tidyr::gather(vars, value, -id) %>%
    dplyr::mutate(vars = base::factor(vars, levels = var_names_x)) %>%
    dplyr::mutate(random_num = runif(nrow(.)),
                  value = base::ifelse(vars %in% var_names_x & random_num <= na_x_pct, NA, value)) %>%
    dplyr::select(-random_num) %>%
    tidyr::spread(vars, value)

  # y ----
  sim_data_y_model_ids <- sim_data_model_ids %>%
    dplyr::select(id, var_names_y)

  sim_data_y_model_ids_nas <- sim_data_y_model_ids %>%
    tidyr::gather(vars, value, -id) %>%
    dplyr::mutate(vars = base::factor(vars, levels = var_names_y)) %>%
    dplyr::mutate(random_num = runif(nrow(.)),
                  value = base::ifelse(vars %in% var_names_y & random_num <= na_y_pct, NA, value)) %>%
    dplyr::select(-random_num) %>%
    tidyr::spread(vars, value)

  # Join x and y data

  sim_data_xy_model_ids_nas <- sim_data_x_model_ids_nas %>%
    dplyr::left_join(sim_data_y_model_ids_nas, by = "id")



  # 7. Return
  if (return_lavaan_syntax == FALSE){
    # Return simulated data
    return(sim_data_xy_model_ids_nas)
  } else if (return_lavaan_syntax == TRUE){

    if (return_lavaan_syntax_string == TRUE){
      return(model_estimates)
    } else if (return_lavaan_syntax_string == FALSE){
      # Return lavaan syntax used to simulate datq
      return(base::cat(model_estimates))
    }
  }
}