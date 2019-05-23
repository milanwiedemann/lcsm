#' Simulate data from a univariate latent change score model
#'
#' @param timepoints See \link[lcstools]{specify_lavaan_uni_model}
#' @param var See \link[lcstools]{specify_lavaan_uni_model}
#' @param model See \link[lcstools]{specify_lavaan_uni_model}
#' @param change_letter See \link[lcstools]{specify_lavaan_uni_model}
#' @param sample.nobs Numeric, number of cases to be simulated, see \link[lcstools]{specify_lavaan_uni_model}
#' @param na_pct = Numeric, percentage of random missing values in the simulated dataset [0,1]
#' @param lavaan_uni_model String, lavaan model syntax with "labals" for parameters
#' @param model_param String, lavaan model syntax with "labals" for parameters
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
    tidyr::gather(var, value, -id) %>%
    dplyr::mutate(var = base::factor(var, levels = var_names)) %>% 
    dplyr::mutate(random_num = runif(nrow(.)),   
                  value = base::ifelse(var %in% var_names & random_num <= na_pct, NA, value)) %>%
    dplyr::select(-random_num) %>%
    tidyr::spread(var, value) 
  
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


#  Boah ey, und jetzt das ganze nochmal fuer bivar lcs ... puhh erstmal essen jetzt
# 
# sim_bi_lcsm_data <- function(lavaan_bi_model, bi_model_param){
#   
# }