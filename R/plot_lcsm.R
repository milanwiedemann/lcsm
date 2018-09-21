#' Plot latent change score model path diagram
#'
#' @param object 
#' @param layout 
#' @param what See \code{semPlot}
#' @param whatLabels 
#' @param edge.width 
#' @param node.width 
#' @param border.width 
#' @param fixedStyle 
#' @param freeStyle 
#' @param residuals 
#' @param label.scale 
#' @param sizeMan 
#' @param sizeLat 
#' @param intercepts 
#' @param fade 
#' @param nCharNodes 
#' @param nCharEdges 
#'
#' @return Plot
#' @export 
#'
#' @examples TODO
plot_lcsm <- function(object,
                      layout,
                      what = "col",
                      whatLabels = "est",
                      edge.width = 1,
                      node.width = 1,
                      border.width = 1,
                      fixedStyle=1,
                      freeStyle=1,
                      residuals = FALSE,
                      label.scale=FALSE,
                      sizeMan = 5,
                      sizeLat = 5,
                      intercepts = FALSE,
                      fade = FALSE,
                      nCharNodes = 0,
                      nCharEdges = 0) {
  
  
  graph <- semPlot::semPaths(fit_lavaan_uni3,
           what = what,
           layout = layout,
           whatLabels = whatLabels,
           edge.width = edge.width,
           node.width = node.width,
           border.width = border.width,
           fixedStyle=fixedStyle,
           freeStyle=freeStyle,
           residuals = residuals,
           label.scale=label.scale,
           sizeMan = sizeMan,
           sizeLat = sizeLat,
           intercepts = intercepts,
           fade = fade,
           nCharNodes = 0,
           nCharEdges = 0)
  
  graph$graphAttributes$Edges$curve <- ifelse(graph$Edgelist$bidir, 1.5, 0)
  
  plot(graph)
}

