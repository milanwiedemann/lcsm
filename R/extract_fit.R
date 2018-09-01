#' Extract fit statistics of lavaan objects
#'
#' @param lavaan_object Lavaan object.

#' @return This function returns a tibble.
#' @export

extract_fit <- function(lavaan_object) {
  broom::glance(lavaan_object)
}
