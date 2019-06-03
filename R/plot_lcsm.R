#' Plot latent change score model path diagram
#'
#' @param lavaan_object lavaan object.
#' @param layout Matrix specifying location of manifest and latent variables. 
#' @param what See \code{semPlot}.
#' @param whatLabels see \code{semPlot}.
#' @param edge.width see \code{semPlot}.
#' @param node.width  see \code{semPlot}.
#' @param border.width  see \code{semPlot}.
#' @param fixedStyle  see \code{semPlot}.
#' @param freeStyle  see \code{semPlot}.
#' @param residuals  see \code{semPlot}.
#' @param label.scale  see \code{semPlot}.
#' @param sizeMan  see \code{semPlot}.
#' @param sizeLat  see \code{semPlot}.
#' @param intercepts  see \code{semPlot}.
#' @param fade  see \code{semPlot}.
#' @param nCharNodes  see \code{semPlot}.
#' @param curve_covar  see \code{semPlot}.
#' @param edge.label.cex  see \code{semPlot}.
#' @param nCharEdges  see \code{semPlot}.
#' @param DoNotPlot  see \code{semPlot}
#' @param ... Other functions passed on to \code{semPlot}.  
#'
#' @return Plot
#' @export 
#'

plot_lcsm <- function(lavaan_object,
                      layout = NULL,
                      lavaan_syntax = NULL,
                      lcsm = c("univariate", "bivariate"),
                      curve_covar = .5,
                      what = "col",
                      whatLabels = "est",
                      edge.width = 1,
                      node.width = 1,
                      border.width = 1,
                      fixedStyle = 1,
                      freeStyle = 1,
                      residuals = FALSE,
                      label.scale = FALSE,
                      sizeMan = 3,
                      sizeLat = 5,
                      intercepts = FALSE,
                      fade = FALSE,
                      nCharNodes = 0,
                      nCharEdges = 0,
                      edge.label.cex = 0.5,
                      DoNotPlot = TRUE,
                      ...) {
  
  if (is.null(layout) == TRUE) {
    
    # Extract info for layout matrix from lavaan 
    
    # Construct x
    
    row_x_mani_vars_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>%
      dplyr::as_tibble() %>% 
      dplyr::filter(str_detect(rhs, "^x\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    timepoints <- length(row_x_mani_vars_lavaanify)
    
    row_x_latent_vars_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(str_detect(rhs, "^lx\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_x_change_scores_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(str_detect(rhs, "^dx\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_x_change_factors_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(str_detect(rhs, "^g\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    change_factors_x_freq <- length(row_x_change_factors_lavaanify)
    
    # Construct Y
    
    row_y_mani_vars_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>%
      dplyr::as_tibble() %>% 
      dplyr::filter(str_detect(rhs, "^y\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_y_latent_vars_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(str_detect(rhs, "^ly\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_y_change_scores_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(str_detect(rhs, "^dy\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_y_change_factors_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(str_detect(rhs, "^j\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    change_factors_y_freq <- length(row_y_change_factors_lavaanify)
    
    # Create layout matrix 
    
    if  (lcsm == "univariate") {
      # Create univariate layoiut matrix
      
      row_x_mani_vars_layout <- row_x_mani_vars_lavaanify
      row_x_latent_vars_layout <- row_x_latent_vars_lavaanify
      row_x_change_scores_layout <- c(NA, row_x_change_scores_lavaanify)
      row_x_change_factors_layout <- c(NA, row_x_change_factors_lavaanify, rep(NA, timepoints - 1 - change_factors_freq))
      
      layout <- base::matrix(c(row_x_change_factors_layout, 
                     row_x_change_scores_layout,
                     row_x_latent_vars_layout,
                     row_x_mani_vars_layout),
                   ncol = timepoints,
                   nrow = 4,
                   byrow = TRUE)
      
      
    } else if (lcsm == "bivariate") {
      # Create bivariate layoiut matrix
      
      # Create bivariate layout matrix
      row_x_mani_vars_layout <- c(NA, NA, row_x_mani_vars_lavaanify)
      row_x_latent_vars_layout <- c(NA, NA, row_x_latent_vars_lavaanify)
      row_x_change_scores_layout <- c(NA, NA, NA, row_x_change_scores_lavaanify)
      row_x_change_factors_layout <- c(NA, row_x_change_factors_lavaanify, rep(NA, timepoints + 1 - change_factors_x_freq))
      
      
      row_y_mani_vars_layout <- c(NA, NA, row_y_mani_vars_lavaanify)
      row_y_latent_vars_layout <- c(NA, NA, row_y_latent_vars_lavaanify)
      row_y_change_scores_layout <- c(NA, NA, NA, row_y_change_scores_lavaanify)
      row_y_change_factors_layout <- c(NA, row_y_change_factors_lavaanify, rep(NA, timepoints + 1 - change_factors_y_freq))
      
      layout <- base::matrix(c(row_y_mani_vars_layout, 
                     row_y_latent_vars_layout,
                     row_y_change_scores_layout,
                     row_y_change_factors_layout,
                     row_x_change_factors_layout, 
                     row_x_change_scores_layout,
                     row_x_latent_vars_layout,
                     row_x_mani_vars_layout),
                   ncol = timepoints + 2,
                   nrow = 8,
                   byrow = TRUE)
      
    }
    
    
  } else if (is.null(layout) == FALSE) {
    
    graph <- semPlot::semPaths(
      object = lavaan_object,
      layout = layout,
      what = what,
      whatLabels = whatLabels,
      edge.width = edge.width,
      node.width = node.width,
      border.width = border.width,
      fixedStyle = fixedStyle,
      freeStyle = freeStyle,
      residuals = residuals,
      label.scale = label.scale,
      sizeMan = sizeMan,
      sizeLat = sizeLat,
      intercepts = intercepts,
      fade = fade,
      nCharNodes = 0,
      nCharEdges = 0,
      DoNotPlot = DoNotPlot,
      ...)
    
    # aww where did I get this from, must have googled it
    graph$graphAttributes$Edges$curve <- ifelse(graph$Edgelist$bidir, curve_covar, 0)
    
    # Create plot
    plot(graph)
    
  }
  
  
}

