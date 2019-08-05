#' Select cases based on minimum number of available session scores on one longitudinal measure
#'
#' @param data  TODO
#' @param id_var  TODO
#' @param var_list  TODO
#' @param min_count  TODO
#' @param return_id_only  TODO
#'
#' @return tibble
#' @export
#' @examples
#' 

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
  return(data_export)
}

#' Select cases based on minimum number of available session scores on two longitudinal measures
#' @description TODO: Describe function
#' @param data  TODO
#' @param id_var  TODO
#' @param var_list_x  TODO
#' @param var_list_y  TODO
#' @param min_count_x  TODO
#' @param min_count_y  TODO
#'
#' @return tibble
#' @export
#' @examples

select_bi_cases <- function(data, id_var, var_list_x, var_list_y, min_count_x, min_count_y) {
  
  # Select cases from x and return id only
  id_select_x <- select_uni_cases(data = data,
                                        id_var =  id_var,
                                        var_list = var_list_x,
                                        min_count = min_count_x,
                                        return_id_only = TRUE)
  
  # Select cases from y and return id only
  id_select_y <- select_uni_cases(data = data,
                                        id_var =  id_var,
                                        var_list = var_list_y,
                                        min_count = min_count_y,
                                        return_id_only = TRUE)
  
  # Select ids where criterion of min count is met for x and y
  id_select_xy <- dplyr::inner_join(id_select_x, id_select_y, by = id_var)
  
  # Return data for cases where both criterions are met
  dplyr::left_join(id_select_xy, data, by = id_var)
}
