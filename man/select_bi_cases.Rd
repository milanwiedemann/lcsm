% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/select_cases.R
\name{select_bi_cases}
\alias{select_bi_cases}
\title{Select cases based on minimum number of available session scores on two longitudinal measures}
\usage{
select_bi_cases(data, id_var, var_list_x, var_list_y, min_count_x, min_count_y)
}
\arguments{
\item{data}{A data frame in "wide" format, i.e. one column for each measurement point and one row for each observation.}

\item{id_var}{String, specifying id variable.}

\item{var_list_x}{Vector, specifying variable names of construct X in sequential order.}

\item{var_list_y}{Vector, specifying variable names of construct Y in sequential order.}

\item{min_count_x}{Numeric, specifying minimum number of available scores for construct X.}

\item{min_count_y}{Numeric, specifying minimum number of available scores for construct Y.}
}
\value{
tibble
}
\description{
Select cases based on minimum number of available session scores on two longitudinal measures
}
\examples{
select_bi_cases(data_bi_lcsm,
  id_var = "id",
  var_list_x = names(data_bi_lcsm)[2:11],
  var_list_y = names(data_bi_lcsm)[12:21],
  min_count_x = 7,
  min_count_y = 7
)

}
