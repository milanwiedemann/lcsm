#' Extract labeled parameters of lavaan objects
#'
#' @param lavaan_object Lavaan object.
#' @param printp If TRUE convert into easily readable p-values.
#' At the moment this function is deactivated, a warning message will be returned.

#' @return This function returns a tibble with labeled parameters.
#' @export
#' @examples

extract_param <- function(lavaan_object, printp = FALSE){
  # Get tidy output tibble from lavaan fit object
  table <- broom::tidy(lavaan_object)

  # Replace empty stings with NA
  table[table == ""] <- NA

  # Remove all rows with NA in label column
  # Parameters that should be extracted need to be labelled in the lavaan model specifications
  # If parameters are not labelled they will get deleted from the summary at this step
  table2 <- table[(stats::complete.cases(table$label)), 3:ncol(table)]

  # Delete rows with duplicate labels
  table3 <- table2[!base::duplicated(table2$label), ]

  if (printp == FALSE){
    return(table3)
  }
  
  if (printp == TRUE){
    # This doesnt work at the moment, papaja is not on CRAN 
    # Find my own way to do this, maybe import printp function from papaja or somewhere else
    # table4 <- dplyr::mutate(table3, p.value = papaja::printp(p.value))
    # return(table4)
    
    # for now also return table 3
    message("Sorry, the 'printp' argument is not supported at the moment.\nThis returns the same object as using 'printp = FALSE'.")
    return(table3)
  }
  

  }
