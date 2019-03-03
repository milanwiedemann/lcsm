#' Select cases based on minimum number of available session scores for two sets of variables
#'
#' @param data  TODO
#' @param id_var  TODO
#' @param var_list_x  TODO
#' @param var_list_y  TODO
#' @param min_count_x  TODO
#' @param min_count_y  TODO
#'
#' @return TODO
#' @export

select_bi_cases <- function(data, id_var, var_list_x, var_list_y, min_count_x, min_count_y) {
  
  # Select cases from x and return id only
  id_select_x <- lcsm::select_uni_cases(data = data,
                                  id_var =  id_var,
                                  var_list = var_list_x,
                                  min_count = min_count_x,
                                  return_id_only = TRUE)
  
  # Select cases from y and return id only
  id_select_y <- lcsm::select_uni_cases(data = data,
                                  id_var =  id_var,
                                  var_list = var_list_y,
                                  min_count = min_count_y,
                                  return_id_only = TRUE)
  
  # Select ids where criterion of min count is met for x and y
  id_select_xy <- dplyr::inner_join(id_select_x, id_select_y, by = id_var)
  
  # Return data for cases where both criterions are met
  dplyr::left_join(id_select_xy, data, by = id_var)
  
}
