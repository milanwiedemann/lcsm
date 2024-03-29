% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/select_cases.R
\name{select_uni_cases}
\alias{select_uni_cases}
\title{Select cases based on minimum number of available session scores on one longitudinal measure}
\usage{
select_uni_cases(data, id_var, var_list, min_count, return_id_only = FALSE)
}
\arguments{
\item{data}{Dataset in wide format.}

\item{id_var}{String, specifying id variable.}

\item{var_list}{Vector, specifying variable names in sequential order.}

\item{min_count}{Numeric, specifying minimum number of available scores}

\item{return_id_only}{Logical, if TRUE only return ID. This is needed for select_bi_cases}
}
\value{
tibble
}
\description{
Select cases based on minimum number of available session scores on one longitudinal measure
}
\examples{
select_uni_cases(data_uni_lcsm,
  id_var = "id",
  var_list = names(data_uni_lcsm)[-1],
  min_count = 7
)

}
