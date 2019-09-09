#' Plot simplified path diagram of univariate and bivariate latent change score models 
#'
#' @param lavaan_object Lavaan object of univariate or bivariate LCS model.
#' @param lavaan_syntax String, lavaan syntax of the lavaan object specified in \code{lavaan_object}.
#' If \code{lavaan_syntax} is provided a layout matrix will be generated automatically.
#' @param layout Matrix, specifying number and location of manifest and latent variables of LCS model specified in  \code{lavaan_object}.
#' @param return_layout_from_lavaan_syntax Logical, if TRUE and \code{lavaan_syntax} is provided, the layout matrix generated for \code{semPlot} will be returned for inspection of further customisation.
#' @param lcsm String, specifying whether lavaan_object represent a "univariate" or "bivariate" LCS model.
#' @param what See \code{semPlot}.
#' @param whatLabels See \link[semPlot]{semPaths}.
#' @param edge.width See \link[semPlot]{semPaths}.
#' @param node.width  See \link[semPlot]{semPaths}.
#' @param border.width See \link[semPlot]{semPaths}.
#' @param fixedStyle See \link[semPlot]{semPaths}.
#' @param freeStyle See \link[semPlot]{semPaths}.
#' @param residuals See \link[semPlot]{semPaths}.
#' @param label.scale See \link[semPlot]{semPaths}.
#' @param sizeMan See \link[semPlot]{semPaths}.
#' @param sizeLat See \link[semPlot]{semPaths}.
#' @param intercepts See \link[semPlot]{semPaths}.
#' @param fade See \link[semPlot]{semPaths}.
#' @param nCharNodes See \link[semPlot]{semPaths}.
#' @param curve_covar See \link[semPlot]{semPaths}.
#' @param edge.label.cex See \link[semPlot]{semPaths}.
#' @param nCharEdges See \link[semPlot]{semPaths}.
#' @param ... Other arguments passed on to \link[semPlot]{semPaths}.
#' @references Sacha Epskamp (2019). semPlot: Path Diagrams and Visual Analysis of Various SEM Packages' Output. R package version 1.1.1.
#' \url{https://CRAN.R-project.org/package=semPlot}
#' @return Plot
#' @export 
#'

plot_lcsm <- function(lavaan_object,
                      layout = NULL,
                      lavaan_syntax = NULL,
                      return_layout_from_lavaan_syntax = FALSE,
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
                      # DoNotPlot = TRUE,
                      ...) {
  
  if (is.null(layout) == TRUE) {
    
    # Extract info for layout matrix from lavaan 
    
    # Construct x
    
    row_x_mani_vars_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>%
      dplyr::as_tibble() %>% 
      dplyr::filter(stringr::str_detect(rhs, "^x\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    timepoints_x <- base::length(row_x_mani_vars_lavaanify)
    
    row_x_latent_vars_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(stringr::str_detect(rhs, "^lx\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_x_change_scores_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(stringr::str_detect(rhs, "^dx\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_x_change_factors_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(stringr::str_detect(rhs, "^g\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    change_factors_x_num <- length(row_x_change_factors_lavaanify)
    
    # Construct Y
    
    row_y_mani_vars_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>%
      dplyr::as_tibble() %>% 
      dplyr::filter(stringr::str_detect(rhs, "^y\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    timepoints_y <- base::length(row_y_mani_vars_lavaanify)
    
    row_y_latent_vars_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(stringr::str_detect(rhs, "^ly\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_y_change_scores_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(stringr::str_detect(rhs, "^dy\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    row_y_change_factors_lavaanify <- lavaan::lavaanify(lavaan_syntax) %>% 
      dplyr::as_tibble() %>% 
      dplyr::filter(stringr::str_detect(rhs, "^j\\d")) %>% 
      dplyr::select(rhs) %>% 
      dplyr::distinct() %>% 
      dplyr::pull()
    
    change_factors_y_num <- length(row_y_change_factors_lavaanify)
    
    # Create layout matrix 
    
    if  (lcsm == "univariate") {
      # Create univariate layoiut matrix
      
      row_x_mani_vars_layout <- row_x_mani_vars_lavaanify
      row_x_latent_vars_layout <- row_x_latent_vars_lavaanify
      row_x_change_scores_layout <- c(NA, row_x_change_scores_lavaanify)
      row_x_change_factors_layout <- c(NA, row_x_change_factors_lavaanify, rep(NA, timepoints_x - 1 - change_factors_x_num))
      
      layout_from_lavaan_syntax <- base::matrix(c(row_x_change_factors_layout, 
                                                  row_x_change_scores_layout,
                                                  row_x_latent_vars_layout,
                                                  row_x_mani_vars_layout),
                                                ncol = timepoints_x,
                                                nrow = 4,
                                                byrow = TRUE)
      
      
    } else if (lcsm == "bivariate") {
      # Create bivariate layoiut matrix
      
      # Create bivariate layout matrix
      row_x_mani_vars_layout <- c(NA, NA, row_x_mani_vars_lavaanify)
      row_x_latent_vars_layout <- c(NA, NA, row_x_latent_vars_lavaanify)
      row_x_change_scores_layout <- c(NA, NA, NA, row_x_change_scores_lavaanify)
      row_x_change_factors_layout <- c(NA, row_x_change_factors_lavaanify, rep(NA, timepoints_x + 1 - change_factors_x_num))
      
      
      row_y_mani_vars_layout <- c(NA, NA, row_y_mani_vars_lavaanify)
      row_y_latent_vars_layout <- c(NA, NA, row_y_latent_vars_lavaanify)
      row_y_change_scores_layout <- c(NA, NA, NA, row_y_change_scores_lavaanify)
      row_y_change_factors_layout <- c(NA, row_y_change_factors_lavaanify, rep(NA, timepoints_y + 1 - change_factors_y_num))
      
      layout_from_lavaan_syntax <- base::matrix(c(row_y_mani_vars_layout, 
                                                  row_y_latent_vars_layout,
                                                  row_y_change_scores_layout,
                                                  row_y_change_factors_layout,
                                                  row_x_change_factors_layout, 
                                                  row_x_change_scores_layout,
                                                  row_x_latent_vars_layout,
                                                  row_x_mani_vars_layout),
                                                ncol = timepoints_x + 2,
                                                nrow = 8,
                                                byrow = TRUE)
      
    }
    
    if (return_layout_from_lavaan_syntax == TRUE){
      return(layout_from_lavaan_syntax)
    } else if (return_layout_from_lavaan_syntax == FALSE) {
      graph <- semPlot::semPaths(
        object = lavaan_object,
        layout = layout_from_lavaan_syntax,
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
        edge.label.cex = edge.label.cex,
        DoNotPlot = TRUE,
        ...)
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
      edge.label.cex = edge.label.cex,
      DoNotPlot = TRUE,
      ...)
  }
  
  
  # aww where did I get this from, must have googled it
  graph$graphAttributes$Edges$curve <- ifelse(graph$Edgelist$bidir, curve_covar, 0)
  
  # Create plot
  plot(graph)
  
}

