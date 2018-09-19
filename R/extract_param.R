#' Extract labeled parameters of lavaan objects
#'
#' @param lavaan_fit Lavaan object.
#' @param printp If TRUE convert into easily readable p-values.

#' @return This function returns a tibble with labeled parameters.
#' @export

extract_param <- function(lavaan_fit, printp = FALSE){
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

  if (printp == FALSE){
    return(table3)
  }
  
  if (printp == TRUE){
    table4 <- mutate(table3, p.value = papaja::printp(p.value))
    return(table4)
  }
  

  }
