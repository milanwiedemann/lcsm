#' Simulate data from a univariate latent change score model
#'
#' @param timepoints See \link[lcstools]{specify_lavaan_uni_model}
#' @param var See \link[lcstools]{specify_lavaan_uni_model}
#' @param model See \link[lcstools]{specify_lavaan_uni_model}
#' @param change_letter See \link[lcstools]{specify_lavaan_uni_model}
#' @param lavaan_uni_model String, lavaan model syntax with "labals" for parameters
#' @param uni_model_param Placeholder, this might become an option where to scpecify parameter estimates
#' @param ... Arguments to be passed on to \link[lavaan]{simulateData}
#' @return
#' @export
#'
#' @examples
sim_uni_lcsm_data <- function(timepoints, model, var = "x", change_letter = "j", sample.nobs = 500, ..., lavaan_uni_model = NULL, uni_model_param = NULL){
  
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
  
  # Create empty list
  estimates <- list()
  
  for (label_i in labels) {
    value <- base::readline(base::paste0("Enter value for ", label_i, ": "))
    estimates[label_i] <- base::as.numeric(value)
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
                                         standardized = FALSE)
  
  # 6. Restructure data
  sim_data_model_return <- sim_data_model %>% 
    dplyr::as_tibble() %>% 
    dplyr::mutate(id = 1:sample.nobs) %>% 
    dplyr::select(id, dplyr::everything()) 
  
  # 7. Return data
  return(sim_data_model_return)
}


# 



# 
# model <- specify_lavaan_uni_model(timepoints = 5,
#                                   var = "x",
#                                   model = list(alpha_constant = T, beta = T, phi = T),
#                                   change_letter = "j")

# Look at model
# cat(model)

# get all labels from model
# labels <- lavaan::lavaanify(model) %>% 
#   as_tibble() %>%
#   mutate(label = na_if(label, ""),
#          label = factor(label)) %>% 
#   filter(is.na(label) == FALSE) %>% 
#   distinct(label) %>% 
#   unlist()

# # Look at all labels
# labels
# 
# # Create empty list
# estimates <- list()

# Loop through labels and ask for value
# I dont want to use anything like seq along here or so to get the real labels and not numbers
# for (label_i in labels) {
#   value <- base::readline(base::paste0("Enter value for ", label_i, ": "))
#   estimates[label_i] <- base::as.numeric(value)
# }

# estimates
# 
# # Create empoty model
# model_estimates <- model
# 
# cat(model_estimates)
# 
# # Replace all estimates now
# for (estimate_i in seq_along(estimates)) {
#   model_estimates <- stringr::str_replace_all(model_estimates, names(estimates[estimate_i]), as.character(estimates[estimate_i])) 
# }

# cat(model_estimates)


# 
# sim_data_model <- lavaan::simulateData(model = model_estimates, 
#                                        model.type = "sem", 
#                                        meanstructure = 'default', 
#                                        int.ov.free = TRUE, 
#                                        int.lv.free = FALSE, 
#                                        conditional.x = TRUE,
#                                        fixed.x = FALSE, 
#                                        orthogonal = FALSE, 
#                                        std.lv = TRUE, 
#                                        auto.fix.first = FALSE, 
#                                        auto.fix.single = FALSE, 
#                                        auto.var = TRUE, 
#                                        auto.cov.lv.x = TRUE, 
#                                        auto.cov.y = TRUE, 
#                                        sample.nobs = 100, 
#                                        ov.var = NULL, 
#                                        group.label = paste("G", 1:ngroups, sep = ""), 
#                                        skewness = 0, 
#                                        kurtosis = 0, 
#                                        seed = NULL, 
#                                        empirical = FALSE, 
#                                        return.type = "data.frame",
#                                        return.fit = FALSE,
#                                        debug = FALSE, 
#                                        standardized = FALSE) %>% 
#   as_tibble() %>% 
#   mutate(id = 1:100) %>% 
#   select(id, everything()) 
# 
# 
# plot_trajectories(data = sim_data_model, 
#                   id_var = "id", 
#                   var_list = colnames(sim_data_model)[-1])
# 
# fit_model <- fit_uni_lcsm(data = sim_data_model,
#                           var = colnames(sim_data_model)[-1], 
#                           model = list(alpha_constant = TRUE, beta = TRUE, phi = TRUE))
# 
# extract_param(fit_model)
# 
# 
# 
# 
# 
# 
# 


















#  Hier das ganze nochmal fuer bivar lcs
# 
# sim_bi_lcsm_data <- function(lavaan_bi_model, bi_model_param){
#   
# }