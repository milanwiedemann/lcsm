#' Select cases based on minimum number of available session scores for one set of variables
#'
#' @param data  TODO
#' @param id_var  TODO
#' @param var_list  TODO
#' @param min_count  TODO
#' @param return_id_only  TODO
#'
#' @return TODO
#' @export
#'
#' @examples TODO
select_uni_cases <- function(data, id_var, var_list, min_count, return_id_only = FALSE) {
  
  var_count <- base::length(var_list)
  
  # Move id variable to beginning of dataset
  data_select <- dplyr::select(data, c(id_var, var_list))
  
  # Count available datapoints
  data_select$count <- base::apply(data_select[ , 2:(var_count + 1)], 1, function(x) sum(!is.na(x)))
  
  # Select cases with greater or equal number specified in function
  data_export <- dplyr::filter(data_select, count >= min_count)
  
  # Delete count from dataframe
  if (return_id_only == FALSE) {
    data_export <- base::subset(data_export, select = -count)
  }
  
  if (return_id_only == TRUE) {
    data_export <- base::subset(data_export, select = id)
  }
  
  data_export
  
}