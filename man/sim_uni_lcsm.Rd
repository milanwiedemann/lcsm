% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sim_lcsm_data.R
\name{sim_uni_lcsm}
\alias{sim_uni_lcsm}
\title{Simulate data from univariate latent change score model parameter estimates}
\usage{
sim_uni_lcsm(
  timepoints,
  model,
  model_param = NULL,
  var = "x",
  change_letter = "g",
  sample.nobs = 500,
  na_pct = 0,
  seed = NULL,
  ...,
  return_lavaan_syntax = FALSE
)
}
\arguments{
\item{timepoints}{See \link[lcsm]{specify_uni_lcsm}}

\item{model}{See \link[lcsm]{specify_uni_lcsm}}

\item{model_param}{List, specifying parameter estimates for the LCSM that has been specified in the argument 'model'
\itemize{
\item{\strong{\code{gamma_lx1}}}: Mean of latent true scores x (Intercept),
\item{\strong{\code{sigma2_lx1}}}: Variance of latent true scores x,
\item{\strong{\code{sigma2_ux}}}: Variance of observed scores x,
\item{\strong{\code{alpha_g2}}}: Mean of change factor (g2),
\item{\strong{\code{alpha_g3}}}: Mean of change factor (g3),
\item{\strong{\code{sigma2_g2}}}: Variance of constant change factor (g2).
\item{\strong{\code{sigma2_g3}}}: Variance of constant change factor (g3),
\item{\strong{\code{sigma_g2lx1}}}: Covariance of constant change factor (g2) with the initial true score x (lx1),
\item{\strong{\code{sigma_g3lx1}}}: Covariance of constant change factor (g3) with the initial true score x (lx1),
\item{\strong{\code{sigma_g2g3}}}: Covariance of change factors (g2 and g2),
\item{\strong{\code{phi_x}}}: Autoregression of change scores x.
}}

\item{var}{See \link[lcsm]{specify_uni_lcsm}}

\item{change_letter}{See \link[lcsm]{specify_uni_lcsm}}

\item{sample.nobs}{Numeric, number of cases to be simulated, see \link[lcsm]{specify_uni_lcsm}}

\item{na_pct}{Numeric, percentage of random missing values in the simulated dataset (0 to 1)}

\item{seed}{Set seed for data simulation, see \link[lavaan]{simulateData}}

\item{...}{Arguments to be passed on to \link[lavaan]{simulateData}}

\item{return_lavaan_syntax}{Logical, if TRUE return the lavaan syntax used for simulating data. To make it look beautiful use the function \link[base]{cat}.}
}
\value{
tibble
}
\description{
This function simulate data from univariate latent change score model parameter estimates using \link[lavaan]{simulateData}.
}
\examples{
# Simulate data from univariate LCSM parameters 
sim_uni_lcsm(timepoints = 10, 
             model = list(alpha_constant = TRUE, beta = FALSE, phi = TRUE), 
             model_param = list(gamma_lx1 = 21, 
                                sigma2_lx1 = 1.5,
                                sigma2_ux = .2, 
                                alpha_g2 = -.93,
                                sigma2_g2 = .1,
                                sigma_g2lx1 = .2,
                                phi_x = .2),
             return_lavaan_syntax = FALSE, 
             sample.nobs = 1000,
             na_pct = .3)

}
