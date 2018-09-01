#' Extract labeled parameters of lavaan objects
#'
#' @param lavaan_object Lavaan object.

#' @return This function returns a tibble with labeled parameters.
#' @export

extract_param <- function(lavaan_fit){
  # Get tidy output tibble from lavaan fit object
  table <- broom::tidy(lavaan_fit)

  # Replace empty stings with NA
  table[table == ""] <- NA

  # Remove all rows with NA in label column
  # Parameters that should be extracted need to be labelled in the lavaan model specifications
  # If parameters are not labelled they will get deleted from the summary at this step
  table2 <- table[(complete.cases(table$label)), 3:ncol(table)]

  # Delete rows with duplicate labels
  table3 <- table2[!duplicated(table2$label), ]

  # Output
  table3
}
